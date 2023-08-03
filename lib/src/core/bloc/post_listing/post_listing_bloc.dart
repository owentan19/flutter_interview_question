import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modals/post.dart';
import '../../service/api_service.dart';

part 'post_listing_event.dart';
part 'post_listing_state.dart';

final class PostListingBloc extends Bloc<PostListingEvent, PostListingState> {
  PostListingBloc(this._apis) : super(const PostListingState.initial()) {
    on<LoadPostListing>(_onLoadPostListing);
  }

  final ApiService _apis;

  Future<void> _onLoadPostListing(
    LoadPostListing event,
    Emitter<PostListingState> emit,
  ) async {
    try {
      emit(state.changeStatus(status: PostListingStatus.loading));

      final response = await _apis.getPosts();

      emit(state.changeStatus(
        status: PostListingStatus.loaded,
        posts: response,
      ));
    } catch (ex) {
      emit(state.changeStatus(
        status: PostListingStatus.failed,
        error: ex,
      ));
    }
  }
}
