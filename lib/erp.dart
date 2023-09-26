import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter/webview_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ERP extends StatefulWidget {
  const ERP({super.key});
  String get title => 'ERP';
  @override
  State<ERP> createState() => _ERPState();
}

class _ERPState extends State<ERP> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.erp.primeasia.edu.bd/dashboard',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_){
              setState(() {
                isLoading = false;
              });
            },
          ),
          if(isLoading)
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
