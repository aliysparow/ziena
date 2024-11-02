import 'package:flutter/cupertino.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/models/address_model.dart';
import 'package:ziena/models/hourly_package_model.dart';

import '../core/widgets/select_item_sheet.dart';
import 'nationality_model.dart';

class BookHourlyInputModel {
  NationalityModel? nationality;
  SelectModel? period;
  DateTime? time;
  AddressModel? address;
  HourlyPackageModel? packageModel;
  List<DateTime> dates = [];

  bool validate(BuildContext context) {
    if (NamedRoutes.hourlyService == context.currentRoute) {
      if (nationality == null) {
        FlashHelper.showToast('الرجاء اختيار الجنسية', type: MessageType.warning);
        return false;
      } else if (period == null) {
        FlashHelper.showToast('الرجاء اختيار الفترة', type: MessageType.warning);
        return false;
      } else if (time == null) {
        FlashHelper.showToast('الرجاء اختيار الوقت', type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else if (NamedRoutes.selectAddress == context.currentRoute) {
      if (address == null) {
        FlashHelper.showToast('الرجاء اختيار العنوان', type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else if (NamedRoutes.selectDates == context.currentRoute) {
      if (dates.length != packageModel!.totalVisits) {
        FlashHelper.showToast('الرجاء جميع الزيارات', type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else {
      throw 'Not implemented yet';
    }
  }

  Map<String, dynamic> toJson() => {
        "Nationality": nationality,
        "Period": period,
      };
}
