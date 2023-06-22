import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    Dataflow flow = context.watch<Dataflow>();

    return Scaffold(
      appBar: AppBar(
        title: Text(flow.data[flow.view].name),
      ),

      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(
            Uri.parse(flow.data[flow.view].instructions)
          )
      ),
    );
  }
}
