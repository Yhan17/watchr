import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class WatchStorage {
  final FirebaseStorage _firebaseStorage;

  WatchStorage(this._firebaseStorage);
  Future<String> uploadImage({
    required String uuid,
    required File image,
  }) async {
    final reference = _firebaseStorage.ref().child('watches');
    final uploadTask = reference.child(uuid).putFile(
          image,
          SettableMetadata(
            contentType: 'image/png',
          ),
        );

    final result = await uploadTask;
    final path = await result.ref.getDownloadURL();

    return path;
  }

  Future<void> deleteImage(String id) async {
    await _firebaseStorage.ref().child('watches/$id').delete();
  }
}
