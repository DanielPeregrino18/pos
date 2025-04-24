import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';
@JsonSerializable()
class UserModel {
  @JsonKey(name: 'Email')
  String email;
  @JsonKey(name: 'Password')
  String password;

  UserModel(this.email, this.password);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}