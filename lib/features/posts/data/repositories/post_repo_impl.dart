


import 'package:clean_code_project/features/posts/core/error/exception.dart';
import 'package:clean_code_project/features/posts/core/error/failures.dart';
import 'package:clean_code_project/features/posts/domain/entities/post.dart';
import 'package:clean_code_project/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../core/network/network_info.dart';
import '../dataSources/post_local_data.dart';
import '../dataSources/post_remote_data.dart';
import '../models/post_model.dart';

typedef Future<Unit> addOrdeleteOrupdate();

class PostRepoImpl implements PostRepositories{

   final  PostRemoteDataSource remoteDataSource;
  final  PostLocalDataSource localDataSource;
  final NetworkInfo network;


   PostRepoImpl({required this.remoteDataSource,required this.localDataSource,required this.network});

   @override
   Future<Either<Failure, List<Post>>> getAllPosts()async {
     if(await network.iSconncted){
       try{
         final remotepost=await remoteDataSource.getAllPosts();
         localDataSource.cachedPosts(remotepost);
         return Right(remotepost);


       }on ServerException{
         return Left(ServerFailure());
       }
     }else{
       try{
         final localPost=await localDataSource.getCachedPosts();
         return right(cast(localPost));

       }on EmptyCacheException{
         return Left(EmptyCacheFailure());
       }
     }

   }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postm=PostModel(title:post.title,body:post.body);

    return await _getMessage(() {
      return remoteDataSource.addPost(postm);

    } );


  }



  @override
  Future<Either<Failure, Unit>> deletePost(int id)async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id);

    } );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postm=PostModel(id:post.id,title:post.title,body:post.body);

   return await _getMessage(() {
     return remoteDataSource.updatePost(postm);

   } );
  }

   Future<Either<Failure, Unit>> _getMessage(addOrdeleteOrupdate addOReleteOrupdate)async{

    if(await network.iSconncted){
      try{
       await addOReleteOrupdate();
        return Right(unit);

      }on ServerException{
        return Left(ServerFailure());

      }
    }else{
      return Left(OfflineFailure());
    }
  }





  }
  
  
  
  
