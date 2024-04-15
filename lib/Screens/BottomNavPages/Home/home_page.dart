import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo_poll/Providers/db_provider.dart';
import 'package:demo_poll/Providers/fetch_polls_provider.dart';
import 'package:demo_poll/Styles/colors.dart';
import 'package:demo_poll/Utils/dynamic_utils.dart';
import 'package:demo_poll/Utils/message.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFetched = false;
  TextEditingController _searchController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

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
            'Your Home',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            )
          )
        )
      ),

      body: Consumer<FetchPollsProvider>(builder: (context, polls, child) {
        if (!_isFetched) {
          polls.fetchAllPolls();

          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }

        return SafeArea(
          child: Column(
            children: [
              Padding( //beginning of search bar
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: "Search Polls",
                    hintText: "Enter poll question",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {}); // To filter polls based on the search query
                  },
                ),
              ), //end of search bar
              Expanded(
                child: polls.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : polls.pollsList.isEmpty
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
                                    ...polls.pollsList.where((poll) {
                                      final pollQuestion = poll["poll"]["question"].toString().toLowerCase();
                                      final searchQuery = _searchController.text.toLowerCase();
                                      return pollQuestion.contains(searchQuery);
                                    }).map((data) {
                                      log(data.data().toString());
                                      Map author = data["author"];
                                      Map poll = data["poll"];
                                      Timestamp date = data["dateCreated"];

                                      List voters = poll["voters"];

                                      List<dynamic> options = poll["options"];

                                      return Container(
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
                                                backgroundImage: AssetImage("assets/default_profile.png"),
                                              ),
                                              title: Text(author["name"]),
                                              subtitle: Text(DateFormat.yMEd()
                                                  .format(date.toDate())),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    DynamicLinkProvider()
                                                        .createLink(data.id)
                                                        .then((value) {
                                                      Share.share(value);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.share)),
                                            ),
                                            Text(poll["question"]),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            ...List.generate(options.length,
                                                (index) {
                                              final dataOption = options[index];
                                              return Consumer<DbProvider>(
                                                  builder: (context, vote, child) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                  (_) {
                                                    if (vote.message != "") {
                                                      if (vote.message.contains(
                                                          "Vote Recorded")) {
                                                        success(context,
                                                            message: vote.message);
                                                        polls.fetchAllPolls();
                                                        vote.clear();
                                                      } else {
                                                        error(context,
                                                            message: vote.message);
                                                        vote.clear();
                                                      }
                                                    }
                                                  },
                                                );
                                                return GestureDetector(
                                                  onTap: () {
                                                    log(user!.uid);

                                                    ///Update vote
                                                    if (voters.isEmpty) {
                                                      log("No vote");
                                                      vote.votePoll(
                                                          pollId: data.id,
                                                          pollData: data,
                                                          previousTotalVotes:
                                                              poll["total_votes"],
                                                          seletedOptions:
                                                              dataOption["answer"]);
                                                    } else {
                                                      final isExists =
                                                          voters.firstWhere(
                                                              (element) =>
                                                                  element["uid"] ==
                                                                  user!.uid,
                                                              orElse: () {});
                                                      if (isExists == null) {
                                                        log("User does not exist");
                                                        vote.votePoll(
                                                            pollId: data.id,
                                                            pollData: data,
                                                            previousTotalVotes:
                                                                poll["total_votes"],
                                                            seletedOptions:
                                                                dataOption[
                                                                    "answer"]);
                                                        //
                                                      } else {
                                                        error(context,
                                                            message:
                                                                "You have already voted");
                                                      }
                                                      print(isExists.toString());
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(
                                                        bottom: 5),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Stack(
                                                            children: [
                                                              LinearProgressIndicator( //poll bars, come back and add animation
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
                                                                        horizontal:
                                                                            10),
                                                                height: 30,
                                                                child: Text(
                                                                    dataOption[
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
                                                  ),
                                                );
                                              });
                                            }),
                                            Text(
                                                "Total votes : ${poll["total_votes"]}")
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
