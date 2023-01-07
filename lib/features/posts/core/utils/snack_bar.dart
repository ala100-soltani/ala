
import 'package:flutter/material.dart';
class SnackBarMessage{


  void showSuccessSnackbar({required String message , required BuildContext context}){


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.green,));

  }

  void showErrorSnackbar({required String message , required BuildContext context}){


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,));

  }


}