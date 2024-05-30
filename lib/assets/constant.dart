class Constants {
  static const maxDevice = 500;
}

class RegexCommon {
  RegexCommon._();

  static const phoneRegex = r'^(0)+(3|5|7|8|9)+([0-9]{8})$';
  static const emailRegex =
      r'^([A-Za-z0-9]+[\-\_\.])*[A-Za-z0-9]+@([A-Za-z0-9]+\-)*([A-Za-z0-9]+\.){1,2}[a-zA-Z]{2,4}$';
}
