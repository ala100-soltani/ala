
import 'package:clean_code_project/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_code_project/features/posts/presentation/pages/post_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widget/loading_widget.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/post_list_widget.dart';


class PostsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),

      body:  _buildBodyWidget(),
        floatingActionButton:_buildFloatingbtn(context),
    );
  }

  Widget _buildBodyWidget() {

    return Padding(padding: const EdgeInsets.all(10),
      child:BlocBuilder<PostsBloc,PostsState>(builder: (context,state){
        if(state is LoadingPostsState){
          return LoadingWidget();
        }else if(state is LoadedPostsState){
          return RefreshIndicator(child: PostListWidget(posts: state.post), onRefresh:()=> _onRefresh(context));
        }else if (state is ErrorPostsState){
          return MessageDisplayWidget( message: state.message,);
        }
          return LoadingWidget();

      },
      ) ,
    );

  }

  Widget _buildFloatingbtn( BuildContext context) {

    return FloatingActionButton(onPressed: (){

      Navigator.push(context,MaterialPageRoute(builder: (_)=>PostAddUpdate(iSupdate: false,)));



    },child: Icon(Icons.add),);


  }

  Future<void >_onRefresh(BuildContext context) async{


BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvents());






  }
}