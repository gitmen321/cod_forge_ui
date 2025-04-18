// category_provider.dart
import 'package:cod_forge_ui/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cod_forge_ui/models/category_model.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<CategoryState>>(
  (ref) => CategoryNotifier(),
);

class CategoryNotifier extends StateNotifier<AsyncValue<CategoryState>> {
  CategoryNotifier() : super(const AsyncValue.loading()) {
    _loadInitial();
  }

  static const int _pageSize = 10;
  int _currentPage = 0;

  Future<void> _loadInitial() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final initialData = _generateMockCategories(0, _pageSize);
      state = AsyncValue.data(CategoryState(categories: initialData));
      _currentPage = 1;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchMore() async {
    final currentState = state.value;
    if (currentState == null ||
        currentState.isLoadingMore ||
        currentState.hasReachedEnd) return;

    state = AsyncValue.data(
      currentState.copyWith(isLoadingMore: true),
    );

    await Future.delayed(const Duration(seconds: 1));

    final newItems = _generateMockCategories(_currentPage, _pageSize);

    if (newItems.isEmpty) {
      state = AsyncValue.data(
        currentState.copyWith(
          isLoadingMore: false,
          hasReachedEnd: true,
        ),
      );
    } else {
      state = AsyncValue.data(
        CategoryState(
          categories: [...currentState.categories, ...newItems],
          isLoadingMore: false,
          hasReachedEnd: newItems.length < _pageSize,
        ),
      );
      _currentPage++;
    }
  }

  List<CategoryModel> _generateMockCategories(int page, int limit) {
    const total = 30;
    final start = page * limit;
    if (start >= total) return [];
    final end = (start + limit).clamp(0, total);
    return List.generate(end - start, (i) {
      final index = start + i;
      return CategoryModel(
        id: '$index',
        name: 'Category $index',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/7667/7667373.png',
      );
    });
  }
}
