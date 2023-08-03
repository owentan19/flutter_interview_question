import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modals/comment.dart';
import '../../modals/post.dart';
import '../../service/api_service.dart';

part 'post_event.dart';
part 'post_state.dart';

final class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._apis) : super(const PostState.initial()) {
    on<LoadPost>(_onLoadPost);
    on<GetComments>(_onGetComments);
  }

  final ApiService _apis;

  Future<void> _onLoadPost(
    LoadPost event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(state.changeStatus(status: PostStatus.loading));

      final response = await _apis.getPost(event.postId);

      emit(state.changeStatus(
        status: PostStatus.loaded,
        post: response,
      ));
    } catch (ex) {
      emit(state.changeStatus(
        status: PostStatus.failed,
        error: ex,
      ));
    }
  }

  Future<void> _onGetComments(
    GetComments event,
    Emitter<PostState> emit,
  ) async {
    try {
      emit(state.changeStatus(status: PostStatus.loading));
      List<Comment>? filteredComments;
      final filterText = event.filter;
      final comments = await _apis.getCommentsForPost(event.postId);

      //filter comments
      if (event.filter != null) {
        filteredComments = comments.where((comment) {
          return comment.name
                  .toLowerCase()
                  .contains(filterText!.toLowerCase()) ||
              comment.email.toLowerCase().contains(filterText.toLowerCase()) ||
              comment.body.toLowerCase().contains(filterText.toLowerCase());
        }).toList();
      }

      emit(state.changeStatus(
        status: PostStatus.loaded,
        comments: filteredComments ?? comments,
      ));
    } catch (ex) {
      emit(state.changeStatus(
        status: PostStatus.failed,
        error: ex,
      ));
    }
  }
}
