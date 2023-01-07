


import 'dart:convert';

import 'package:clean_code_project/features/posts/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class PostLocalDataSource{

  Future<List<PostModel>>getCachedPosts();

  Future<Unit> cachedPosts(List<PostModel> postList);
}

const cachedPost="CACHED_POST";
class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences shared;

  PostLocalDataSourceImpl({required this.shared});

  @override
  Future<Unit> cachedPosts(List<PostModel> postList) {
    List dataTojson=postList.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    shared.setString(cachedPost, json.encode(dataTojson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final getJson=shared.getString(cachedPost);
    if(getJson != null){
      List decodeJson=jsonDecode(getJson);

      List<PostModel> jsonToPostList=decodeJson.map<PostModel>((data) =>PostModel.fromJson(data)).toList();
      return Future.value(jsonToPostList);

    }else{
      throw EmptyCacheException();
    }

  }
  
  
  
  
}