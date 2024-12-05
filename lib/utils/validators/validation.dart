class AppValidator {
  static String? validateOthers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập trường này.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Vui lòng nhập đúng định dạng email.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Độ dài mật khẩu phải lớn hơn 6 chữ số.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải có ít nhất 1 chữ cái viết hoa.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải có ít nhất 1 số.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu phải có 1 chữ cái đặc biệt.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại.';
    }
    // 10 chữ số bắt đầu bằng số 0
    // 11 chữ số bắt đầu bằng số 0 và theo sau là mã quốc gia +84
    // Số điện thoại cơ bản: 0987654321
    // Số điện thoại có mã quốc gia: +84987654321
    final phoneRegExp = RegExp(r'^(\+84|0)?\d{9,10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Vui lòng nhập đúng định dạng số điện thoại.';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ và tên.';
    }
    return null;
  }

  static String? validateRePassword(String? password, rePassword) {
    if (rePassword == null || rePassword.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu.';
    } else if (password != rePassword) {
      return 'Vui lòng nhập đúng mật khẩu.';
    }
    return null;
  }

  static String? checkboxTerm(bool? value) {
    if (value == false) {
      return 'Vui lòng đồng ý điều khoản.';
    }
    return null;
  }
}
