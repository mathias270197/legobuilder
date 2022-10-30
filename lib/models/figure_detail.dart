class FigureDetail {
  String figureName;
  String date;
  String textReview;
  int stars;
  String user;

  FigureDetail(
      {required this.figureName,
      required this.date,
      required this.textReview,
      required this.stars,
      required this.user});

  factory FigureDetail.fromJson(Map<String, dynamic> json) {
    return FigureDetail(
      figureName: json['figureName'],
      date: json['date'],
      textReview: json['textReview'],
      stars: json['stars'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() => {
        'figureName': figureName,
        'date': date,
        'textReview': textReview,
        'stars': stars,
        'user': user,
      };
}
