class StudentInfoSelectList {
  final List<GridItem> heightList = [
    GridItem(name: "HEIGHT_UNDER_140CM", isSelected: false),
    GridItem(name: "HEIGHT_140CM_TO_149CM", isSelected: false),
    GridItem(name: "HEIGHT_150CM_TO_159CM", isSelected: false),
    GridItem(name: "HEIGHT_160CM_TO_169CM", isSelected: false),
    GridItem(name: "HEIGHT_170CM_TO_179CM", isSelected: false),
    GridItem(name: "HEIGHT_ABOVE_180CM", isSelected: false),
  ];

  final List<GridItem> ageList = [
    GridItem(name: "PRESCHOOL_CHILD", isSelected: false),
    GridItem(name: "ELEMENTARY", isSelected: false),
    GridItem(name: "MIDDLE_HIGH", isSelected: false),
    GridItem(name: "TWENTIES", isSelected: false),
    GridItem(name: "THIRTIES", isSelected: false),
    GridItem(name: "FORTIES", isSelected: false),
    GridItem(name: "FIFTIES", isSelected: false),
    GridItem(name: "SIXTIES_OVER", isSelected: false),
  ];

  final List<GridItem> weightList = [
    GridItem(name: "WEIGHT_UNDER_40KG", isSelected: false),
    GridItem(name: "WEIGHT_40KG_TO_49KG", isSelected: false),
    GridItem(name: "WEIGHT_50KG_TO_59KG", isSelected: false),
    GridItem(name: "WEIGHT_60KG_TO_69KG", isSelected: false),
    GridItem(name: "WEIGHT_70KG_TO_79KG", isSelected: false),
    GridItem(name: "WEIGHT_80KG_TO_89KG", isSelected: false),
    GridItem(name: "WEIGHT_90KG_TO_99KG", isSelected: false),
    GridItem(name: "WEIGHT_ABOVE_100KG", isSelected: false),
  ];
}

class GridItem {
  final String name;
  bool isSelected;

  GridItem({
    required this.name,
    required this.isSelected,
  });
}
