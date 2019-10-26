class Post {
  final String title;
  final String date;
  final String area;
  final String guides;

  Post({this.title,this.date,this.area,this.guides});

  factory Post.fromJson(Map<String,dynamic> parsedJson){
    return Post(
      title:parsedJson['title'],
      date : parsedJson['date'],
      area : parsedJson['area'],
      guides: parsedJson['guides']
    );
  }
}