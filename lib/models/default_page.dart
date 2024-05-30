// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

class DefaultPaging<T> {
  int? total_page;
  int? current_page;
  int? total_record;
  int? num_record;
  T? results;
  DefaultPaging({
    this.total_page,
    this.current_page,
    this.total_record,
    this.results,
    this.num_record,
  });

  DefaultPaging.fromJson(Map<String, dynamic> map) {
    total_page = map['total_page'];
    current_page = map['current_page'];
    total_record = map['total_record'];
    num_record = map['num_record'];
    try {
      switch (T) {
        // case const (List<ListDiscountModel>):
        //   results = (map['results'] as List)
        //       .map((e) => ListDiscountModel.fromJson(e))
        //       .toList() as T;
        //   break;

        default:
          results = map['results'];
          break;
      }
    } catch (e) {
      print('here $e');
    }
  }
}
