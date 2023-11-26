class Validators {

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese un nombre de usuario';
    if (value.length < 3) return 'El nombre de usuario debe tener al menos 3 caracteres';
    if (value.length > 50) return 'El nombre de usuario debe tener máximo 50 caracteres';
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese una contraseña';
    if (value.length < 3) return 'La contraseña debe tener al menos 3 caracteres';
    if (value.length > 50) return 'La contraseña debe tener máximo 50 caracteres';
    return null;
  }

}
