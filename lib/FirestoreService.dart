import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addItem(List<String> list) async {
    print("Add Data");
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null) {
      String email = user.email!;
      await _db.collection('users').doc(email).collection('items').add({
        'name': list[0],
        'surname': list[1],
        'phonenumber': list[2],
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Item added to Firestore.');
    } else {
      throw Exception('No user signed in');
    }
  }
  Future<Map<String, dynamic>?> getItem() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String email = user.email!;
        QuerySnapshot querySnapshot = await _db.collection('users').doc(email).collection('items').get();

        if (querySnapshot.docs.isNotEmpty) {
          var doc = querySnapshot.docs.first;
          return {
            'name': doc['name'],
            'surname': doc['surname'],
            'phonenumber': doc['phonenumber']
          };
        } else {
          return null; // No items found
        }
      } else {
        throw Exception('No user signed in');
      }
    } catch (e) {
      print('Error retrieving item: $e');
      return null;
    }
  }
}
