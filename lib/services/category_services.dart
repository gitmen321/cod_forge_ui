import 'dart:async';
import 'package:cod_forge_ui/models/category.dart';
// import 'package:cod_forge_ui/models/category_model.dart';

class CategoryService {
  static const int _itemsPerPage = 6;

  static final List<CategoryModel> _allCategories = List.generate(30, (index) {
    final List<String> _dummyNames = [
      'Fertilizers',
      'Seeds',
      'Irrigation Tools',
      'Agricultural Tools',
      'Agricultural Basins',
      'Offers & Requests',
      'Tractors',
      'Greenhouse Supplies',
      'Organic Products',
      'Harvesting Equipment'
    ];

    return CategoryModel(
      id: '$index',
      name: _dummyNames[index % _dummyNames.length],
      imageUrl:
          'https://cdn-icons-png.flaticon.com/512/7667/7667373.png',
    );
  });

  static Future<List<CategoryModel>> fetchCategories({required int page}) async {
    await Future.delayed(const Duration(seconds: 2));
    final startIndex = page * _itemsPerPage;
    if (startIndex >= _allCategories.length) return [];
    final endIndex = (startIndex + _itemsPerPage).clamp(0, _allCategories.length);
    return _allCategories.sublist(startIndex, endIndex);
  }
}

