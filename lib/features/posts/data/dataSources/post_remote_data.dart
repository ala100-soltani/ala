

import 'dart:convert';

import 'package:clean_code_project/features/posts/core/error/exception.dart';
import 'package:dartz/dartz.dart';

import '../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource{

  Future<List<PostModel>>getAllPosts();

  Future<Unit> deletePost(int postID);
  Future<Unit> updatePost(PostModel postmodel);
  Future<Unit> addPost(PostModel postmodel);
}


const BASE_URL="https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource{

  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override

  Future<List<PostModel>> getAllPosts() async {
    
    final response= await client.get(Uri.parse(BASE_URL+"/posts/"),
        headers:{
      "Content-Type":"application/json"
        });
    if(response.statusCode == 200){

      final List data=json.decode(response.body) as List;

      final List<PostModel> postInfo= data.map<PostModel>((data) => PostModel.fromJson(data)).toList();

      return postInfo;


    }else{
      throw ServerException();
    }

  }
  @override
  Future<Unit> addPost(PostModel postmodel) async {
  final body={
    "title":postmodel.title,
    "body":postmodel.body

  };
  final response=await client.post(Uri.parse(BASE_URL+"/posts/"),body: body,);

  if (response.statusCode  ==201){
    return Future.value(unit);
  }else{
    throw ServerException();
  }

  
  }

  @override
  Future<Unit> deletePost(int postID) async{
    final response= await client.delete(Uri.parse(BASE_URL+"/posts/${postID.toString()}"),
        headers:{
      "Content-Type":"application/json"
    });
    if (response.statusCode  ==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }

  }



  @override
  Future<Unit> updatePost(PostModel postmodel) async{
   final postId=postmodel.id.toString();
   final body={
     "title":postmodel.title,
     "body":postmodel.body

   };

   final response=await client.patch(Uri.parse(BASE_URL+"/posts/${postId}"),body: body);
   if (response.statusCode  ==200){
     return Future.value(unit);
   }else{
     throw ServerException();
   }

  }






}