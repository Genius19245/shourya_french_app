import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/data_model.dart';

class Translator extends StatefulWidget {
  const Translator({super.key});

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  String? url;
  final ref = FirebaseFirestore.instance
      .collection('Translator')
      .doc('mKlyI5149sKCx3VN1c7T');
  final textref = FirebaseFirestore.instance
      .collection('Text_To_Speech')
      .withConverter<DataModel>(
        fromFirestore: (snapshot, _) => DataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (model, _) => model.toJson(),
      );
  String? docId;
  String? downloadUrl;
  bool isAudioAvailable = false;

  /// Controller for updating translation input text.
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 149, 245),
        title: const Text(
          'English to french ',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          final snapshotData = snapshot.data;
          if (snapshotData != null) {
            // Convert the snapshot to a map.
            // final TranslatorModel? translatedData = snapshotData.data();
            if (snapshot.hasError == null) {
              return Center(child: Text('No Data'));
            }
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.network(
                    'https://cdn-icons-png.flaticon.com/128/1375/1375459.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover),
                Spacer(),
                Center(
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color.fromARGB(255, 32, 149, 245),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  snapshot.data!['translated']['fr'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white60,
                          fontWeight: FontWeight.w200,
                        ),
                        hintText: 'Type your text to translate',
                        contentPadding: EdgeInsets.only(top: 13, left: 15),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.white),
                            onPressed: () async {
                              if (_textController.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Enter the text'),
                                  ),
                                );
                              }
                              await ref.update(
                                {'input': _textController.text},
                              );
                              final doc = await textref
                                  .add(DataModel(
                                text: snapshot.data!['translated']['fr'],
                              ))
                                  .then(
                                (doc) async {
                                  setState(() {
                                    docId = doc.id;
                                  });
                                  // Update the input field on the translation document.

                                  Future.delayed(Duration(seconds: 5),
                                      () async {
                                    downloadUrl = await FirebaseStorage.instance
                                        .ref()
                                        .child('Text_To_Speech/$docId.mp3')
                                        .getDownloadURL();
                                    setState(() {
                                      isAudioAvailable = true;
                                    });
                                  });

                                  // Clear the text field to prepare for next input.
                                  // _textController.clear();
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
