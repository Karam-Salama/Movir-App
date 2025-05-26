import '../../../../core/utils/api_const.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
      id: jsonData[ApiKeys.id],
      name: jsonData[ApiKeys.name],
    );
  }
}
