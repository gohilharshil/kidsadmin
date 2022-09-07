class CategoryModel {
  String? name;
  int? indx;
  String? imageURL;
  List<String>? grade;

  CategoryModel(this.name, this.indx, this.imageURL, this.grade);
}

class CategoryList {
  List<CategoryModel>? _category;

  CategoryList() {
    _category = [
      CategoryModel(
          "Alphabet",
          0,
          "https://raw.githubusercontent.com/gohilharshil/image-data-all/main/blocks.png",
          ["0", "1", "3"]),
      CategoryModel(
          "Birds",
          1,
          "https://raw.githubusercontent.com/gohilharshil/image-data-all/main/parrot.png",
          ["1", "2", "3"]),
      CategoryModel(
          "Shape",
          2,
          "https://raw.githubusercontent.com/gohilharshil/image-data-all/main/shapes.png",
          ["2", "3", "4"]),
      CategoryModel(
          "Numbers",
          3,
          "https://raw.githubusercontent.com/gohilharshil/image-data-all/main/numbers.png",
          ["3", "4", "5", "6", "7", "8", "2"]),
    ];
  }

  List<CategoryModel>? get categoryList => _category;
}
//doc is category