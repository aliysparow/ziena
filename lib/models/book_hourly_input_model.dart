import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/utils/methods_helpers.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/gen/locale_keys.g.dart';
import 'package:ziena/models/address_model.dart';
import 'package:ziena/models/hourly_package_model.dart';
import 'package:ziena/models/user_model.dart';

import '../core/widgets/select_item_sheet.dart';
import 'nationality_model.dart';

class BookHourlyInputModel {
  NationalityModel? nationality;
  SelectModel? period;
  // DateTime? time;
  AddressModel? address;
  HourlyPackageModel? package;
  List<DateTime> dates = [];
  List<int> week = [];
  final phone1 = TextEditingController();
  final phone2 = TextEditingController();
  bool acceptTerms = false;

  bool showPackage(HourlyPackageModel package) {
    if (nationality != null && period != null) {
      if ((nationality?.id == '' || nationality == package.nationality) && (period?.id == '' || period?.id == package.shift)) {
        return true;
      } else {
        return false;
      }
    } else if (nationality != null) {
      if (nationality == package.nationality) {
        return true;
      } else {
        return false;
      }
    } else if (period != null) {
      if (period?.id == package.shift) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  bool validate(BuildContext context) {
    if (NamedRoutes.hourlyService == context.currentRoute) {
      if (nationality == null) {
        FlashHelper.showToast(LocaleKeys.please_select_nationality.tr(), type: MessageType.warning);
        return false;
      } else if (period == null) {
        FlashHelper.showToast(LocaleKeys.please_select_period.tr(), type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else if (NamedRoutes.selectAddress == context.currentRoute) {
      if (address == null) {
        FlashHelper.showToast(LocaleKeys.please_select_address.tr(), type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else if (NamedRoutes.selectDates == context.currentRoute) {
      if (week.length != package!.totalVisits) {
        FlashHelper.showToast(LocaleKeys.please_select_all_week_days.tr(), type: MessageType.warning);
        return false;
      } else if (dates.isEmpty) {
        FlashHelper.showToast(LocaleKeys.please_select_package_start_day.tr(), type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else if (NamedRoutes.summaryHourlyService == context.currentRoute) {
      if (phone1.text.isEmpty) {
        FlashHelper.showToast(LocaleKeys.please_enter_additional_phone.tr(), type: MessageType.warning);
        return false;
      } else if (!acceptTerms) {
        FlashHelper.showToast(LocaleKeys.please_agree_to_zeina_s_terms_and_conditions.tr(), type: MessageType.warning);
        return false;
      } else {
        return true;
      }
    } else {
      throw 'Not implemented yet';
    }
  }

  Map<String, dynamic> toJson() => {
        "ServiceID": package?.service,
        "PackageId": package?.id,
        "StartDate": DateFormat('yyyy-MM-dd', 'en').format(dates.first),
        "DaysPerWeek": dates.map((e) => e.weekday).join(','),
        "FixedWorker": false,
        "ContactId": UserModel.i.contactId,
        "AddressId": address?.id,
        "Source": Platform.isIOS ? '2' : '1',
        "Mobile01": UserModel.i.phone,
        "Mobile02": MethodsHelpers.formatPhoneNumber(phone1.text),
        "Mobile03": MethodsHelpers.formatPhoneNumber(phone2.text),
      };
}
