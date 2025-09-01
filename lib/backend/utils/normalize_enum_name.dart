/// Normalizes a command Enum name to a valid string that can be used for command execution
String normalizeCommandEnum(String command, {bool isOption = true}) {
  // Due to command options and flags having `-` in its name which can not be used for names in dart these are instead written with an `_` and then get "normalized"
  String optionAddition = isOption ? "--" : "";
  return "$optionAddition${command.replaceAll("_", "-")}";
}
