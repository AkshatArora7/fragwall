class WallpaperModel{
  String photographer;
  String categoryUrl;
  int photographer_id;
  SrcModel src;

  WallpaperModel({this.photographer, this.src, this.photographer_id, this.categoryUrl});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData){
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      categoryUrl: jsonData["url"],
      photographer: jsonData["photographer"],
      photographer_id: jsonData["photographer_id"]
    );
}

}

class SrcModel{
  String original;
  String small;
  String portrait;

  SrcModel({this.portrait, this.original, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(
      portrait: jsonData["portrait"],
      original: jsonData["original"],
      small: jsonData["small"]
    );
  }
}