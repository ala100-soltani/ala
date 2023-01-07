import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/strings/failures.dart';
import '../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/useCases/add_post.dart';
import '../../../domain/useCases/delete_post.dart';
import '../../../domain/useCases/update_post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {

final UpdatePostUseCase updatepost;
final DeletePostUseCase deletepost;
final AddPostUseCase addpost;

  AddDeleteUpdateBloc({required this.updatepost,required this.deletepost,required this.addpost}) :
        super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async{
      if (event is AddPostEvent){

        emit(LoadingAddDeleteUpdateState());

        final failureOrDoneMessage= await addpost(event.post);
        emit(_mapFailureOrSuccess(failureOrDoneMessage,ADD_SUCCESS_MESSAGE));


      }else if (event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdateState());

        final failureOrDoneMessage= await updatepost(event.post);
        emit(_mapFailureOrSuccess(failureOrDoneMessage,UPDATE_SUCCESS_MESSAGE));

      }else if (event is DeletePostEvent){
        emit(LoadingAddDeleteUpdateState());

        final failureOrDoneMessage= await deletepost(event.postID);
        emit(_mapFailureOrSuccess(failureOrDoneMessage,DELETE_SUCCESS_MESSAGE));

      }
    });
  }

AddDeleteUpdateState _mapFailureOrSuccess( Either<Failure,Unit> either, String message) {

   return either.fold((failure) => ErrorAddDeleteUpdateState( _mapFailureToString( failure)),
           (_) => MessageAddDeleteUpdateState( message));




}
String _mapFailureToString(Failure failure){

  switch(failure.runtimeType){
    case ServerFailure:return  SERVER_FAILURE_MESSAGE;

    case OfflineFailure:return OFFLINE_FAILURE_MESSAGE;

    default: return "unexpected errot try again";
  }


}
}
