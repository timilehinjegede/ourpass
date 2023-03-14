class Validator {
  bool isEmailValid(String email) {
    if (email.trim().isEmpty) {
      return false;
    }

    final regex = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    );
    return regex.hasMatch(email);
  }

  bool isInputValid(String input) {
    return input.trim().length > 3;
  }
}
