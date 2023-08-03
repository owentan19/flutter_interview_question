import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/post/post_bloc.dart';

class SearchComment extends StatefulWidget {
  const SearchComment({Key? key}) : super(key: key);

  @override
  _SearchCommentState createState() => _SearchCommentState();
}

class _SearchCommentState extends State<SearchComment> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: _filterComments,
      decoration: const InputDecoration(
        hintText: 'Search by name, email, or body',
      ),
    );
  }

  void _filterComments(String query) {
    final postBloc = context.read<PostBloc>();
    final postId = postBloc.state.post!.id;
    postBloc.add(GetComments(
      postId: postId,
      filter: query,
    ));
  }
}
