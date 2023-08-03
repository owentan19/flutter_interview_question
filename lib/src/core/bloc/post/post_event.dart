part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPost extends PostEvent {
  const LoadPost({
    required this.postId,
  });

  final int postId;

  @override
  List<Object?> get props => [postId];
}

final class GetComments extends PostEvent {
  const GetComments({
    required this.postId,
    this.filter,
  });

  final int postId;
  final String? filter;

  @override
  List<Object?> get props => [
        postId,
        filter,
      ];
}
