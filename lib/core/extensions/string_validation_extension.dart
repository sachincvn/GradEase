extension StringValidation on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    return length >= 6;
  }

  bool isValidIndianPhoneNumber() {
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(this);
  }
}
