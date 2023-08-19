import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Translator extends StatefulWidget {
  const Translator({super.key});

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  final ref = FirebaseFirestore.instance
      .collection('Translator')
      .doc('mKlyI5149sKCx3VN1c7T');
  // //calling withConverter is that the generic type T is set to your custom Model. This means that every subsequent call on the document ref, will work with that type instead of Map<String, dynamic>.
  // .withConverter<TranslatorModel>(
  //   fromFirestore: (snapshot, _) => TranslatorModel.fromJson(
  //     snapshot.data()!,
  //   ),
  //   toFirestore: (model, _) => model.toJson(),
  // );

  /// Controller for updating translation input text.
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Translator")),
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
                    'https://cdn-icons-png.flaticon.com/512/576/576515.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover),
                Spacer(),
                Center(
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.brown,
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
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 30,
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
                    width: 400,
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
                        hintText: 'Input text',
                        contentPadding: EdgeInsets.only(top: 15, left: 10),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.keyboard_voice_rounded,
                            color: Colors.white,
                            size: 29,
                          ),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: () async {
                            // Update the input field on the translation document.
                            await ref.update(
                              {'input': _textController.text},
                            );

                            // Clear the text field to prepare for next input.
                            // _textController.clear();
                          },
                        ),
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
