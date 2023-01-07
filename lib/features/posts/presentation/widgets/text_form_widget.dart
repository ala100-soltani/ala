import 'package:flutter/material.dart';

class TextFormFieldWidget  extends StatelessWidget{
 final bool multiline;

 final String name;

  final TextEditingController controller;


  TextFormFieldWidget({required String this.name,required bool this.multiline, required TextEditingController this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(child:Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),child:
    TextFormField(maxLines:this.multiline ? 6 : 1,minLines:this.multiline ? 6  : 1, controller: this.controller,
      validator: (val)=>val!.isEmpty? "${this.name} cant be empty":null,)));
  }


}