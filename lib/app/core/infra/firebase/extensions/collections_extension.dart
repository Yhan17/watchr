import 'package:cloud_firestore/cloud_firestore.dart';

typedef _Reference = CollectionReference<Map<String, dynamic>>;

extension CollectionsX on FirebaseFirestore {
  // ignore: library_private_types_in_public_api
  _Reference get watchesReference => collection('watches');
}
