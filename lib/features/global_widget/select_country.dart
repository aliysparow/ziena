import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/nationalities/nationalities_bloc.dart';
import '../../blocs/nationalities/nationalities_state.dart';
import '../../core/services/service_locator.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/app_field.dart';
import '../../core/widgets/select_item_sheet.dart';
import '../../gen/locale_keys.g.dart';
import '../../models/nationality_model.dart';

class SelectCountryWidget extends StatefulWidget {
  final Function(NationalityModel value)? onSelected;
  final String? initId;
  final String? lable;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  const SelectCountryWidget({
    super.key,
    this.onSelected,
    this.initId,
    this.lable,
    this.prefixIcon,
    this.validator,
  });

  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  final bloc = sl<NationalitiesBloc>()..getNationalities();
  NationalityModel? selected;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NationalitiesBloc, NationalitiesState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.requestState.isDone) {
          final i = bloc.nationalities.indexWhere((element) => element.id == widget.initId);
          if (i != -1) {
            selected = bloc.nationalities[i];
          }
        }
      },
      builder: (context, state) {
        return AppField(
          validator: widget.validator,
          title: widget.lable,
          hintText: LocaleKeys.select_city.tr(),
          prefixIcon: widget.prefixIcon,
          controller: TextEditingController(text: selected?.name ?? ''),
          onTap: () {
            if (state.requestState.isDone) {
              showModalBottomSheet(
                context: context,
                builder: (context) => SelectItemSheet(
                  title: LocaleKeys.select_city.tr(),
                  items: bloc.nationalities,
                  initItem: selected,
                ),
              ).then((v) {
                if (v != null) {
                  selected = v;
                  setState(() {});
                  widget.onSelected?.call(v);
                }
              });
            }
          },
        ).withPadding(vertical: 10.h);
      },
    );
  }
}
