import 'package:contactapp/AddContact.dart';
import 'package:contactapp/LoginScreen.dart';
import 'package:contactapp/No_contact.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
class YourWidgetName extends StatefulWidget {
  final String enteredemail;
  const YourWidgetName(this.enteredemail, {super.key});
  
  @override
  _YourWidgetNameState createState() => _YourWidgetNameState();
}

class _YourWidgetNameState extends State<YourWidgetName> {
  late List<Map<String, dynamic>> peopleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 223, 219, 219),
        title: const Text("Contact"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Loginscreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContact()),
          );
        },
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 19, 152, 230),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.enteredemail)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Clear peopleList to prevent duplicates
          peopleList.clear();
          // Add documents to peopleList
          snapshot.data!.docs.forEach((doc) {
            peopleList.add({
              'id': doc.id, // Add document ID to identify each item
              'name': doc['name'],
              'surname': doc['surname'],
              'phoneNumber': doc['phonenumber'],
            });
          });
          peopleList.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
          return peopleList.isEmpty?NoContact():Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: peopleList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showOptionsDialog(peopleList[index]);
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 254, 254),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${peopleList[index]['name']} ${peopleList[index]['surname']}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(peopleList[index]['phoneNumber'])
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.phone,
                                  size: 50,
                                  color: Color.fromARGB(255, 8, 179, 8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Function to show options (edit/delete) dialog
  Future<void> _showOptionsDialog(Map<String, dynamic> contact) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options'),
          content: Text('Choose an action for this contact:'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _showEditDialog(contact); // Show edit dialog
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _showDeleteDialog(contact['id']); // Show delete dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Function to show delete confirmation dialog
  Future<void> _showDeleteDialog(String itemId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call function to delete item from Firestore
                _deleteItem(itemId);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete item from Firestore
  Future<void> _deleteItem(String itemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.enteredemail)
          .collection('items')
          .doc(itemId)
          .delete();
      print('Item deleted from Firestore.');
    } catch (error) {
      print('Error deleting item: $error');
      // Handle error appropriately.
    }
  }

  // Function to show edit dialog
  Future<void> _showEditDialog(Map<String, dynamic> contact) async {
    TextEditingController nameController = TextEditingController(text: contact['name']);
    TextEditingController surnameController = TextEditingController(text: contact['surname']);
    TextEditingController phoneNumberController = TextEditingController(text: contact['phoneNumber']);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Surname'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editItem(contact['id'], nameController.text, surnameController.text, phoneNumberController.text);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to edit item in Firestore
  Future<void> _editItem(String itemId, String name, String surname, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.enteredemail)
          .collection('items')
          .doc(itemId)
          .update({
            'name': name,
            'surname': surname,
            'phonenumber': phoneNumber,
          });
      print('Item updated in Firestore.');
    } catch (error) {
      print('Error updating item: $error');
      // Handle error appropriately.
    }
  }
}
