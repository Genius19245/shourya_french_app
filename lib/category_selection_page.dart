import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shourya_french_app_final/topic_page.dart';
import 'package:shourya_french_app_final/translator.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  _CategorySelectionPageState createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  final ref = FirebaseFirestore.instance.collection('translations');
  final bgcolor = const Color.fromARGB(255, 32, 149, 245);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: bgcolor,
        title: const Text(
          'French Vocab Helper',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/10643/10643926.png',
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 15,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (snapshot.data!.docs[index]['topic'] ==
                                    'Translator') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const Translator(),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TopicPage(
                                        topic: snapshot.data!.docs[index]
                                            ['topic'],
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Card(
                                elevation: 100,
                                color: bgcolor,
                                child: SizedBox(
                                  height: 75,
                                  width: 200,
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.docs[index]['topic'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('waiting');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
