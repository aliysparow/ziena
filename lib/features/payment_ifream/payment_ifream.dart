import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/core/widgets/custom_circle_icon.dart';
import 'package:ziena/gen/locale_keys.g.dart';

class PaymentIfream extends StatefulWidget {
  final String id;
  const PaymentIfream({super.key, required this.id});

  @override
  State<PaymentIfream> createState() => _PaymentIfreamState();
}

class _PaymentIfreamState extends State<PaymentIfream> {
  late final WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    final uri = Uri.parse(ApiConstants.paymentUrl + widget.id);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            isLoading = false;
            setState(() {});
          },
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
        title: Text(LocaleKeys.payment.tr()),
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(
                  controller: controller,
                ),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: context.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          if (!isLoading) SizedBox(height: 16.h),
          if (!isLoading)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppBtn(
                saveArea: false,
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.settings.name == NamedRoutes.layout,
                  );
                },
                title: LocaleKeys.go_to_home.tr(),
              ),
            ),
          if (!isLoading) SizedBox(height: 32.h)
        ],
      ),
    );
  }
}
