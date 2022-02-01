import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamtailgate_flutter/models/Feed.dart';
import '../../components/FeedCard.dart';

class FeedFragment extends StatefulWidget {
  @override
  State<FeedFragment> createState() => _FeedFragmentState();
}

class _FeedFragmentState extends State<FeedFragment> {
  final fb = FirebaseDatabase.instance;
  List<Feed> myAllData = [];
  bool isLoading = true;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    myAllData = <Feed>[];
    fetchFeed(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background_3_gradient.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: RefreshIndicator(
          onRefresh: () async {
            fetchFeed(true);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: myAllData.length + 1,
                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                      itemBuilder: (context, index) {
                        if (index == myAllData.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return FeedCard(myAllData[index]);
                      })),
            ],
          )),
    );
  }

  Future<void> fetchFeed(bool isall) async {
    if (isall) {
      final ref = fb.reference();
      ref.child("feed").orderByChild("date").once().then((DataSnapshot data) {
        myAllData = [];
        isLoading = false;
        Map<dynamic, dynamic> values = data.value;
        values.forEach((key, values) {
          Feed fd = Feed(
            id: key,
            date: values["date"],
            description: values["description"],
            eventID: values["eventID"],
            userID: values["userID"],
            profilePhoto: '',
          );
          myAllData.add(fd);
        });
        setState(() {
          myAllData = myAllData.reversed.toList();
        });
      });
    } else {
      if (isLoading) {
        final ref = fb.reference();
        ref
            .child("feed")
            .orderByChild("date")
            .limitToLast(25)
            .once()
            .then((DataSnapshot data) {
          isLoading = false;
          Map<dynamic, dynamic> values = data.value;
          List<Feed> dummyFeedList = [];
          values.forEach((key, values) {
            Feed fd = Feed(
              id: key,
              date: values["date"],
              description: values["description"],
              eventID: values["eventID"],
              userID: values["userID"],
              profilePhoto: '',
            );
            dummyFeedList.add(fd);
          });
          setState(() {
            myAllData.addAll(dummyFeedList.reversed);
          });
        });
      }
    }
  }

  Future<void> fetchMoreFeed() async {
    if (isLoading) {
      final ref = fb.reference();
      ref
          .child("feed")
          .orderByChild("date")
          .endAt(myAllData[myAllData.length - 1].date)
          .limitToLast(11)
          .once()
          .then((DataSnapshot data) {
        isLoading = false;
        Map<dynamic, dynamic> values = data.value;
        List<Feed> dummyFeedList = [];
        values.forEach((key, values) {
          Feed fd = Feed(
            id: key,
            date: values["date"],
            description: values["description"],
            eventID: values["eventID"],
            userID: values["userID"],
            profilePhoto: '',
          );
          dummyFeedList.add(fd);
        });
        setState(() {
          myAllData.removeAt(myAllData.length - 1);
          myAllData.addAll(dummyFeedList.reversed);
        });
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        isLoading = true;
        if (isLoading) {
          fetchMoreFeed();
        }
      });
    }
  }
}
