import 'package:expense_manager/constants.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagsController extends GetxController {
  final List<Tag> tags = [];
  final renameController = TextEditingController();
  bool loading = false;
  bool dataLoaded = false;

  get hasTags => tags.isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    loadDataWithState(
      data: () => searchTags(),
      onStateChange: (state) {
        loading = state == DataLoaderState.loading;
        dataLoaded = state == DataLoaderState.loaded;
        update();
      },
    );
  }

  Future<void> searchTags({
    String text = '',
  }) async {
    if (text.trim().isNotEmpty && text.length < 3) return;
    final tags = text.trim().isEmpty
        ? await kTagRepo.findAll()
        : await kTagRepo.search(text);
    this.tags.assignAll(tags);

    update();
  }

  Future<void> deleteTag(Tag tag) async {
    await kTagRepo.delete(tag);
    tags.remove(tag);
    update();
  }

  Future<void> renameTag(Tag tag, String newName) async {
    tag.name = newName.trim().toLowerCase();
    await kTagRepo.save(tag);
    update();
  }
}
