import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/bloc/post/post_bloc.dart';
import '../../core/service/api_service.dart';
import '../../widgets/post_details.dart/comment_section.dart';
import '../../widgets/post_details.dart/search_comment.dart';

final class PostDetailsScreenPayload {
  final int postId;

  const PostDetailsScreenPayload({required this.postId});
}

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  static const path = '/posts/details';
  final PostDetailsScreenPayload payload;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: BlocProvider(
        create: (context) => PostBloc(ApiService())
          ..add(LoadPost(postId: widget.payload.postId))
          ..add(GetComments(postId: widget.payload.postId)),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            final post = state.post;
            if (post != null) {
              return VStack(
                [
                  const SearchComment().py4(),
                  post.title.text.bold.size(18).make(),
                  5.heightBox,
                  post.body.text.gray500.make(),
                  if (state.comments != null)
                    CommentSection(comments: state.comments!),
                ],
              )
                  .pSymmetric(
                    v: 12,
                    h: 24,
                  )
                  .scrollVertical();
            }

            if (state.error != null) Text(state.error);
            return Container();
          },
        ),
      ),
    );
  }
}
