import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,

    required super.email,

    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],

      email: json["email"],

      role: json["role"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"uid": uid, "email": email, "role": role};
  }
}
