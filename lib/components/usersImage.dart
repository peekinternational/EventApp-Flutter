import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsersImage extends StatelessWidget {
  String userID;
  UsersImage({Key? key, required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseDatabase.instance
            .reference()
            .child("users")
            .child("userDetails")
            .child(userID)
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
  }

  // Widget checkUrl(String url) {
  //   try {
  //     return FutureBuilder(
  //         future: FirebaseDatabase.instance
  //             .reference()
  //             .child("users")
  //             .child("userDetails")
  //             .child(feed.userID)
  //             .once(),
  //         builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
  //           if (!snapshot.hasData || snapshot.data?.value["profilePhoto"] == null) {
  //             return const CircleAvatar(
  //               radius: 18,
  //               child: ClipOval(
  //                   child: Icon(Icons.person)
  //               ),
  //             );
  //           }
  //           return CircleAvatar(
  //             radius: 18,
  //             child: ClipOval(
  //               child: CachedNetworkImage(
  //                 imageUrl: snapshot.data?.value["profilePhoto"],
  //                 width: 100,
  //                 height: 100,
  //                 fit: BoxFit.cover,
  //                 progressIndicatorBuilder: (context, url, downloadProgress) =>
  //                     CircularProgressIndicator(
  //                         value: downloadProgress.progress),
  //                 errorWidget: (context, url, error) => const Icon(Icons.person),
  //               ),
  //             ),
  //           );
  //         });
  //   } catch (e) {
  //     print('enter catch exception start');
  //     return const Icon(Icons.image);
  //   }
  // }

}
