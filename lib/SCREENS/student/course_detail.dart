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
  // static String url = "https://www.youtube.com/watch?v=X6BAKzFGYb8";

  // final YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: YoutubePlayer.convertUrlToId(url)!,
  //   flags: YoutubePlayerFlags(
  //     autoPlay: true,
  //     mute: true,
  //   ),
  // );

  // @override
  // dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  playVideo() {}
  @override
  Widget build(BuildContext context) {
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
                  child: const Text(
                    'Taught by Yasser',
                    style: TextStyle(
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
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).colorScheme.secondary,
                      child: const Text(
                        'Enroll',
                        style: TextStyle(color: Colors.white),
                      ),
                      textColor: Colors.blue,
                      onPressed: () {
                        // Provider.of<CourseProvider>(context, listen: false)
                        //     .enrollUser(course);
                      },
                    ))
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            playVideo();
          },
          child: Icon(Icons.ondemand_video)),
    );

    // return YoutubePlayerBuilder(
    //     player: YoutubePlayer(controller: _controller),
    //     builder: (ctx, player) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: const Text(""),
    //           backgroundColor: Theme.of(context).primaryColor,
    //         ),
    //         body: SingleChildScrollView(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Hero(
    //                 tag: "",
    //                 child: Container(
    //                   width: double.infinity,
    //                   height: 300,
    //                   child: Image.asset("assets/download.jpg"),
    //                   decoration: const BoxDecoration(),
    //                 )),
    //             Container(
    //               padding: const EdgeInsets.all(20),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(vertical: 5),
    //                     child: Text(
    //                       'Course: ${widget.title}',
    //                       style: const TextStyle(
    //                           fontSize: 25, fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(vertical: 5),
    //                     child: const Text(
    //                       'Taught by Yasser',
    //                       style: TextStyle(
    //                         fontSize: 22,
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                       margin: const EdgeInsets.symmetric(vertical: 5),
    //                       child: const Text(
    //                         'Description',
    //                         style: TextStyle(
    //                             fontSize: 20, fontWeight: FontWeight.w400),
    //                       )),
    //                   Container(
    //                       margin: const EdgeInsets.symmetric(vertical: 5),
    //                       child: Text(
    //                         widget.description.toString(),
    //                         style: const TextStyle(
    //                             fontSize: 22, fontWeight: FontWeight.w300),
    //                       )),
    //                   SizedBox(
    //                       width: double.infinity,
    //                       child: RaisedButton(
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(10.0)),
    //                         color: Theme.of(context).primaryColor,
    //                         splashColor:
    //                             Theme.of(context).colorScheme.secondary,
    //                         child: const Text(
    //                           'Enroll',
    //                           style: TextStyle(color: Colors.white),
    //                         ),
    //                         textColor: Colors.blue,
    //                         onPressed: () {
    //                           // Provider.of<CourseProvider>(context, listen: false)
    //                           //     .enrollUser(course);
    //                         },
    //                       ))
    //                 ],
    //               ),
    //             ),
    //             player,
    //           ],
    //         )),
    //         floatingActionButton: ElevatedButton(
    //             onPressed: () {
    //               playVideo();
    //             },
    //             child: Icon(Icons.ondemand_video)),
    //       );
    //     });
  }
}
