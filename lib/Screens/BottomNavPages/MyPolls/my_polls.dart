import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo_poll/Providers/db_provider.dart';
import 'package:demo_poll/Screens/BottomNavPages/MyPolls/add_new_polls.dart';
import 'package:demo_poll/Styles/colors.dart';
import 'package:demo_poll/Utils/message.dart';
import 'package:demo_poll/Utils/router.dart';
import 'package:provider/provider.dart';

import '../../../Providers/fetch_polls_provider.dart';

class MyPolls extends StatefulWidget {
  const MyPolls({super.key});

  @override
  State<MyPolls> createState() => _MyPollsState();
}

class _MyPollsState extends State<MyPolls> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar( //top app bar
        surfaceTintColor: Color(0xFFC7E7F3),
        shadowColor: Colors.grey,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5AC7F0),
        centerTitle: true,
        title: Title(
          color: Colors.white,
          child: const Text(
            'Your Polls',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            )
          )
        )
      ),

      body: Consumer<FetchPollsProvider>(builder: (context, polls, child) {
        if (_isFetched == false) {
          polls.fetchUserPolls();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return SafeArea(
          child: polls.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : polls.userPollsList.isEmpty
                  ? const Center(
                      child: Text("No polls at the moment"),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ...List.generate(polls.userPollsList.length,
                                    (index) {
                                  final data = polls.userPollsList[index];

                                  log(data.data().toString());
                                  Map author = data["author"];
                                  Map poll = data["poll"];
                                  Timestamp date = data["dateCreated"];

                                  List<dynamic> options = poll["options"];

                                  return Container( //box begins here
                                        margin: const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                             boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                offset: const Offset(
                                                  0,
                                                  0,
                                                ),
                                                blurRadius: 10.0,
                                                spreadRadius: 0.5,
                                              ), //BoxShadow
                                            ],
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [Color(0xFFC7E7F3), Color(0xFF5AC7F0)]),
                                            color: Color(0xFFC7E7F3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          leading: const CircleAvatar(
                                            backgroundColor: Color(0xFF113143),
                                            backgroundImage:AssetImage("assets/default_profile.png"),
                                          ),
                                          title: Text(author["name"]),
                                          subtitle: Text(DateFormat.yMEd()
                                              .format(date.toDate())),
                                          trailing: Consumer<DbProvider>(
                                              builder:
                                                  (context, delete, child) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                              (_) {
                                                if (delete.message != "") {
                                                  if (delete.message.contains(
                                                      "Poll Deleted")) {
                                                    success(context,
                                                        message:
                                                            delete.message);
                                                    polls.fetchUserPolls();
                                                    delete.clear();
                                                  } else {
                                                    error(context,
                                                        message:
                                                            delete.message);
                                                    delete.clear();
                                                  }
                                                }
                                              },
                                            );
                                            return IconButton(
                                                onPressed:
                                                    delete.deleteStatus == true
                                                        ? null
                                                        : () {
                                                            ///
                                                            delete.deletePoll(
                                                                pollId:
                                                                    data.id);
                                                          },
                                                icon: delete.deleteStatus ==
                                                        true
                                                    ? const CircularProgressIndicator()
                                                    : const Icon(Icons.delete));
                                          }),
                                        ),
                                        Text(poll["question"]),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ...List.generate(options.length,
                                            (index) {
                                          final dataOption = options[index];
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      LinearProgressIndicator(
                                                        color: Color(0xFF5AC7F0),
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(12)),
                                                        minHeight: 30,
                                                        value: dataOption[
                                                                "percent"] /
                                                            100,
                                                        backgroundColor:
                                                            AppColors.white,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        height: 30,
                                                        child: Text(dataOption[
                                                            "answer"]),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                    "${dataOption["percent"]}%")
                                              ],
                                            ),
                                          );
                                        }),
                                        Text(
                                            "Total votes : ${poll["total_votes"]}")
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5AC7F0),
        foregroundColor: Colors.white, 
        onPressed: () {
          nextPage(context, const AddPollPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
