class DefaultModel<T> {
  T? data;
  String? message;
  int? code;
  DefaultModel({
    required this.data,
    required this.message,
    this.code,
  });

  DefaultModel.fromJson(Map<String, dynamic> json) {
    try {
      switch (T) {
        // case const (List<BannerModel>):
        //   data = (json['data'] as List)
        //       .map((e) => BannerModel.fromJson(e))
        //       .toList() as T;
        //   break;

        // case DiscountDetailModel:
        //   data = DiscountDetailModel.fromJson(json['data']) as T?;
        //   break;

        default:
          data = json['data'];
          break;
      }
    } catch (e) {
      print('ERROR====> $e');
    }
    message = json['message'] ?? '';
    code = json['status_code'] ?? 0;
  }
}
