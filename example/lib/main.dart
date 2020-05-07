import 'package:flutter/material.dart';
import 'package:notification_banner/notification_banner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Banner Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text('Default from top'),
              onPressed: () {
                NotificationBanner(context)
                  ..setMessage('Default from top')
                  ..show(Appearance.top);
              }
            ),
            MaterialButton(
              child: Text('Default from bottom'),
              onPressed: () {
                NotificationBanner(context)
                  ..setMessage('Default from bottom')
                  ..show(Appearance.bottom);
              }
            ),
            MaterialButton(
              child: Text('Changed background color'),
              onPressed: () {
                NotificationBanner(context)
                  ..setMessage('Different color')
                  ..setBgColor(Colors.brown)
                  ..show(Appearance.top);
              }
            ),
            MaterialButton(
              child: Text('Changed text style'),
              onPressed: () {
                NotificationBanner(context)
                  ..setMessage('Changed text style')
                  ..setTextStyle(TextStyle(
                    color: Colors.purple,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic
                  ))
                  ..show(Appearance.top);
              }
            ),
            MaterialButton(
              child: Text('Changed border radius'),
              onPressed: () {
                NotificationBanner(context)
                  ..setMessage('Changed border radius')
                  ..setBorderRadius(16.0)
                  ..show(Appearance.top);
              }
            ),
            MaterialButton(
              child: Text('Custom body'),
              onPressed: () {
                NotificationBanner(context)
                  ..setBody(Container(
                      color: Colors.green,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                      ),
                    )
                  )
                  ..show(Appearance.top);
              }
            ),
          ],
        ),
      ),
    );
  }
}