
class ImagesModel {
  int height = 0;
  String url = '';
  int width = 0;

  ImagesModel();

  ImagesModel.fromJson(Map<String, dynamic> json) {
    height = json['height'] ?? 0;
    url = json['url'] ?? '';
    width = json['width'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}