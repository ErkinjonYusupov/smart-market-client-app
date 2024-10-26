class Pagination {
  int current_page;
  int last_page;
  Pagination({
    required this.current_page,
    required this.last_page,
  });
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
        current_page: json['current_page'], last_page: json['last_page']);
  }
}