import 'package:data_class_plugin/data_class_plugin.dart';

@Enum(
  $toString: true,
  fromJson: true,
  toJson: true,
)
enum RoomsEventsType { join, leave, message }
