import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';

import '../../../../blocs/cities/cities_bloc.dart';
import '../../../../blocs/cities/cities_state.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/select_item_sheet.dart';
import '../../../../gen/locale_keys.g.dart';
import '../../../../models/city_model.dart';

class SelectCityWidget extends StatefulWidget {
  final Function(CityModel value)? onSelected;
  final String? initId;
  const SelectCityWidget({super.key, this.onSelected, this.initId});

  @override
  State<SelectCityWidget> createState() => _SelectCityWidgetState();
}

class _SelectCityWidgetState extends State<SelectCityWidget> {
  final bloc = sl<CitiesBloc>()..getCities();
  CityModel? selected;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CitiesBloc, CitiesState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.requestState.isDone) {
          final i =
              bloc.cities.indexWhere((element) => element.id == widget.initId);
          if (i != -1) {
            selected = bloc.cities[i];
          }
        }
      },
      builder: (context, state) {
        return AppField(
          hintText: LocaleKeys.select_city.tr(),
          prefixIcon: Icon(Icons.place_outlined,
              size: 18.h, color: context.secondaryColor),
          controller: TextEditingController(text: selected?.name ?? ''),
          onTap: () {
            if (state.requestState.isDone) {
              showModalBottomSheet(
                context: context,
                builder: (context) => SelectItemSheet(
                  title: LocaleKeys.select_city.tr(),
                  items: bloc.cities,
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
