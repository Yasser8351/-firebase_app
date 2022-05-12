import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/SCREENS/course_detail.dart';

import '/providers/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  static const routeName = '/feed';
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  @override
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    print('init called');
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchCourse();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _fetchCourse() async {
    try {
      if (!mounted) {
        print('not mounted');
        return;
      }
      final course = Provider.of<CourseProvider>(context, listen: false);
      final requestMade = course.requestMade;
      if (requestMade == false) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<CourseProvider>(context, listen: false).fetchCourse();
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SizedBox(
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("videos").snapshots(),
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
                            data[index]["name_video"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            //"descripstion_video",
                            data[index]["descripstion_video"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => CourseDetail(
                                            description: data[index]
                                                ["descripstion_video"],
                                            title: data[index]["name_video"],
                                          )));
                                },
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      "view course",
                                      //data[index]["descripstion_video"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    "Enroll",
                                    //data[index]["descripstion_video"],
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 5, 46, 122),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
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
    );
  }
}
