import 'package:flutter/material.dart';
import 'package:storyly_flutter/storyly_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StorylyViewController storylyViewController;

  @override
  void initState() {
    super.initState();
  }

  void onStorylyViewCreated(StorylyViewController storylyViewController) {
    this.storylyViewController = storylyViewController;
    // You can call any function after this.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          height: 120,
          child: StorylyView(
            onStorylyViewCreated: onStorylyViewCreated,
            androidParam: StorylyParam()
            ..storylyId = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjExNzIsImFwcF9pZCI6Nzg0LCJpbnNfaWQiOjc4MX0.YxMpnoqNPx8rnUjRT1_7ql4zcpsoDwbX9bJryhGQqPA",
            iosParam: StorylyParam()
            ..storylyId = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjExNzIsImFwcF9pZCI6Nzg0LCJpbnNfaWQiOjc4MX0.YxMpnoqNPx8rnUjRT1_7ql4zcpsoDwbX9bJryhGQqPA",
            storylyLoaded: (storyGroupList) => print("storylyLoaded"),
            storylyLoadFailed: (errorMessage) => print("storylyLoadFailed"),
            storylyActionClicked: (story) => print("storylyActionClicked"),
            storylyStoryShown: () => print("storylyStoryShown"),
            storylyStoryDismissed: () => print("storylyStoryDismissed")
          ),
        ),
      ),
    );
  }
}
