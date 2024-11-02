class MethodsHelpers {
  static String formatPhoneNumber(String phoneNumber) {
    String formattedNumber = phoneNumber.replaceFirst(RegExp(r'^0'), '');
    if (!formattedNumber.startsWith('0')) {
      formattedNumber = '0$formattedNumber';
    }

    return formattedNumber;
  }
}
