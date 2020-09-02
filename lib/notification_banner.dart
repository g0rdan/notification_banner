import 'package:flutter/material.dart';
import 'package:notification_banner/notification_alert.dart';

/// Body widget is needed for finding size of the body after rendering
class BodyWidget extends StatefulWidget {
  final Function(Size) onRendered;
  final Widget body;

  BodyWidget({@required this.onRendered, @required this.body, Key key})
      : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.body);
  }

  _afterLayout(_) {
    var renderBox = this.context.findRenderObject() as RenderBox;
    widget.onRendered(renderBox.size);
  }
}

enum Appearance { top, bottom }

class NotificationBanner {
  final BuildContext context;
  Widget _body;
  VoidCallback _onTapped;
  double _padding = 40;
  Duration _timeout = Duration(seconds: 3);
  Duration _transitionDuration = Duration(milliseconds: 200);
  double _shadowOpacity = 0.01;
  bool _keepAlive = false;
  Color _bgColor = Color.fromRGBO(44, 52, 67, 1);
  String _message;
  TextStyle _textStyle;
  double _borderRadius = 6.0;

  NotificationBanner(this.context);

  void setMessage(String message) {
    assert(message.isNotEmpty, 'Message can\'t be null or empty');
    _message = message;
  }

  void setBody(Widget body) {
    assert(body != null, 'Body can\'t be null');
    _body = body;
  }

  void setTapCallback(VoidCallback onTapped) {
    assert(onTapped != null, 'Callback can\'t be null');
    _onTapped = onTapped;
  }

  /// Padding between edge of screen and banner
  void setPadding(double padding) {
    assert(padding != null, 'Padding can\'t be null');
    _padding = padding;
  }

  void setTimeout(Duration timeout) {
    assert(timeout != null, 'Timeout can\'t be null');
    _timeout = timeout;
  }

  void setTransitionDuration(Duration transition) {
    assert(transition != null, 'Transition can\'t be null');
    _transitionDuration = transition;
  }

  void setShadowOpacity(double opacity) {
    assert(opacity != null, 'Opacity can\'t be null');
    _shadowOpacity = opacity;
  }

  void setBgColor(Color color) {
    assert(color != null, 'Color can\'t be null');
    _bgColor = color;
  }

  void setTextStyle(TextStyle textStyle) {
    assert(textStyle != null, 'TextStyle can\'t be null');
    _textStyle = textStyle;
  }

  void setBorderRadius(double radius) {
    assert(radius != null, 'Radius can\'t be null');
    _borderRadius = radius;
  }

  void keepAlive() {
    _keepAlive = true;
  }

  void show(Appearance appearance) {
    assert(
        appearance != null, 'You need to clarify where the banner will appear');

    Size _size = Size.zero;
    var halfOfScreenHeight = MediaQuery.of(context).size.height * 0.5;
    bool hasBeenShown = false;
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(_shadowOpacity),
        transitionBuilder: (context, a1, a2, widget) {
          if (!_keepAlive) {
            Future.delayed(_timeout, () {
              if (!hasBeenShown) {
                Navigator.pop(context);
              }
              hasBeenShown = true;
            });
          }
          Offset offset = appearance == Appearance.top
              ? Offset(
                  0,
                  -halfOfScreenHeight +
                      (_size != Size.zero ? _size.height / 2 : 0) +
                      _padding * a1.value)
              : Offset(
                  0,
                  halfOfScreenHeight -
                      (_size != Size.zero ? _size.height / 2 : 0) -
                      _padding * a1.value);
          return Transform.translate(
            offset: offset,
            child: Opacity(
                opacity: a1.value,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: NotificationDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_borderRadius)),
                      backgroundColor: _bgColor,
                      child: Container(
                          color: Colors.transparent,
                          child: GestureDetector(
                              onTap: () {
                                if (_onTapped != null) {
                                  _onTapped();
                                }
                              },
                              child: BodyWidget(
                                body: _body != null
                                    ? _body
                                    // default body for the notification
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            _message,
                                            style: _textStyle != null
                                                ? _textStyle
                                                : TextStyle(
                                                    color: Color.fromRGBO(
                                                        230, 91, 103, 1.0),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                          ),
                                        )),
                                onRendered: (size) {
                                  _size = size;
                                },
                              )))),
                )),
          );
        },
        transitionDuration: _transitionDuration,
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context3, animation1, animation2) {
          return null;
        });
  }
}
