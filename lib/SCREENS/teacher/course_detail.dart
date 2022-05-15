import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseDetail extends StatefulWidget {
  static const routeName = '/courseDetail';
  final title;
  final description;

  const CourseDetail({Key? key, this.title, this.description})
      : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //Course course = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
              tag: "",
              child: Container(
                width: double.infinity,
                height: 300,
                child: Image.asset("assets/download.jpg"),
                decoration: const BoxDecoration(),
              )),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Course: ${widget.title}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Taked By  ${auth.currentUser!.email.toString()}",
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.description.toString(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w300),
                    )),
                const SizedBox(
                  width: double.infinity,
                  // child:
                )
              ],
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("lessons")
                  .doc(auth.currentUser!.uid)
                  .collection(widget.title)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            elevation: 10,
                            child: Column(children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Image.asset("assets/download.jpg")),
                              Text(
                                //"title",
                                data[index].toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                //"title",
                                data[index]["name_lessons"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                //"descripstion_video",
                                data[index]["descripstion_lessons"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => CourseDetail(
                                                    description: data[index]
                                                        ["descripstion_video"],
                                                    title: data[index]
                                                        ["name_video"],
                                                  )));
                                    },
                                    child: const Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "view course",
                                          //data[index]["descripstion_video"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ]),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
