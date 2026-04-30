import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> login({
    required String email,
    required String password,
  });

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  });

  Future<void> createUser({
    required String userId,
    required String name,
    required String email,
  });

  Future<void> completeUserProfile({
    required String userId,
    required String image,
    required String name,
    required String number,
    required String dob,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final data = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return data;
  }

  @override
  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    final data = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return data;
  }

  @override
  Future<void> createUser({
    required String userId,
    required String name,
    required String email,
  }) async {
   await firebaseFirestore.collection('user').doc(userId).set({
      'name': name,
      'id': userId,
      'email': email,
      'create_at': Timestamp.now(),
    });
  }

  @override
  Future<void> completeUserProfile({
    required String userId,
    required String image,
    required String name,
    required String number,
    required String dob,
  }) async {
   await firebaseFirestore.collection('user').doc(userId).update({
      "name": name,
      "image": image,
      'number': number,
      "dob": dob,
      'update_at': Timestamp.now(),
    });
  }
}
