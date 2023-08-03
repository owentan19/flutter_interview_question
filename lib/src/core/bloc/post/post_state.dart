part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  loaded,
  failed,
}

@immutable
final class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.post,
    this.comments,
    this.error,
  });

  const PostState.initial() : this();

  final PostStatus status;
  final Post? post;
  final List<Comment>? comments;
  final dynamic error;

  @override
  List<Object?> get props => [
        status,
        post,
        comments,
        error,
      ];

  PostState changeStatus({
    required PostStatus status,
    Post? post,
    List<Comment>? comments,
    dynamic error,
  }) {
    return PostState(
      status: status,
      post: post ?? this.post,
      comments: comments ?? this.comments,
      error: error,
    );
  }

  bool get isLoading => status == PostStatus.loading;
}
