import 'package:coba_crud/models/category.dart';
import 'package:coba_crud/screens/home_screens.dart';
import 'package:coba_crud/services/category_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget
{
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
{
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionControler = TextEditingController();
  var category;
  var _editcategoryNameController = TextEditingController();
  var _ceditategoryDescriptionControler = TextEditingController();
  var _category =Category();
  var _CategoryService = CategoryService();
  List<Category> _categoryList = List<Category>();

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  getAllCategories() async{
    _categoryList = List<Category>();
    var categories = await _CategoryService.readCategories();
    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.name =category['name'];
        categoryModel.description = category['description'];
        categoryModel.id =category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }
  _editCategory(BuildContext context, categoryId) async {
    category = await _CategoryService.readCategoriesId(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]['name'] ?? 'No Name';
      _ceditategoryDescriptionControler.text = category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }
  _showFormDialog(BuildContext context){

    return showDialog(context: context,
        barrierDismissible: true,
        builder: (param){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            onPressed: ()=> Navigator.pop(context),
          child: Text('Cancel'),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionControler.text;


                var result = await _CategoryService.saveCategory(_category);
                if(result >0)
                {
                  print(result);
                  Navigator.pop(context);
                  getAllCategories();
                }
              // print('Category: ${_categoryNameController.text}');
              // print('Description: ${_categoryDescriptionControler.text}');
            },
            child: Text('Save'),
          ),
        ],
        title: Text('Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  hintText: 'Write a categories',
                      labelText: 'Category'
                ),
              ),
              TextField(
                controller: _categoryDescriptionControler,
                decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _editFormDialog(BuildContext context){

    return showDialog(context: context,
        barrierDismissible: true,
        builder: (param){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            onPressed: ()=> Navigator.pop(context),
            child: Text('Cancel'),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              _category.id = category[0]['id'];
              _category.name = _editcategoryNameController.text;
              _category.description = _ceditategoryDescriptionControler.text;
              // _CategoryService.saveCategory(_category);

              var result = await _CategoryService.updateCategory(_category);

              if(result >0)
                {
                  print(result);
                  Navigator.pop(context);
                  getAllCategories();
                  _showSucccessSnackBar(Text('Updated'));
                }
              // print('Category: ${_categoryNameController.text}');
              // print('Description: ${_categoryDescriptionControler.text}');
            },
            child: Text('Update'),
          ),
        ],
        title: Text('Edit Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editcategoryNameController,
                decoration: InputDecoration(
                    hintText: 'Write a categories',
                    labelText: 'Category'
                ),
              ),
              TextField(
                controller: _ceditategoryDescriptionControler,
                  decoration: InputDecoration(
                    hintText: 'Write a description',
                    labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _deleteormDialog(BuildContext context, categoryId){

    return showDialog(context: context,
        barrierDismissible: true,
        builder: (param){
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                onPressed: ()=> Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {


                  var result = await _CategoryService.deleteCategory(categoryId);

                  if(result >0)
                  {
                    print(result);
                    Navigator.pop(context);
                    getAllCategories();
                    _showSucccessSnackBar(Text('Updated'));
                  }
                  // print('Category: ${_categoryNameController.text}');
                  // print('Description: ${_categoryDescriptionControler.text}');
                },
                child: Text('Delete'),
              ),
            ],
            title: Text('Are you sure you want to delete this?'),

          );
        });
  }

  _showSucccessSnackBar(message){
    var _snackbar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackbar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: ()=>Navigator.of(context)
          .push(MaterialPageRoute(builder: (context)=>HomeScreen())),
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.blue,
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length, itemBuilder: (context, index){
            return Card(
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
                  _editCategory(context, _categoryList[index].id);
                }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_categoryList[index].name),
                    IconButton(icon: Icon(Icons.delete,color: Colors.red),
                        onPressed: (){
                      _deleteormDialog(context, _categoryList[index].id);
                        })
                  ],
                ),
              ),
            );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: (){_showFormDialog(context);},
        child: Icon(Icons.add)),
    );
  }
}
