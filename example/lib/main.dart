import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hyper_webview_flutter/hyper_webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  String url = "http://localhost:4200";
  runApp(WebviewPaymentPage(url: url,));
}

class WebviewPaymentPage extends StatefulWidget {
  String url;
  late HyperWebviewFlutter _hyperWebviewFlutterPlugin;

  WebviewPaymentPage({super.key, required this.url});

  @override
  State<WebviewPaymentPage> createState() => _WebviewPaymentPageState();
}

class _WebviewPaymentPageState extends State<WebviewPaymentPage> {
  late WebViewController _controller;
  @override
  void initState() {
    var url = Uri.parse(widget.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(url);
    // WidgetsFlutterBinding.ensureInitialized();
    widget._hyperWebviewFlutterPlugin = HyperWebviewFlutter();
    widget._hyperWebviewFlutterPlugin.attach(_controller);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return MaterialApp(
        title: 'Flutter PaymentPage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home : Scaffold(
          body: WebViewWidget(
              controller: _controller
          ),
        )
      // home: HomeScreen(
      //   hyperSDK: hyperSDK,
      // ),
    );
  }
}
