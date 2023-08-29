import 'package:flutter/material.dart';
import 'package:template/services/posts_Service.dart';

import '../models/post.dart';

class PostListSeparated extends StatelessWidget {
  PostService fsService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
        stream: fsService.getPost(),
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
