import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class WatchStorage {
  final FirebaseStorage _firebaseStorage;

  WatchStorage(this._firebaseStorage);
  Future<String> uploadImage({
    required String uuid,
    required File image,
  }) async {
    final reference = _firebaseStorage.ref().child('watches/$uuid');
    final uploadTask = reference.putFile(image);

    final result = await uploadTask;

    return result.ref.fullPath;
  }
}