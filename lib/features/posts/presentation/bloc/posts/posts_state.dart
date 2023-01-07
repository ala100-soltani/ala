part of 'posts_bloc.dart';


abstract class PostsState {

  const PostsState();

  List<Object> get props=>[];

}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}


class LoadedPostsState extends PostsState {
 final List<Post> post;
  LoadedPostsState(this.post);

  List<Object> get props=>[post];

}

class ErrorPostsState extends PostsState{

  final String message;

  ErrorPostsState(this.message);

  List<Object> get props=>[message];
}