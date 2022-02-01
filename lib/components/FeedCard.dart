import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:teamtailgate_flutter/models/Feed.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:teamtailgate_flutter/components/usersImage.dart';

class FeedCard extends StatefulWidget {
  final Feed feed;

  FeedCard(this.feed);

  @override
  State<StatefulWidget> createState() {
    return FeedCardState(feed);
  }
}

class FeedCardState extends State<FeedCard> {
  Feed feed;
  final fbd = FirebaseDatabase.instance;

  FeedCardState(this.feed);

  Widget get feedCard {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(feed.description),
      )),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.all(1),
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: UsersImage(userID: feed.userID,),
            ),
          ),
          title: Text(feed.description),
          dense: false,
        ),
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: feedCard,
    );
  }


  Widget checkUrl(String url) {
    try {
      return FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child("users")
              .child("userDetails")
              .child(feed.userID)
              .once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data?.value["profilePhoto"] == null) {
              return const CircleAvatar(
                radius: 18,
                child: ClipOval(
                    child: Icon(Icons.person)
                ),
              );
            }
            return CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: snapshot.data?.value["profilePhoto"],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.person),
                ),
              ),
            );
          });
    } catch (e) {
      print('enter catch exception start');
      return const Icon(Icons.image);
    }
  }
}
