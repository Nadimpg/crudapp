import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:newapp/API/productlist.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/add_screen.dart';
import 'package:newapp/getproductlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  productlist? productpojolist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getproductlistfromapi();
  }
  
Future<void> getproductlistfromapi()async{
  
  String url='https://crud.teamrabbil.com/api/v1/ReadProduct';
  Uri uri=Uri.parse(url);
  http.Response response=await http.get(uri);
  if (response.statusCode==200) {
      productpojolist=productlist.fromJson(jsonDecode(response.body));
      setState(() {
        
      });
  }
 }

 Future<void> deleteproductlistfromapi()async{
  
  String url='https://crud.teamrabbil.com/api/v1/DeleteProduct/639da5960817590a4e4fd53c/${productId}';
  Uri uri=Uri.parse(url);
  http.Response response=await http.post(uri);
  if (response.statusCode==200) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added Succesfully')));
  }
 }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>AddScreen()));},child: Icon(Icons.add),),
        body: ListView.builder(
            itemCount: productpojolist?.data?.length ?? 0,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(productpojolist?.data?[index].productName ??''),
                subtitle: Text(productpojolist?.data?[index].productCode ??''),
                trailing: Text(productpojolist?.data?[index].unitPrice ??''),
              );
            }),
      ),
    );
  }
}
