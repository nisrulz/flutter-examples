import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/category.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final List<Category> categories = [];
  bool loading = false;
  bool dataLoaded = false;

  @override
  void onInit() {
    super.onInit();

    loadDataWithState(
      data: () => loadCategories(),
      onStateChange: (state) {
        loading = state == DataLoaderState.loading;
        dataLoaded = state == DataLoaderState.loaded;
        update();
      },
    );
  }

  Future<void> loadCategories() async {
    final result = await kCategoryRepo.findAll();
    categories.assignAll(result);
    update();
  }

  Future<void> deleteCategory(Category category) async {
    await kCategoryRepo.delete(category);
    loadCategories();
  }
}
