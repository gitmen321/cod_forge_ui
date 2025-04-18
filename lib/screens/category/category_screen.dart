import 'package:cod_forge_ui/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/category_provider.dart';
import '../../core/widgets/category_tile.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(categoryProvider.notifier).fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      ),
      body: categoryState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 52, 140, 54),
            strokeWidth: 6,
          ),
        ),

        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              const Text(
                "Something went wrong!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text('$err'),
              const SizedBox(height: 16),
              ElevatedButton(
                style:  ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 52, 140, 54),
                ),
                onPressed: () {
                  ref.refresh(categoryProvider);
                },
                child: const Text("Retry", style: TextStyle(
                  color: Colors.black
                ),),
              )
            ],
          ),
        ),

        data: (state) {
          if (state.categories.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "No categories available.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = CategoryService.allCategories[index];
                      return CategoryTile(category: category);
                    },
                    childCount: CategoryService.allCategories.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(context),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 12,
                    childAspectRatio: 4 / 3.5,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: state.isLoadingMore
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : state.hasReachedEnd
                            ? const Text(
                                "End",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1000) return 5;
    if (width >= 700) return 4;
    if (width >= 500) return 3;
    return 2;
  }
}
