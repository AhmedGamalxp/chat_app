import 'package:chat_app/models/massages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  ChatPage({super.key});
  final listController = ScrollController();

  final TextEditingController controller = TextEditingController();
  final CollectionReference massages =
      FirebaseFirestore.instance.collection(kMassagesCollectionReference);
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: massages.orderBy(kSentAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MassageModel> massagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massagesList.add(MassageModel.fromJson(
                snapshot.data!.docs[i],
              ));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimerColor,
                automaticallyImplyLeading: false,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.forum,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat',
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      controller: listController,
                      itemCount: massagesList.length,
                      itemBuilder: (context, index) {
                        return massagesList[index].id == email
                            ? ChatBuble(massage: massagesList[index])
                            : ChatBubleForFriend(massage: massagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        massages.add({
                          kMassage: value,
                          kSentAt: DateTime.now(),
                          'id': email,
                        });
                        controller.clear();
                        listController.jumpTo(0);
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              massages.add({
                                kMassage: controller.text,
                                kSentAt: DateTime.now(),
                                'id': email,
                              });
                              controller.clear();
                              listController.jumpTo(0);
                            },
                            icon: Icon(Icons.send, color: kPrimerColor)),
                        hintText: 'Send Massage',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const ModalProgressHUD(
              inAsyncCall: true,
              child: Scaffold(),
            );
          }
        });
  }
}
