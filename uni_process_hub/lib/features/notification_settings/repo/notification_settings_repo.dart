import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationSettingsRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  NotificationSettingsRepo({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> _docRefForUid(String uid) {
    return _firestore.doc('users/$uid/settings/notifications');
  }

  Future<void> saveSettings(String uid, Map<String, dynamic> map) async {
    final doc = _docRefForUid(uid);
    await doc.set(map, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchSettings(String uid) {
    return _docRefForUid(uid).snapshots();
  }

  Future<void> saveFcmToken(String uid, String token) async {
    final ref = _firestore.doc('users/$uid/fcm');
    await ref.set({'token': token, 'lastUpdated': FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }
}
