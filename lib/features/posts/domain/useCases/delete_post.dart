
import 'package:clean_code_project/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

class DeletePostUseCase{

  final PostRepositories post;

  DeletePostUseCase(this.post);

  Future<Either<Failure,Unit>> call(int postId)async{

    return await post.deletePost(postId);
  }
}