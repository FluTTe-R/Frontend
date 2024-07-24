import 'material.dart';
import 'package:flutter/material.dart';

class contents extends StatefulWidget {
  const contents({super.key});

  @override
  State<contents> createState() => _contentsState();
}

class _contentsState extends State<contents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder:(context,index){
          matter matte=Matterlist[index];
          return Card(
            child: ListTile(
              title: Text(matte.title),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(matte.imageurl),
              ),
              trailing: Icon(Icons.arrow_circle_right_outlined),
              
            ),
          );
      } ,itemCount: Matterlist.length,),
    );
    
  }
}
