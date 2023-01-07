
import 'package:flutter/material.dart';


class MessageDisplayWidget extends StatelessWidget{
  final String message;

  MessageDisplayWidget({required this.message});

  @override
  Widget build(BuildContext context) {
   return Container(height: MediaQuery.of(context).size.height /3,
   child:SingleChildScrollView(child:Text(this.message)) ,);
  }
  
  
  
}