class UserList {
   int? id;
   String? userName;
   String? url;
   String? mobileNumber;


  UserList(
      {this.id,
      this.mobileNumber,
      this.userName,
      this.url,
      });

  Map<String, dynamic> toStore() {
    var map = <String, dynamic>{
      'id': id,
      'userName': userName,
      'url': url,
      'mobileNumber': mobileNumber,

    };

    return map;
  }

  UserList.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userName = map['userName'];
    url = map['url'];
    mobileNumber = map['mobileNumber'];

  }
}
