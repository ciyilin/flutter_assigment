class User {
 int? id ;
 String? name ;
 String? email ;

 User({
  required this.name,  required this.email,  this.id,
 });

 // 將User對象轉換成 Map
 Map<String, dynamic> toMap() {
   return {
     'id': id,
     'name': name,
     'email': email,
   };
  }
  factory User.fromMap(){

  }

  User copyWith({
   int? id,
   String? name,
   String? email,
  }){
  return User(
      name: name?? this.name,
      email:email?? this.email,
      id: id?? this.id,
  );
 }
}
