import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagInputController extends GetxController {
  final List<Tag> tags = [];
  final inputController = TextEditingController();
  final focusNode = FocusNode();

  TagInputController({required List<Tag> tags}) {
    this.tags.assignAll(tags);
  }

  String get newTagText => inputController.text.trim().toLowerCase();

  @override
  void onInit() {
    super.onInit();
    focusNode.requestFocus();
  }

  Future<void> addTag(String newTag) async {
    if (newTag.isEmpty) return;
    if (tags.firstWhereOrNull((element) => element.name == newTag) != null)
      return;

    final existingTag = await kTagRepo.findByName(newTag);
    final tag = existingTag ?? Tag.create(name: newTag);
    tags.add(tag);
    inputController.clear();
    update();
  }

  Future<List<Tag>> searchTag(String pattern) async {
    return await kTagRepo.search(pattern.trim());
  }

  void removeTag(Tag e) {
    tags.removeWhere((element) => element.name == e.name);
    update();
  }
}
