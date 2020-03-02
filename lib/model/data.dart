class Datas {
  String name = '';
  String profile_pic = '';


  Datas.fromJson(dynamic json){
    name = json['login'];
    profile_pic = json['avatar_url'];
  }

}

