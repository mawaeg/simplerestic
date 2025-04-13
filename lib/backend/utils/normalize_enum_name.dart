/// Normalizes a command Enum name to a valid string that can be used for command execution
String normalizeCommandEnum(String command) {
  // Due to command options and flags having `-` in its name which can not be used for names in dart these are instead written with an `_` and then get "normalized"
  return "--${command.replaceAll("_", "-")}";
}
