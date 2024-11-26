import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/contracts_cubit.dart';

class MyOrdersView extends StatefulWidget {
  final OrdersType type;

  const MyOrdersView({super.key, required this.type});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          widget.type.name,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomErrorWidget(
        title: widget.type.name,
        subtitle: LocaleKeys.this_feature_is_coming_soon.tr(),
        image: Assets.images.logo,
      ).center,
    );
  }
}
