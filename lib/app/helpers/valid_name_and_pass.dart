extension extString on String {

  // Metodo para validar username
  bool get isValidUsername {
    // Verificar el username ingresado si tiene el formato correcto
    final nameRegExp = RegExp(r'^[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*$');
    return nameRegExp.hasMatch(this);
  }

  // Metodo para validar password
  bool get isValidPassword {
    // Verificar la contraseña ingresado si tiene el formato correcto
    final passwordRegExp = RegExp(
        r'^(?=.*[0-9])(?=.*[.,#-])(?=.*[A-Z])(?=.*[a-z])[a-zA-Z0-9.,#-]{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  // En caso de no esta vacio retorna null
  bool get isNotNull {
    return this != null;
  }
}