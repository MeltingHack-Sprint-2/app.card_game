//Enum representing different type of validations
enum ValidationType {
  // None
  none,
  // names
  name,
  // numbers
  numbers,
  // username
  username,
}

extension Validation on String {
  //Checks if the string is valid based on the given validation type.
  bool isValidFor(ValidationType type) {
    RegExp regex;
    switch (type) {
      case ValidationType.none:
        return true;
      case ValidationType.name:
        regex = RegExp(r"^([A-Z][a-z]+)(-[A-Z][a-z]+)?\s*$");
        break;
      case ValidationType.username:
        regex = RegExp(r"^\s*([A-Za-z][A-Za-z0-9]*)\s*$");
        break;
      case ValidationType.numbers:
        regex = RegExp(r'^[0-9]*$');
        break;
    }
    //Return true if the string matches the regex, false otherwise
    return regex.hasMatch(this);
  }
}
