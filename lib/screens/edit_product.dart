import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({required this.product});
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageURLController = TextEditingController();
  Future updateProduct() async{
   final response = 
    await http.put(Uri.parse("http://192.168.43.189:80/api/products/" + product['id'].toString()), 
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
        title:  Text("Edit Product"),
        ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = product['nama'],
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
              controller: _descriptionController..text = product['description'],
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
              controller: _priceController..text = product['price'],
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
              controller: _imageURLController..text = product['image_url'],
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
                  updateProduct().then((value) {
                    Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder:(context) => HomePage() ) );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Berhasil di Ubah")));
                  });
                  
                }
                
            }, 
            child: Text("Update"))

          ]
        ),
      )
    );
  }
}