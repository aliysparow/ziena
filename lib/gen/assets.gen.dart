/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/camera.svg
  String get camera => 'assets/icons/camera.svg';

  /// File path: assets/icons/delete.svg
  String get delete => 'assets/icons/delete.svg';

  /// File path: assets/icons/duration.svg
  String get duration => 'assets/icons/duration.svg';

  /// File path: assets/icons/edit.svg
  String get edit => 'assets/icons/edit.svg';

  /// File path: assets/icons/gallery.svg
  String get gallery => 'assets/icons/gallery.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/home_active.svg
  String get homeActive => 'assets/icons/home_active.svg';

  /// File path: assets/icons/nationality.svg
  String get nationality => 'assets/icons/nationality.svg';

  /// File path: assets/icons/orders.svg
  String get orders => 'assets/icons/orders.svg';

  /// File path: assets/icons/price.svg
  String get price => 'assets/icons/price.svg';

  /// File path: assets/icons/time.svg
  String get time => 'assets/icons/time.svg';

  /// List of all assets
  List<String> get values => [
        camera,
        delete,
        duration,
        edit,
        gallery,
        home,
        homeActive,
        nationality,
        orders,
        price,
        time
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bussniess_service.svg
  String get bussniessService => 'assets/images/bussniess_service.svg';

  /// File path: assets/images/hour_service.svg
  String get hourService => 'assets/images/hour_service.svg';

  /// File path: assets/images/logo.svg
  String get logo => 'assets/images/logo.svg';

  /// File path: assets/images/logo_auth.svg
  String get logoAuth => 'assets/images/logo_auth.svg';

  /// File path: assets/images/month_service.svg
  String get monthService => 'assets/images/month_service.svg';

  /// File path: assets/images/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding1.png');

  /// File path: assets/images/onboarding2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding2.png');

  /// File path: assets/images/onboarding3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding3.png');

  /// File path: assets/images/onboardinglogo1.png
  AssetGenImage get onboardinglogo1 =>
      const AssetGenImage('assets/images/onboardinglogo1.png');

  /// File path: assets/images/onboardinglogo2.png
  AssetGenImage get onboardinglogo2 =>
      const AssetGenImage('assets/images/onboardinglogo2.png');

  /// File path: assets/images/onboardinglogo3.png
  AssetGenImage get onboardinglogo3 =>
      const AssetGenImage('assets/images/onboardinglogo3.png');

  /// File path: assets/images/successfully.svg
  String get successfully => 'assets/images/successfully.svg';

  /// File path: assets/images/zeina_logo.png
  AssetGenImage get zeinaLogo =>
      const AssetGenImage('assets/images/zeina_logo.png');

  /// List of all assets
  List<dynamic> get values => [
        bussniessService,
        hourService,
        logo,
        logoAuth,
        monthService,
        onboarding1,
        onboarding2,
        onboarding3,
        onboardinglogo1,
        onboardinglogo2,
        onboardinglogo3,
        successfully,
        zeinaLogo
      ];
}

class $AssetsLocalizationGen {
  const $AssetsLocalizationGen();

  /// File path: assets/localization/ar-SA.json
  String get arSA => 'assets/localization/ar-SA.json';

  /// File path: assets/localization/en-USA.json
  String get enUSA => 'assets/localization/en-USA.json';

  /// List of all assets
  List<String> get values => [arSA, enUSA];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/successfly.json
  String get successfly => 'assets/lottie/successfly.json';

  /// List of all assets
  List<String> get values => [successfly];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLocalizationGen localization = $AssetsLocalizationGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
