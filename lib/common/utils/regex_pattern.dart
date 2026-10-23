class RegexPattern {
  static final RegExp email = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  static final RegExp phone = RegExp(r'^(0|\+84)\d{9}$');
}
