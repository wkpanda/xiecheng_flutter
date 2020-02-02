class SearchModel{
  final List<SearchItem> data;
  String keyword;
  SearchModel({this.data});
  factory SearchModel.fromJson(Map<String,dynamic> json){
    var dataJson = json['data'] as List;
    List<SearchItem> data = dataJson.map((i)=>SearchItem.fromJson(i)).toList();
    return SearchModel(data: data);
  }
  
}

class SearchItem{
  final String word;
  final String type;
  final String url;
  final String star;
  final String zonename;
  final String districtname;
  final String price;

  SearchItem({this.word,this.type,this.url,this.star,this.zonename,this.districtname,this.price});

  factory SearchItem.fromJson(Map<String,dynamic> json){
    return SearchItem(
      word: json['word'],
      type: json['type'],
      url: json['url'],
      star: json['star'],
      zonename: json['zonename'],
      districtname: json['districtname'],
      price:json['price']
    );
  }


}