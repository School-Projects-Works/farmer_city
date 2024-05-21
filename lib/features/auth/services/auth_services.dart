import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../data/user_model.dart';

class AuthServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<(bool, String)> createUser(UserModel user) async {
    // create user
    try {
      //create firebase user
      final credential = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      //send email verification
      await credential.user!.sendEmailVerification();
      //create user in firestore
      if (credential.user != null) {
        user.id = credential.user!.uid;
        user.createdAt = DateTime.now().millisecondsSinceEpoch;
        CollectionReference users = firestore.collection('users');
        await users.doc(user.id).set(user.toMap());
        return (true, 'User created successfully, please verify your email');
      } else {
        return (false, 'User not created');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return (false, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return (false, 'The account already exists for that email.');
      }
      return (false, e.toString());
    } catch (e) {
      // handle error
      return (false, e.toString());
    }
  }

  static Future<(String, User?)> login(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return ('Login successful', credential.user);
      } else {
        return ('Login failed', null);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.', null);
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.', null);
      } else if (e.toString().contains('invalid') ||
          e.toString().contains('incorrect')) {
        return ('No user found for that email.', null);
      }
      return (e.toString(), null);
    } catch (error) {
      return ('Something went wrong..Try again', null);
    }
  }

  static Future<(String, UserModel)> getUserData(String uid) async {
    try {
      var user = await firestore.collection('users').doc(uid).get();
      if (user.exists) {
        return ('User found', UserModel.fromMap(user.data()!));
      } else {
        return ('User not found', UserModel());
      }
    } catch (e) {
      return (e.toString(), UserModel());
    }
  }

  static Future<UserModel> checkIfLoggedIn() async {
    var box = Hive.box('user');
    var user = box.get('id');
    if (user != null) {
      var (_, userData) = await getUserData(user);
      return userData;
    } else {
      return UserModel();
    }
  }

  static Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveUserData(UserModel user) async {
    CollectionReference users = firestore.collection('users');
    await users.doc(user.id).set(user.toMap());
  }

  static Future<List<UserModel>> getUserModel() async {
    var users = await firestore.collection('users').get();
    return users.docs.map((e) => UserModel.fromMap(e.data())).toList();
  }

  static Future<void> updateUserData(UserModel user) async {
    CollectionReference users = firestore.collection('users');
    await users.doc(user.id).update(user.toMap());
  }

  static Future<(String, String?)> uploadImage(
      XFile userProfile, String userId) async {
    try {
      var ref = storage.ref('profile_images').child('$userId.jpeg');
      var data = await userProfile.readAsBytes();
      await ref.putData(data, SettableMetadata(contentType: 'image/jpeg'));
      var url = await ref.getDownloadURL();
      return ('Image uploaded successfully', url);
    } catch (e) {
      return ('Error uploading image', null);
    }
  }
}
