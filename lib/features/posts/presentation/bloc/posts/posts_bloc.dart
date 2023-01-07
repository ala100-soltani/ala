

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../core/error/failures.dart';
import '../../../core/strings/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/useCases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final GetAllPostsUserCase getPosts;



  PostsBloc(  {required this.getPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if(event is GetAllPostsEvents){
        emit(LoadingPostsState());

        final posts=await getPosts();

        emit(_mapFailureOrPostsToState(posts));


      }else if (event is RefreshPostsEvents){

        emit(LoadingPostsState());

        final posts=await getPosts();

        emit(_mapFailureOrPostsToState(posts));
      }
      // TODO: implement event handler
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either){


   return either.fold(
            (failure) =>  ErrorPostsState(_mapFailureToString( failure)),
            (posts) => LoadedPostsState(posts));


  }

  String _mapFailureToString(Failure failure){

    switch(failure.runtimeType){
      case ServerFailure:return  SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure: return Empty_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:return OFFLINE_FAILURE_MESSAGE;

      default: return "unexpected errot try again";
    }


  }
}
