// Helper functions for validator and sanitizer.

import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/validation_custom.dart';
import 'package:xborders/core/utilities/validation/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:ithink_logistics/module/app_module.dart';

shift(List l) {
  if (l.isNotEmpty) {
    var first = l.first;
    l.removeAt(0);
    return first;
  }
  return null;
}

Map<String, Object> merge(
    Map<String, Object> obj, Map<String, Object> defaults) {
  if (obj == null) {
    return defaults;
  }
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}

class ValidationHelper {
  static String email = 'email';
  static String optionalEmail = 'optionalEmail';
  static String name = 'name';
  static String optionalName = 'optionalName';
  static String password = 'password';
  static String address = 'address';
  static String addressOptional = 'addressOptional';
  static String number = 'number';
  static String prefix = 'prefix';
  static String suffix = 'suffix';
  static String passwordConfirm = 'passwordConfirm';
  static String website = 'website';
  static String optionalWebsite = 'optionalWebsite';
  static String panCard = 'panCard';
  static String adharCard = 'adharCard';
  static String document2 = 'document2';
  static String pinCode = 'pinCode';
  static String mobile = 'mobile';
  static String optionalMobile = 'optionalMobile';
  static String fssaiNumber = 'fssaiNumber';
  static String gstNo = 'gstNo';
  static String gstNoOptional = 'gstNoOptional';
  static String cin = 'cin';
  static String cinOptional = 'cinOptional';

  static Widget displayText({String text}) => Text(text, style: normalRedStyle);

  static TextInputType displayInputType(
      {String validationType, TextInputType inputType}) {
    switch (validationType) {
      case 'email':
      case 'optionalEmail':
        return TextInputType.emailAddress;
      case 'mobile':
      case 'optionalMobile':
      case 'pinCode':
      case 'number':
        return TextInputType.number;
      case 'name':
      case 'optionalName':
        return TextInputType.text;
      default:
        return inputType;
    }
  }

  static dynamic checkFunction(
      {String type, String valueInput, String valueInputSecond}) {
    switch (type) {
      case 'email':
        return ValidationCustom.emailValidation(valueInput);
      case 'optionalEmail':
        return ValidationCustom.emailOptionalValidation(valueInput);
      case 'name':
        return ValidationCustom.requiredValidation(valueInput);
      case 'optionalName':
        return ValidationCustom.nameOptionalValidation(valueInput);
      case 'address':
        return ValidationCustom.upTo100Validation(valueInput);
      case 'addressOptional':
        return ValidationCustom.upTo100ValidationOptional(valueInput);
      case 'panCard':
        return ValidationCustom.panCardValidation(valueInput);
      case 'adharCard':
        return ValidationCustom.adharCardValidation(valueInput);
      case 'document2':
        return ValidationCustom.document2Validation(valueInput);
      case 'pinCode':
        return ValidationCustom.pinCodeValidation(valueInput);
      case 'number':
        return ValidationCustom.numberValidation(valueInput);
      case 'prefix':
        return ValidationCustom.prefixValidation(valueInput);
      case 'suffix':
        return ValidationCustom.suffixValidation(valueInput);
      case 'website':
        return ValidationCustom.websiteValidation(valueInput);
      case 'optionalWebsite':
        return ValidationCustom.websiteOptionalValidation(valueInput);
      case 'password':
        return ValidationCustom.passwordValidation(valueInput);
      case 'passwordConfirm':
        return ValidationCustom.passwordSameValidation(
            valueInput, valueInputSecond);
      case 'mobile':
        return ValidationCustom.number10Validation(valueInput);
      case 'optionalMobile':
        return ValidationCustom.numberOptionalValidation(valueInput);
      case 'fssaiNumber':
        return ValidationCustom.numberOptionalDigitValidation(valueInput, 14);
      case 'gstNo':
        return ValidationCustom.gstNoValidation(valueInput);
      case 'gstNoOptional':
        return ValidationCustom.gstOptionalValidation(valueInput);
      case 'cin':
        return ValidationCustom.cinValidation(valueInput);
      case 'cinOptional':
        return ValidationCustom.cinOptionalValidation(valueInput);
      default:
        return ValidationCustom.requiredValidation(valueInput);
    }
  }

  static List<TextInputFormatter> inputValidator(String value) {
    switch (value) {
      case 'mobile':
        return [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(Validator.mobile9Digit),
        ];
      case 'gstNoOptional':
        return [
          LengthLimitingTextInputFormatter(15),
          UpperCaseTextFormatter(),
        ];
      case 'adharCard':
        return [
          FilteringTextInputFormatter.allow(Validator.mobile9Digit),
          LengthLimitingTextInputFormatter(16)
        ];
      case 'suffix':
        return [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(Validator.mobile9Digit),
        ];
      case 'optionalMobile':
        return [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(Validator.mobile9Digit),
        ];
      case 'fssaiNumber':
        return [
          LengthLimitingTextInputFormatter(14),
          FilteringTextInputFormatter.allow(Validator.mobile9Digit),
        ];
      case 'pinCode':
        return [
          LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.allow(Validator.numeric),
        ];
      case 'gstNo':
        return [
          UpperCaseTextFormatter(),
          // LengthLimitingTextInputFormatter(15),
          // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
        ];
      case 'panCard':
        return [
          UpperCaseTextFormatter(),
        ];
      case 'document2':
        return [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(30),
        ];
      default:
        return null;
    }
  }

  static bool checkValidation({String type, String first, String secondValue}) {
    if (checkFunction(
            type: type, valueInput: first, valueInputSecond: secondValue) ==
        null) {
      return false;
    } else {
      return true;
    }
  }

  static bool checkValidationOptional(
      {String first, String type, String secondValue}) {
    if (first.length != 0) {
      if (checkFunction(
              type: type, valueInput: first, valueInputSecond: secondValue) ==
          null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  static checkIsEmpty(String value, bool isValue) {
    if (value.isNotEmpty) {
      isValue = false;
    } else {
      isValue = true;
    }
  }

  static String capitalize(String s) {
    if (s == null || s.isEmpty) {
      return s;
    }
    return s.length < 1 ? s.toUpperCase() : s[0].toUpperCase() + s.substring(1);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text?.toUpperCase(), selection: newValue.selection);
  }
}
