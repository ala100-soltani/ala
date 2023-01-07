import 'package:clean_code_project/features/posts/presentation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';




class PostListWidget extends StatelessWidget{

  final List<Post> posts;

  PostListWidget({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder:(context,index){
      return ListTile(leading:Text(posts[index].id.toString()),title:Text(posts[index].title ,),
        subtitle:Text(posts[index].body) ,contentPadding: EdgeInsets.symmetric(horizontal: 10),onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[index],)));
        },);
    }, separatorBuilder: (context,index)=>Divider(thickness: 1,), itemCount: posts.length);
  }




}