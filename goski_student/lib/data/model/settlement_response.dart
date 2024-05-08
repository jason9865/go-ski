

class SettlementResponse {
  String teamName;
  String userName;
  String? instructorName;
  int totalAmount;
  DateTime paymentDate;
  int paymentStatus;
  String chargeName;
  int charge;
  int basicFee;
  int designatedFee;
  int peopleOptionFee;
  int levelOptionFee;

  SettlementResponse({
    required this.teamName,
    required this.userName,
    this.instructorName,
    required this.totalAmount,
    required this.paymentDate,
    required this.paymentStatus,
    required this.chargeName,
    required this.charge,
    required this.basicFee,
    required this.designatedFee,
    required this.peopleOptionFee,
    required this.levelOptionFee,
  });

  factory SettlementResponse.fromJson(Map<String, dynamic> json) {
    return SettlementResponse(
      teamName: json['teamName'] as String,
      userName: json['userName'] as String,
      instructorName: json['instructorName'] as String?,
      totalAmount: json['totalAmount'] as int,
      paymentDate: DateTime.parse(json['paymentDate']),
      paymentStatus: json['paymentStatus'] as int,
      chargeName: json['chargeName'] as String,
      charge: json['charge'] as int,
      basicFee: json['basicFee'] as int,
      designatedFee: json['designatedFee'] as int,
      peopleOptionFee: json['peopleOptionFee'] as int,
      levelOptionFee: json['levelOptionFee'] as int,
    );
  }

  @override
  String toString() {
    return 'SettlementResponse{teamName: $teamName, userName: $userName, instructorName: $instructorName, totalAmount: $totalAmount, paymentDate: $paymentDate, paymentStatus: $paymentStatus, chargeName: $chargeName, charge: $charge, basicFee: $basicFee, designatedFee: $designatedFee, peopleOptionFee: $peopleOptionFee, levelOptionFee: $levelOptionFee}';
  }
}

class Settlement {
  String teamName;
  String userName;
  String? instructorName;
  int totalAmount;
  DateTime paymentDate;
  int paymentStatus;
  String chargeName;
  int charge;
  int basicFee;
  int designatedFee;
  int peopleOptionFee;
  int levelOptionFee;
  bool isExpanded;

  Settlement({
    required this.teamName,
    required this.userName,
    this.instructorName,
    required this.totalAmount,
    required this.paymentDate,
    required this.paymentStatus,
    required this.chargeName,
    required this.charge,
    required this.basicFee,
    required this.designatedFee,
    required this.peopleOptionFee,
    required this.levelOptionFee,
    this.isExpanded = false,
  });

  @override
  String toString() {
    return 'Settlement{teamName: $teamName, userName: $userName, instructorName: $instructorName, totalAmount: $totalAmount, paymentDate: $paymentDate, paymentStatus: $paymentStatus, chargeName: $chargeName, charge: $charge, basicFee: $basicFee, designatedFee: $designatedFee, peopleOptionFee: $peopleOptionFee, levelOptionFee: $levelOptionFee, isExpanded: $isExpanded}';
  }
}

extension SettlementResponseToSettlement on SettlementResponse {
  Settlement toSettlement() {
    return Settlement(
      teamName: teamName,
      userName: userName,
      instructorName: instructorName,
      totalAmount: totalAmount,
      paymentDate: paymentDate,
      paymentStatus: paymentStatus,
      chargeName: chargeName,
      charge: charge,
      basicFee: basicFee,
      designatedFee: designatedFee,
      peopleOptionFee: peopleOptionFee,
      levelOptionFee: levelOptionFee,
    );
  }
}
