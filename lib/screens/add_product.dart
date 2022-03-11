import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageURLController = TextEditingController();
  Future saveProduct() async{
   final response = 
    await http.post(Uri.parse("http://192.168.43.189:80/api/products"), 
    body: {
      "nama" : _nameController.text,
      "description" : _descriptionController.text,
      "price" : _priceController.text,
      "image_url" : _imageURLController.text

    });
  
  return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add Product"),
        ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama"),
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Please enter product name';
                  }
                  return null;
                },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description"),
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Please enter product description';
                  }
                  return null;
                },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: "Price"),
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Please enter product price';
                  }
                  return null;
                },
            ),
            TextFormField(
              controller: _imageURLController,
              decoration: InputDecoration(
                labelText: "Image URL"),
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Please enter product image url';
                  }
                  return null;
                },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if ( _formKey.currentState!.validate() ) {
                  saveProduct().then((value) {
                    Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) => HomePage() ) );
                      ScaffoldMessenger.of(
                        context).showSnackBar(
                          SnackBar(
                            content: Text("Product Berhasil di Tambahkan")));
                  });
                  
                }
                
            }, 
            child: Text("Save"))

          ]
        ),
      )
    );
  }
}