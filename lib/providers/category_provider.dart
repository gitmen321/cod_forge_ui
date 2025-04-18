import 'package:cod_forge_ui/models/category.dart';
import 'package:cod_forge_ui/services/category_services.dart';
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
    final initialData = await CategoryService.fetchCategories(page: 0);
    state = AsyncValue.data(CategoryState(categories: initialData));
    _currentPage = 1;
  } catch (e, st) {
    state = AsyncValue.error(e, st);
  }
}

//for errrror testtt:

// Future<void> _loadInitial() async {
//   await Future.delayed(const Duration(seconds: 1));

//   state = AsyncValue.data(CategoryState(categories: []));//no category ui 
//   state = AsyncValue.error("Something went wrong", StackTrace.current);
// }




Future<void> fetchMore() async {
  final currentState = state.value;
  if (currentState == null || currentState.isLoadingMore || currentState.hasReachedEnd) return;

  state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

  final newItems = await CategoryService.fetchCategories(page: _currentPage);

  if (newItems.isEmpty) {
    state = AsyncValue.data(currentState.copyWith(isLoadingMore: false, hasReachedEnd: true));
  } else {
    state = AsyncValue.data(CategoryState(
      categories: [...currentState.categories, ...newItems],
      isLoadingMore: false,
      hasReachedEnd: newItems.length < _pageSize,
    ));
    _currentPage++;
  }
}
}
