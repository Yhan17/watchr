import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../infra/firebase/watch_storage.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (_) => FirebaseAuth.instance,
);

final firestoreProvider = Provider(
  (_) => FirebaseFirestore.instance,
);

final firebaseStorage = Provider(
  (_) => FirebaseStorage.instance,
);

final watchStorageProvider = Provider(
  (ref) => WatchStorage(ref.read(firebaseStorage)),
);

final uuidProvider = Provider(
  (_) => const Uuid(),
);
