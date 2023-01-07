

import 'package:clean_code_project/features/posts/core/error/failures.dart';
import 'package:clean_code_project/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

class UpdatePostUseCase{
  final PostRepositories post;

  UpdatePostUseCase(this.post);

  Future<Either<Failure,Unit>> call(Post posts)async{

    return await post.updatePost(posts);
  }
}