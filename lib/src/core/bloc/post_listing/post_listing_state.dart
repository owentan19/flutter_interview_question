part of 'post_listing_bloc.dart';

enum PostListingStatus {
  initial,
  loading,
  loaded,
  failed,
}

@immutable
final class PostListingState extends Equatable {
  const PostListingState({
    this.status = PostListingStatus.initial,
    this.posts,
    this.error,
  });

  const PostListingState.initial() : this();

  final PostListingStatus status;
  final List<Post>? posts;
  final dynamic error;

  @override
  List<Object?> get props => [
        status,
        posts,
        error,
      ];

  PostListingState changeStatus({
    required PostListingStatus status,
    List<Post>? posts,
    dynamic error,
  }) {
    return PostListingState(
      status: status,
      posts: posts ?? this.posts,
      error: error,
    );
  }

  bool get isLoading => status == PostListingStatus.loading;
}
