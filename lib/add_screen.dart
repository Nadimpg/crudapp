import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _namecontroller=TextEditingController();
   final TextEditingController _codeecontroller=TextEditingController();
    final TextEditingController _unitpcontroller=TextEditingController();
     final TextEditingController _imagecontroller=TextEditingController();
      final TextEditingController _quantitycontroller=TextEditingController();
        final TextEditingController _totalcontroller=TextEditingController();
        GlobalKey<FormState> _formkey=GlobalKey();

        Future<void> getproductlistfromapi(
          String ProductName,String ProductCode,String UnitPrice,String Img,String Qty,String TotalPrice
        )async{
  
            String url='https://crud.teamrabbil.com/api/v1/CreateProduct';
            Uri uri=Uri.parse(url);
            http.Response response=await http.post(uri,
            headers: {
              'Content-Type':'application/json',
              'Accept' :'appli,cation/json'
            },
            body: jsonEncode({
                    "Img":Img,
                    "ProductCode":ProductCode,
                    "ProductName":ProductName,
                    "Qty":Qty,
                    "TotalPrice":TotalPrice,
                    "UnitPrice":UnitPrice
                })
                
            );
            if (response.statusCode==200) {
                print('Successfully');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added Succesfully')));
                 _namecontroller.text='';
                 _codeecontroller.text='';
                  _unitpcontroller.text='';
                   _imagecontroller.text='';
                    _quantitycontroller.text='';
                    _totalcontroller.text='';

            }else{
              print('failed');
            }
 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your product name';
                    }
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    hintText: 'Product name',
                  ),
                ),
                TextFormField(
                   validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your product code';
                    }
                  },
                  controller: _codeecontroller,
                  decoration: InputDecoration(
                    hintText: 'Product code',
                  ),
                ),
                TextFormField(
                   validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your unit price ';
                    }
                  },
                  controller: _unitpcontroller,
                  decoration: InputDecoration(
                    hintText: 'unit price',
                  ),
                ),
                TextFormField(
                   validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your image';
                    }
                  },
                  controller: _imagecontroller,
                  decoration: InputDecoration(
                    hintText: 'image',
                  ),
                ),
                TextFormField(
                   validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your quantity';
                    }
                  },
                  controller: _quantitycontroller,
                  decoration: InputDecoration(
                    hintText: 'quantity',
                  ),
                ),
                TextFormField(
                   validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your total price ';
                    }
                  },
                  controller: _totalcontroller,
                  decoration: InputDecoration(
                    hintText: 'total price',
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if (_formkey.currentState!.validate()) {
                   getproductlistfromapi(
                    _namecontroller.text,
                   _codeecontroller.text,
                    _unitpcontroller.text,
                     _imagecontroller.text,
                      _quantitycontroller.text,
                      _totalcontroller.text,
                      
                      );
                  }
                 
                }, child: Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}