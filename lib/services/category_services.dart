import 'dart:async';
import 'package:cod_forge_ui/models/category.dart';
// import 'package:cod_forge_ui/models/category_model.dart';

class CategoryService {
  static const int _itemsPerPage = 8;

  static final List<CategoryModel> allCategories = List.generate(30, (index) {
  final List<String> dummyNames = [
    'Fertilizers',
    'Seeds',
    'Irrigation Tools',
    'Agricultural Tools',
    'Agricultural Basins',
    'Offers & Requests',
    'Tractors',
    'Greenhouse Supplies',
    'Organic Products',
    'Harvesting Equipment',
  ];

  final name = dummyNames[index % dummyNames.length];
  return CategoryModel(
    id: '$index',
    name: name,
    imageUrl: getCategoryImage(name),
  );
});


  static Future<List<CategoryModel>> fetchCategories({required int page}) async {
    await Future.delayed(const Duration(seconds: 2));
    final startIndex = page * _itemsPerPage;
    if (startIndex >= allCategories.length) return [];
    final endIndex = (startIndex + _itemsPerPage).clamp(0, allCategories.length);
    return allCategories.sublist(startIndex, endIndex);
  }
}

String getCategoryImage(String name) {
  switch (name.toLowerCase()) {
    case 'fertilizers':
      return 'https://cdn-icons-png.flaticon.com/512/2909/2909763.png';
    case 'seeds':
      return 'https://cdn-icons-png.flaticon.com/512/4264/4264724.png';
    case 'irrigation tools':
      return 'https://cdn-icons-png.flaticon.com/512/609/609803.png';
    case 'agricultural tools':
      return 'https://cdn-icons-png.flaticon.com/512/3433/3433951.png';
    case 'tractors':
      return 'https://cdn-icons-png.flaticon.com/512/2250/2250210.png';
    case 'organic products':
      return 'https://cdn-icons-png.flaticon.com/512/3081/3081559.png';
    default:
      return 'https://cdn-icons-png.flaticon.com/512/7667/7667373.png';
  }
}
