import 'package:app/models/user_dto.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'auth_payload.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class AuthPayload {
  AuthPayload.ctor();

  /// Default constructor
  factory AuthPayload({
    required String token,
    required User user,
  }) = _$AuthPayloadImpl;

  String get token;
  User get user;

  /// Creates an instance of [AuthPayload] from [json]
  factory AuthPayload.fromJson(Map<dynamic, dynamic> json) =
      _$AuthPayloadImpl.fromJson;

  /// Converts [AuthPayload] to a [Map] json
  Map<String, dynamic> toJson();
}
