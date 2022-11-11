class ARImageResponse {
  String imageScanned;

  ARImageResponse({required this.imageScanned});
  
  factory ARImageResponse.fromJson(Map<String, dynamic> json) {
    return ARImageResponse(
      imageScanned: json['image_clicked'],
    );
  }

}