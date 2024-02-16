class User {
 int id ;
 String? name ;
 String? email ;

 User({
  required this.name,  required this.email, required this.id,
 });

 // 將User對象轉換成 Map
 Map<String, dynamic> toMap() {
  return {
   'id': id,
   'name': name,
   'email': email,
  };
 }
}