import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindtunes/core/error/exceptions.dart';
import 'package:mindtunes/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:mindtunes/features/auth/data/models/user_model.dart';

class AuthRemoteSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  AuthRemoteSourceImpl(this.firebaseAuth, this.firebaseFirestore);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw const ServerException("User is null");
      }

      final userCollection = firebaseFirestore.collection("users");

      final uid = response.user?.uid;

      final docSnapshot = await userCollection.doc(uid).get();

      if (docSnapshot.exists) {
        // Convert document snapshot data to UserModel object
        final userData = UserModel.fromSnapshot(docSnapshot);

        return userData;
      } else {
        // Document doesn't exist
        throw const ServerException("User Data not found");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException("User is null");
      }

      final userCollection = firebaseFirestore.collection("users");
      final uid = response.user?.uid;

      final newUser = UserModel(
        email: email,
        id: uid.toString(),
        name: name,
      );

      userCollection.doc(uid).set(newUser.toDocument());

      return newUser;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final uid = firebaseAuth.currentUser?.uid;

      if (uid != null) {
        final userdata = getUserData(uid: uid);
        return userdata;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserData({required String uid}) async {
    final userCollection = firebaseFirestore.collection("users");

    final docSnapshot = await userCollection.doc(uid).get();

    if (docSnapshot.exists) {
      // Convert document snapshot data to UserModel object
      final userData = UserModel.fromSnapshot(docSnapshot);

      return userData;
    } else {
      // Document doesn't exist
      throw const ServerException("User Data not found");
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
