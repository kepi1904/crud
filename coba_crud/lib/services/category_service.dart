import 'package:coba_crud/models/category.dart';
import 'package:coba_crud/repositories/repository.dart';

class CategoryService{
  Repository _repository;

  CategoryService(){
    _repository = Repository();
}
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  readCategories() async{
    return await _repository.readData('categories');
  }

  readCategoriesId(categoryId) async{
    return await _repository.readDataById('categories', categoryId);
  }
//update data from table
  updateCategory(Category category) async{
    return await _repository.updateData('categories',category.categoryMap());
  }

  deleteCategory(categoryId) async{
    return await _repository.deleteData('categories', categoryId);
  }
}