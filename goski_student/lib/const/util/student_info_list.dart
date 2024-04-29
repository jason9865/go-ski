class StudentInfoList {
  final List<GridItem> heightList = [
    GridItem(name: '140cm 미만', isSelected: false),
    GridItem(name: '140cm ~ 149cm', isSelected: false),
    GridItem(name: '150cm ~ 159cm', isSelected: false),
    GridItem(name: '160cm ~ 169cm', isSelected: false),
    GridItem(name: '170cm ~ 179cm', isSelected: true),
    GridItem(name: '180cm 이상', isSelected: false),
  ];

  final List<GridItem> ageList = [
    GridItem(name: '미취학 아동', isSelected: false),
    GridItem(name: '초등학생', isSelected: false),
    GridItem(name: '중고등학생', isSelected: false),
    GridItem(name: '20대', isSelected: true),
    GridItem(name: '30대', isSelected: false),
    GridItem(name: '40대', isSelected: false),
    GridItem(name: '50대', isSelected: false),
    GridItem(name: '60대 이상', isSelected: false),
  ];

  final List<GridItem> weightList = [
    GridItem(name: '40kg 미만', isSelected: false),
    GridItem(name: '40kg ~ 49kg', isSelected: true),
    GridItem(name: '50kg ~ 59kg', isSelected: false),
    GridItem(name: '60kg ~ 69kg', isSelected: false),
    GridItem(name: '70kg ~ 79kg', isSelected: false),
    GridItem(name: '80kg ~ 89kg', isSelected: false),
    GridItem(name: '90kg ~ 99kg', isSelected: false),
    GridItem(name: '100kg 이상', isSelected: false),
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
