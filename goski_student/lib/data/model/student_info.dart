class StudentInfo {
  String name;
  String gender; //ENUM : MALE, FEMALE
  String height; //ENUM : ??? cm ~ >>> cm
  String weight; //ENUM : ?? kg ~ ?? kg
  int footSize;
  String age; //ENUM : underForties ...

  StudentInfo({
    this.name = '',
    this.gender = 'MALE',
    this.height = '',
    this.weight = '',
    this.footSize = 0,
    this.age = '',
  });

  bool isValid() {
    return name != '' &&
        height != '' &&
        weight != '' &&
        footSize != 0 &&
        age != '';
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "height": height,
      "weight": weight,
      "footSize": footSize,
      "age": age
    };
  }

  @override
  String toString() {
    return 'StudentInfo{name: $name, gender: $gender, height: $height, weight: $weight, footSize: $footSize, age: $age}';
  }
}

//('HEIGHT_UNDER_140CM','HEIGHT_140CM_TO_149CM','HEIGHT_150CM_TO_159CM','HEIGHT_160CM_TO_169CM','HEIGHT_170CM_TO_179CM','HEIGHT_ABOVE_180CM')

//('WEIGHT_UNDER_40KG','WEIGHT_40KG_TO_49KG','WEIGHT_50KG_TO_59KG','WEIGHT_60KG_TO_69KG','WEIGHT_70KG')

//('PRESCHOOL_CHILD','ELEMENTARY','MIDDLE_HIGH','TWENTIES','THIRTIES','FORTIES','FIVTIES','SIXTIES_OVER')
