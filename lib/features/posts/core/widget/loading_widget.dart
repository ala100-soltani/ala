
import 'package:flutter/material.dart';




class LoadingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: const EdgeInsets.symmetric(vertical: 20),
    child: Center(child: SizedBox(height: 30,width: 30,
      child:CircularProgressIndicator(color: Colors.teal,) ,),),);
  }
  
}