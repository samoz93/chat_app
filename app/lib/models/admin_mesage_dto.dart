import 'package:app/models/sealed_classes.dart';
import 'package:data_class_plugin/data_class_plugin.dart';

part 'admin_mesage_dto.gen.dart';

@DataClass(
  $toString: true,
  copyWith: true,
  toJson: true,
  fromJson: true,
)
abstract class AdminMessage extends Message {
  AdminMessage.ctor();

  /// Default constructor
  factory AdminMessage({
    required String message,
    String? room,
    required String receiver,
    required String sender,
  }) = _$AdminMessageImpl;

  @override
  String get message;

  @override
  String? get room;

  @override
  String get receiver;

  String get sender;

  @override
  int get createdAt => DateTime.now().millisecondsSinceEpoch;

  /// Creates an instance of [AdminMessage] from [json]
  factory AdminMessage.fromJson(Map<dynamic, dynamic> json) =
      _$AdminMessageImpl.fromJson;

  /// Converts [AdminMessage] to a [Map] json
  Map<String, dynamic> toJson();
}
