// ignore_for_file: constant_identifier_names

enum ResticCommandOptionType {
  repo,
  password_file,
  group_by,
  target,
  overwrite,
  //TBD sort
}

enum ResticGroupByOptionTypeValues {
  host,
  paths,
  tags,
}

enum ResticOverwriteOptionTypeValues {
  always,
  if_changed,
  if_newer,
  never,
}
