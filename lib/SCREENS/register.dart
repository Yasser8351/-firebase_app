import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = 'Register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double? sizeBetweenFeiled = 10.0;
  File? _storedImage;
  final _form = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SizedBox(
                    height: 251,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: _userNameController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                labelText: 'username',
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب ادخال اسم المستخدم';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                        SizedBox(height: sizeBetweenFeiled),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: 'email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب ادخال الايميل';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                        SizedBox(height: sizeBetweenFeiled),
                        Container(
                          color: Colors.white,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'password',
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )
                                //hintText: 'password',
                                ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'يجب ادخال كلمة المرور';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.black))
                  : ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                      onPressed: () {
                        registerUser(
                            _emailController.text,
                            _userNameController.text,
                            _passwordController.text,
                            0);
                      },
                    ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Login.routeName);
                },
                child: const Text(
                  'Already have account? SignIn',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(
      String email, String name, String password, int typeAccount) async {
    try {
      setState(() {
        isLoading = true;
      });
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance
          .collection(typeAccount == 0 ? "student" : "teacher")
          .doc(userCredential.user!.uid)
          .set({
        "username": name.trim(),
        "email": email.trim(),
        "uid": auth.currentUser!.uid,
        "timeCreated": DateTime.now(),
        "typeAccount": typeAccount == 0 ? "student" : "teacher",
      });
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("تم انشاء الحساب بنجاح..قم بتسجيل الدخول")));
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => Login(typeAccount: typeAccount)));
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      String errorMessage = "";
      switch (error.code) {
        case "weak-password":
          errorMessage = "The password provided is too weak.";
          break;
        case "email-already-in-use":
          errorMessage = "The account already exists for that email.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
