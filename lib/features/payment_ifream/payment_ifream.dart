import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_circle_icon.dart';

class PaymentIfream extends StatefulWidget {
  final String id;
  const PaymentIfream({super.key, required this.id});

  @override
  State<PaymentIfream> createState() => _PaymentIfreamState();
}

class _PaymentIfreamState extends State<PaymentIfream> {
  //static const String paymentUrl = "http://93.112.2.209:8004/payment/payment?id=${widget.contractId}&ContractType=2";
  late final WebViewController controller;
  @override
  void initState() {
    final uri = Uri.parse(AppConstants.paymentUrl)..queryParameters.addAll({'id': widget.id});
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
        backgroundColor: context.scaffoldBackgroundColor,
        leadingWidth: 56.w,
        leading: CustomRadiusIcon(
          onTap: () => Navigator.pop(context),
          size: 40.w,
          backgroundColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          borderColor: context.hoverColor,
          child: Icon(
            CupertinoIcons.back,
            size: 24.h,
            color: context.primaryColor,
          ),
        ).toTopEnd,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
