import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  String get title => "Cse Course List";

  @override
  State<CourseList> createState() => _CourseListState();
}
class _CourseListState extends State<CourseList> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body:
      Stack(
        children: [
          WebView(
            initialUrl: 'https://cse.primeasia.edu.bd/academics-courses',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_){
              setState(() {
                isLoading = false;
              });
            },
          ),
        if (isLoading)
          Center(
            child: LoadingAnimationWidget.waveDots(
              size: 60, color: Colors.lightBlueAccent,
            ),
          )
        ],
      ),
    );
  }
}
