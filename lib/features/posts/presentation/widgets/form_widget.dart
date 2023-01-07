import 'package:clean_code_project/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean_code_project/features/posts/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import 'form_submit_widget.dart';

class FormWidget extends StatefulWidget{

  final bool iSupdate;
  final Post? post;

  FormWidget({required this.iSupdate, this.post});

  @override
  State<FormWidget> createState()=>_FormWidgetState();


}
class _FormWidgetState extends State<FormWidget>{

  final _formKey=GlobalKey<FormState>();

  final TextEditingController _titleController= TextEditingController();
  final TextEditingController _bodyController= TextEditingController();

  @override
  void initState() {
    if(widget.iSupdate){
      _titleController.text=widget.post!.title;
      _bodyController.text= widget.post!.body;

    }
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Container(child:Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget> [
          TextFormFieldWidget(name:"title",multiline:false,controller:_titleController),
          TextFormFieldWidget(name:"body",multiline:true,controller:_bodyController),


          FormSubmitBtn(onpressed:validateFormThenUpdateOrAdd,isupdate:widget.iSupdate),




      ],),

    ));

  }

  void validateFormThenUpdateOrAdd(){

    final validate= _formKey.currentState!.validate();
    
    final post=Post(id: widget.iSupdate ? widget.post!.id : null, title:_titleController.text, body: _bodyController.text);


    if(validate){
      

      if(widget.iSupdate){

        BlocProvider.of<AddDeleteUpdateBloc>(context).add(UpdatePostEvent(post: post));


      }else{
        BlocProvider.of<AddDeleteUpdateBloc>(context).add(AddPostEvent(post: post));

      }



    }





  }
}