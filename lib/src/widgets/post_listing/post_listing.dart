import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/modals/post.dart';
import '../../screens/post_details/post_details.dart';

class PostListing extends StatelessWidget {
  final List<Post> posts;

  const PostListing(this.posts, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: post.title.text.bold.size(18).make(),
            subtitle: post.body.text.gray500.make(),
            contentPadding: const EdgeInsets.all(20),
            tileColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, PostDetailsScreen.path,
                  arguments: PostDetailsScreenPayload(postId: post.id));
            });
      },
      padding: const EdgeInsets.all(20),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
    );
  }
}
