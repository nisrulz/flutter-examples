import 'package:expense_manager/components/tag_list_item.dart';
import 'package:expense_manager/controllers/tags_controller.dart';
import 'package:expense_manager/components/custom_divider.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/components/misc/placeholder_view.dart';
import 'package:expense_manager/components/misc/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  TagsController get _controller => Get.find<TagsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Tags",
      body: GetBuilder<TagsController>(
        init: TagsController(),
        builder: (controller) {
          return Column(
            children: [
              // search bar
              Padding(
                padding: EdgeInsets.all(10).copyWith(bottom: 0),
                child: CustomSearchBar(
                  onSearch: (value) => _controller.searchTags(text: value),
                ),
              ),

              // tags
              Expanded(
                child: PlaceholderView(
                  title: "No tags",
                  description:
                      "Looks like you haven't added any tag to your expenses yet.",
                  show: !controller.hasTags && controller.dataLoaded,
                  loading: controller.loading,
                  child: _buildTags(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 8, bottom: 100),
      itemCount: _controller.tags.length,
      separatorBuilder: (context, index) => CustomDivider(),
      itemBuilder: (context, index) {
        final tag = _controller.tags[index];
        return TagListItem(
          tag: tag,
          controller: _controller,
        );
      },
    );
  }
}
