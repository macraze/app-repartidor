class LoginHelper {
  static String formatNumberDocument(String? number) {
    if (number == null) {
      return '-';
    } else if (number.length <= 20) {
      return number;
    } else {
      return '${number.substring(0, 25)}...';
    }
  }

  static String formatTypeDocument(String? type) {
    if (type == null) {
      return '';
    } else if (type == 'DNI') {
      return 'DNI ';
    } else if (type == 'PASAPORTE') {
      return 'PAS ';
    } else if (type == 'OTROS') {
      return 'OTR ';
    } else {
      return '';
    }
  }
}
