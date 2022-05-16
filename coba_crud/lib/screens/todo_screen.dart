

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();

  var todoDescController = TextEditingController();

  var todoDateleController  =  TextEditingController();

  var _selectedValue;

  var _categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Create todo'),
      ),
   body : Padding(
     padding: EdgeInsets.all(16.0),
     child: Column(
       children: <Widget>[
         TextField(
           controller: todoTitleController,
           decoration: InputDecoration(
             labelText: 'Title',
             hintText: 'Write todo title'
           ),
         ),
         TextField(
           controller: todoDescController,
           decoration: InputDecoration(
               labelText: 'Description',
               hintText: 'Write todo Description'
           ),
         ),
         TextField(
           controller: todoDateleController,
           decoration: InputDecoration(
               labelText: 'Date',
               hintText: 'Pick a Date',
             prefixIcon: InkWell(
               onTap: (){},
               child: Icon(Icons.calendar_today),
             )
           ),
         ),
         DropdownButtonFormField(
             value: _selectedValue,
             items: _categories,
             hint: Text('Category'),
             onChanged: (value){
               setState(() {
                 _selectedValue = value;
               });
             },
         ),
         SizedBox(
           height: 20,
         ),
         RaisedButton(onPressed: (){}, color: Colors.blue, child: Text('Save'),textColor: Colors.white,)
       ],
     ),
   )
    );
  }
}
