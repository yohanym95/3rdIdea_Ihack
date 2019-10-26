class User{
  //model class for fetch data from backend (node)
  final String msg;
  

  User({
    this.msg
  });

  factory User.fromJson(Map<String,dynamic> parsedJson ){
    return User(
      msg: parsedJson['msg'],
     
      );

  }



}