part of 'post_listing_bloc.dart';

@immutable
sealed class PostListingEvent extends Equatable {
  const PostListingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPostListing extends PostListingEvent {
  const LoadPostListing();
}
