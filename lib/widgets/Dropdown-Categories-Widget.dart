import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Category-Dropdown-Controller.dart';

class DropDownCategoriesWidget extends StatelessWidget {
  const DropDownCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
      init: CategoryDropDownController(),
        builder:
        (categoryDropDownController) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 10,
                child: Padding(padding: EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: categoryDropDownController.selectedCategoryId?.value,
                    items: categoryDropDownController
                        .categories
                        .map((category) {
                          return DropdownMenuItem<String>(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(category["categoryImg"].toString()),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(category['categoryName']),
                                ],
                              ),
                          );
                        },
                    )
                        .toList(),
                    onChanged: (String? selectedValue) async {
                      categoryDropDownController.setSelectedCategory(selectedValue);
                      String? categoryName = await categoryDropDownController.getCategoryName(selectedValue);

                      categoryDropDownController.setSelectedCategoryName(categoryName)
                    },
                    hint: Text("Select Product Category"),
                    isExpanded: true,
                    elevation: 10,
                    underline: SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ],
        );
        });
  }
}
