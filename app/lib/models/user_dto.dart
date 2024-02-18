import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:hive/hive.dart';

part 'user_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
@HiveType(typeId: 0)
abstract class User {
  User.ctor();

  /// Default constructor
  factory User({
    required String id,
    String email,
    required String name,
  }) = _$UserImpl;

  @HiveField(0)
  String get id;
  @HiveField(1)
  String? get email;
  @HiveField(2)
  String get name;

  /// Creates an instance of [User] from [json]
  factory User.fromJson(Map<dynamic, dynamic> json) = _$UserImpl.fromJson;

  /// Converts [User] to a [Map] json
  Map<String, dynamic> toJson();
}
