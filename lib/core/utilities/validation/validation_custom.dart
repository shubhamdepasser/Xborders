import 'package:xborders/core/utilities/validation/validator_service.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:get/get.dart';
//import 'package:/module/app_module.dart';

class ValidationCustom {
  static emailValidation(String value) {
    if (value.isNotEmpty && !GetUtils.isEmail(value.trim())) {
      return Variable.ThisEmailValid;
    } else if (value.isEmpty) {
      return Variable.ValueRequired;
    }
    return null;
  }

  static emailOptionalValidation(String value) {
    if (value.isNotEmpty && !GetUtils.isEmail(value.trim())) {
      return Variable.ThisEmailValid;
    } else if (value.isEmpty) {
      return null;
    }
    return null;
  }

  static requiredValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    }
    return null;
  }

  static nameOptionalValidation(String value) {
    if (value.isEmpty) {
      return null;
    }
    return null;
  }

  static panCardValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length != 10 ||
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.lengthInvalid10;
    }
    return null;
  }

  static adharCardValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty && !Validator.isNumeric(value.toLowerCase())) {
      return Variable.allowed5to16Numeric;
    } else if (value.isNotEmpty && value.length < 5) {
      return Variable.allowed5to16Numeric;
    } else if (value.isNotEmpty && value.length > 17) {
      return Variable.allowed5to16Numeric;
    }
    return null;
  }

  static document2Validation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty &&
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowed5to30Numeric;
    } else if (value.isNotEmpty && value.length < 5) {
      return Variable.allowed5to30Numeric;
    } else if (value.isNotEmpty && value.length > 31) {
      return Variable.allowed5to30Numeric;
    }
    return null;
  }

  static cinValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length != 21 ||
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowed21Alpha;
    }
    return null;
  }

  static cinOptionalValidation(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length != 21 ||
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowed21Alpha;
    }
    return null;
  }

  static documentValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty && value.length <= 4) {
      return Variable.LengthBetween5To30;
    } else if (value.isNotEmpty && value.length >= 29) {
      return Variable.LengthBetween5To30;
    }
    return null;
  }

  static number10Validation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length != 10) {
      return Variable.phoneLength10;
    }
    return null;
  }

  static numberOptionalValidation(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length != 10) {
      return Variable.phoneLength10;
    }
    return null;
  }

  static numberOptionalDigitValidation(String value, int number) {
    if (value.isEmpty) {
      return null;
    } else if (value.length != number) {
      return Variable.lengthInvalid + number.toString();
    }
    return null;
  }

  static websiteValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (!Validator.isUrlValid(value)) {
      return Variable.UrlRequired;
    }
    return null;
  }

  static websiteOptionalValidation(String value) {
    if (value.isEmpty) {
      return null;
    } else if (!Validator.isUrlValid(value)) {
      return Variable.UrlRequired;
    }
    return null;
  }

  static gstNoValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length != 15 ||
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowed15Alpha;
    }
    return null;
  }

  static gstOptionalValidation(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length != 15 ||
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowed15Alpha;
    }
    return null;
  }

  static enter21Validation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length != 21) {
      return Variable.Enter21Alpha;
    }
    return null;
  }

  static pinCodeValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty && value.length < 6) {
      return Variable.pinCodeLength;
    }
    return null;
  }

  static prefixValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty &&
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.allowedPrefix;
    }
    return null;
  }

  static suffixValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.length >= 11 || !Validator.isNumeric(value)) {
      return Variable.allowedSuffix;
    }
    return null;
  }

  static numberValidation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    }
    return null;
  }

  static upTo100Validation(String value) {
    if (value.isEmpty) {
      return Variable.ValueRequired;
    } else if (value.isNotEmpty && value.length >= 100) {
      return Variable.Length100;
    }
    return null;
  }

  static upTo100ValidationOptional(String value) {
    if (value.isEmpty) {
      return null;
    } else if (value.isNotEmpty && value.length >= 100) {
      return Variable.Length100;
    }
    return null;
  }

  static passwordValidation(String value) {
    if (value.isNotEmpty &&
        value[0] != null &&
        value[0] != value[0].toUpperCase()) {
      return Variable.passwordFirstCapital;
    } else if (value.isNotEmpty && !Validator.isSpecialCharacter(value)) {
      return Variable.passwordSpecialCharacter;
    } else if (value.isNotEmpty &&
        !Validator.isAlphanumeric(value.toLowerCase())) {
      return Variable.passwordAlphaNumeric;
    } else if (value.isNotEmpty && value.length <= 7) {
      return Variable.passwordLength8;
    } else if (value.isEmpty) {
      return Variable.ValueRequired;
    }
    return null;
  }

  static passwordSameValidation(String value, String confirm) {
    if (value.isNotEmpty && value != confirm) {
      return Variable.valueSamePassword;
    } else if (value.isEmpty) {
      return Variable.ValueRequired;
    }
    return null;
  }
}

class ValidationDigit {
  static const int pinCode = 6;
  static const int mobile = 10;
  static const int gst = 15;
  static const int cin = 21;
  static const int address = 100;
  static const int document2 = 30;
  static const int adharCard = 16;
}
