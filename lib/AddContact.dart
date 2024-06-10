import 'package:contactapp/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddContact createState() => _AddContact();
}

class _AddContact extends State<AddContact> {
  final form = GlobalKey<FormState>();
  var name = '';
  var surname = '';
  var phonenumber = '';
  final firestore = FirestoreService();
  void submit() {
    final isvalid = form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    form.currentState?.save();
    print(name);
    print(surname);
    print(phonenumber);
    firestore.addItem([name, surname, phonenumber]);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: form,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Add new contact !",
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Surname",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    surname = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Phone Number",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length == 9) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phonenumber = value!;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.maxFinite,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {
                        submit();
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 75, 221, 31)),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
