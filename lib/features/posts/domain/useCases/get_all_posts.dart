
import 'package:clean_code_project/features/posts/domain/entities/post.dart';
import 'package:clean_code_project/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

class GetAllPostsUserCase{

  final PostRepositories posts;

  GetAllPostsUserCase(this.posts);

  Future<Either<Failure, List<Post>>> call() async{

    return await posts.getAllPosts();


  }

}