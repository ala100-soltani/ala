import 'package:clean_code_project/features/posts/core/widget/loading_widget.dart';
import 'package:clean_code_project/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean_code_project/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_code_project/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/snack_bar.dart';
import '../../domain/entities/post.dart';
import '../widgets/form_widget.dart';


class PostAddUpdate extends StatelessWidget{

  final Post? post;

  final bool iSupdate;

  PostAddUpdate({ this.post, required this.iSupdate});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text(iSupdate? "Edit Post" : "Update Post"),),


    body: _buildBody(),
    );
  }

 Widget _buildBody() {

    return Center(child: Padding(padding: EdgeInsets.all(10),
    child: BlocConsumer<AddDeleteUpdateBloc,AddDeleteUpdateState>
      (builder:(context,state){
        if(state is LoadingAddDeleteUpdateState){
          return LoadingWidget();
        }
        return FormWidget(iSupdate:iSupdate,post:iSupdate? post :null );

    }, listener: (context,state){

        if(state is MessageAddDeleteUpdateState){
          SnackBarMessage().showSuccessSnackbar(message: state.message, context: context);

          
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>PostsPage()), (route) => false);
        }else if(state is ErrorAddDeleteUpdateState){

          SnackBarMessage().showErrorSnackbar(message: state.message, context: context);


        }
    })),
    );



  }





}