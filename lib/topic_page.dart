import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  final String topic;

  const TopicPage({Key? key, required this.topic}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final number = FirebaseFirestore.instance.collection('Numbers');
  final fruits = FirebaseFirestore.instance.collection('Fruits');
  final colours = FirebaseFirestore.instance.collection('Colours');
  final vegetables = FirebaseFirestore.instance.collection('Vegetables');

  Color? color;

  var finalref;

  @override
  Widget build(BuildContext context) {
    if (widget.topic == 'Numbers') {
      finalref = number;
      print('ys');
    } else if (widget.topic == 'Fruits') {
      finalref = fruits;
    } else if (widget.topic == 'Colour') {
      finalref = colours;
    } else if (widget.topic == 'Vegetables') {
      finalref = vegetables;
    }

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 149, 245),
        elevation: 20,
        title: Text(
          widget.topic,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: finalref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 7,
                            child: Card(
                              color: const Color.fromARGB(255, 32, 149, 245),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!.docs[index]['input'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          snapshot.data!.docs[index]['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        //   child: CircleAvatar(
                        //     backgroundImage:
                        //         NetworkImage(snapshot.data!.docs[index]['image']),
                        //   ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: Card(
                                color: const Color.fromARGB(255, 32, 149, 245),
                                child: Center(
                                  child: Text(
                                    snapshot
                                        .data!.docs[index]['translated']['fr']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shourya_french_app/input.dart';
//
// import 'model/french_data.dart';
//
// class TopicPage extends StatefulWidget {
//   final List input;
//   final String name;
//   final FrenchModel categorylist;
//
//   const TopicPage({
//     Key? key,
//     required this.input,
//     required this.name,
//     required this.categorylist,
//   }) : super(key: key);
//
//   @override
//   _TopicPageState createState() => _TopicPageState();
// }
//
// class _TopicPageState extends State<TopicPage> {
//   @override
//   Widget build(BuildContext context) {
//     const bgcolor = Color.fromARGB(255, 32, 149, 245);
//     final inputref = FirebaseFirestore.instance.collection('translations');
//
//     return Scaffold(
//       backgroundColor: bgcolor,
//       appBar: AppBar(
//         title: Text(widget.name),
//       ),
//       body: Row(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: 500,
//                 width: 500,
//                 child: FinalListInput(
//                   translated: ,
//                   input: widget.categorylist.input!.toList(),
//                 ),
//                 // child: StreamBuilder(
//                 //   stream: inputref.snapshots(),
//                 //   builder: (BuildContext context,
//                 //       AsyncSnapshot<QuerySnapshot> snapshot) {
//                 //     if (snapshot.hasData) {
//                 //       List<FrenchModel> inputList = snapshot.data!.docs
//                 //           .map((e) => FrenchModel.fromJson(
//                 //               e.data() as Map<String, dynamic>))
//                 //           .toList();
//                 //       return ListView.builder(
//                 //           itemCount: inputList.length,
//                 //           itemBuilder: (BuildContext context, int index) {
//                 //             return Column(
//                 //               children: [
//                 //                 Text(widget.inputList[index].input.toString()),
//                 //               ],
//                 //             );
//                 //           });
//                 //     } else {
//                 //       return const CircularProgressIndicator();
//                 //     }
//                 //   },
//                 // ),
//                 //
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
