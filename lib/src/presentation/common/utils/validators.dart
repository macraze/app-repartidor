class Validators {
  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese un nombre de usuario';
    if (value.length < 3) {
      return 'El nombre de usuario debe tener al menos 3 caracteres';
    }
    if (value.length > 50) {
      return 'El nombre de usuario debe tener máximo 50 caracteres';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese una contraseña';
    if (value.length < 3) {
      return 'La contraseña debe tener al menos 3 caracteres';
    }
    if (value.length > 50) {
      return 'La contraseña debe tener máximo 50 caracteres';
    }
    return null;
  }

  static String? mountValidator(int? value) {
    if (value == null || value == 0) return 'Ingrese un monto';
    if (value < 10) return 'El mínimo es 10';
    if (value > 1000) return 'El máximo es 1000';
    return null;
  }

  static String? orderCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un código';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'El código debe ser numérico';
    }
    if (value.length < 4) {
      return 'El código es mínimo 4 dígitos';
    }
    return null;
  }
}
