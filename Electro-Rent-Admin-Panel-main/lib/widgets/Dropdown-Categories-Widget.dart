import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Category-Dropdown-Controller.dart';

class DropDownCategoriesWidget extends StatelessWidget {
  const DropDownCategoriesWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
      init: CategoryDropDownController(),
      builder: (categoryDropDownController) {
        return SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: categoryDropDownController.selectedCategoryId?.value,
                      items: categoryDropDownController.categories
                          .map<DropdownMenuItem<String>>((category) {
                        return DropdownMenuItem<String>(
                          value: category['categoryId'], // Assuming 'categoryId' is the unique identifier
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  category["categoryImg"].toString(),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(category['categoryName']),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? selectedValue) async {
                        categoryDropDownController.setSelectedCategory(selectedValue);
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
          ),
        );
      },
    );
  }
}
