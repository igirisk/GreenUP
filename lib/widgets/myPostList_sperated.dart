import 'package:flutter/material.dart';
import 'package:template/services/posts_Service.dart';

import '../global.dart';
import '../models/post.dart';
import '../screens/editPostScreen.dart';

class MyPostListSeparated extends StatelessWidget {
  PostService fsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
        stream: fsService.getMyPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.separated(
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          5), // Adjust the radius as needed
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              snapshot.data![i].username,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              snapshot.data![i].date,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data![i].challengeName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data![i].caption,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  PostService fsService = PostService();
                                  fsService.deletePost(snapshot.data![i].id);
                                },
                                child: const Text(
                                  'delete',
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  Globals.editPostId = snapshot.data![i].id;
                                  Globals.editPostDate = snapshot.data![i].date;
                                  Globals.editChallengeName =
                                      snapshot.data![i].challengeName;
                                  Globals.editCaption =
                                      snapshot.data![i].caption;
                                  Navigator.pushReplacementNamed(
                                      context, EditPostScreen.routeName);
                                },
                                child: const Text(
                                  'edit',
                                  style: TextStyle(color: Colors.green),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, i) {
                return const Divider(
                  height: 20,
                  color: Colors.transparent,
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        });
  }
}
