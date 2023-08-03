import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/bloc/post_listing/post_listing_bloc.dart';
import '../../core/service/api_service.dart';
import '../../widgets/post_listing/post_listing.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  static const path = '/';

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Listing'),
      ),
      backgroundColor: Vx.gray100,
      body: BlocProvider(
        create: (context) =>
            PostListingBloc(ApiService())..add(const LoadPostListing()),
        child: BlocBuilder<PostListingBloc, PostListingState>(
          builder: (context, state) {
            return switch (state) {
              _ when state.isLoading =>
                const CircularProgressIndicator().centered(),
              _ when state.posts != null => PostListing(state.posts!),
              _ when state.error != null => Text(state.error),
              _ => Container(),
            };
          },
        ),
      ),
    );
  }
}
