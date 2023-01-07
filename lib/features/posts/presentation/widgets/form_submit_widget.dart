import 'package:flutter/material.dart';



class FormSubmitBtn extends StatelessWidget{
  final bool isupdate;
  final void Function() onpressed;


  FormSubmitBtn({required this.isupdate, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return ElevatedButton.icon(onPressed: this.onpressed, icon: this.isupdate? Icon(Icons.edit):Icon(Icons.add),
       label: this.isupdate? Text("update "):Text("add"));
  }





}