import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.id,
    required super.name,
  });

//   factory UserModel.fromJson(User user) {
//     return UserModel(
//       email: map['email'] ?? '',
//       id: map['email'] ?? '',
//       name: map['name'] ?? '',
//     );
//   }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot.get('email'),
      id: snapshot.get('id'),
      name: snapshot.get('name'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "email": email,
      "id": id,
      "name": name,
    };
  }
}
