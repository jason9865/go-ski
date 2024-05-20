class KakaoPayPrepareResponse {
  String tid;
  String next_redirect_app_url;
  String next_redirect_mobile_url;
  String next_redirect_pc_url;
  String android_app_scheme;
  String ios_app_scheme;
  String created_at;

  KakaoPayPrepareResponse({
    required this.tid,
    required this.next_redirect_app_url,
    required this.next_redirect_mobile_url,
    required this.next_redirect_pc_url,
    required this.android_app_scheme,
    required this.ios_app_scheme,
    required this.created_at,
  });

  factory KakaoPayPrepareResponse.fromJson(Map<String, dynamic> json) {
    return KakaoPayPrepareResponse(
      tid: json['tid'] as String,
      next_redirect_app_url: json['next_redirect_app_url'] as String,
      next_redirect_mobile_url: json['next_redirect_mobile_url'] as String,
      next_redirect_pc_url: json['next_redirect_pc_url'] as String,
      android_app_scheme: json['android_app_scheme'] as String,
      ios_app_scheme: json['ios_app_scheme'] as String,
      created_at: json['created_at'] as String,
    );
  }
}
