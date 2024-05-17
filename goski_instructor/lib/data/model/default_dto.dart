class DefaultDTO {
  final String status;
  final String? message;
  final String data;

  DefaultDTO({
    required this.status,
    this.message,
    required this.data,
  });

  factory DefaultDTO.fromJson(Map<String, dynamic> json) {
    return DefaultDTO(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
