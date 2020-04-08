library notification_banner;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationBanner {
  final BuildContext context;
  String _message;
  Widget _body;
  VoidCallback _onTapped;

  NotificationBanner(this.context);

  NotificationBanner setMessage(String message) {
    assert(message != null || message.isEmpty, 'Message can\'t be null or empty');
    
    // we prioritize setting body over plain message
    if (_body != null)
      return this;

    _message = message;
    _body = _getDefaultBody(_message);

    return this;
  }
  
  NotificationBanner setBody(Widget body) {
    assert(body != null, 'Body can\'t be null');

    _body = body;

    return this;
  }

  NotificationBanner setTapCallback(VoidCallback onTapped) {
    assert(onTapped != null, 'Callback can\'t be null');

    _onTapped = onTapped;

    return this;
  }
  
  void show(Appearance appearance) {
    assert(appearance != null, 'You need to clarify where the banner will appear');

    var halfOfHeight = MediaQuery.of(context).size.height * 0.5;
    bool hasBeenShown = false;
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.01),
      transitionBuilder: (context2, a1, a2, widget) {
        Future.delayed(Duration(seconds: 3), () {
          if(!hasBeenShown) {
            Navigator.pop(context2);
          }
          hasBeenShown = true;
        });
        Offset offset = appearance == Appearance.top
          ? Offset(0, -halfOfHeight + 120 * a1.value)
          : Offset(0, halfOfHeight - 120 * a1.value);
        return Transform.translate(
          offset: offset,
          child: Opacity(
            opacity: a1.value,
            child:  AlertDialog(
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                titlePadding: EdgeInsets.all(0),
                backgroundColor: Color.fromRGBO(44, 52, 67, 1),
                content: Container(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      if (_onTapped != null) {
                        _onTapped();
                      }
                    },
                    child: _body
                  )
                )
              ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context3, animation1, animation2) {
      }
    );
  }

  Widget _getDefaultBody(String message) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 28,
      child: Text(
        message,
        style: TextStyle(
          // fontFamily: 'Poppins',
          color: Color.fromRGBO(230, 91, 103, 1.0),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum Appearance { top, bottom }
