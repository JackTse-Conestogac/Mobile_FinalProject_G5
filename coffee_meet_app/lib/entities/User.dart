import 'Event.dart';

class User{
  int id;
  String name;
  String password;
  String email;
  int phone;
  String occupation;
  String? facebookUrl;
  String? linkedInUrl;
  bool showSocialMedia;
  bool isAvailable;
  List<Event> attendEvents = [];
  List<User> contacts = [];

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.occupation,
    this.facebookUrl,
    this.linkedInUrl,
    this.showSocialMedia = true,
    this.isAvailable = false,
    this.attendEvents = const [],
    this.contacts = const [],
  });

  // toJSON method - convert a Product object into JSON
  Map<String,dynamic> toJSON(){
    return {"id":this.id,
      "name":this.name,
      "password":this.password,
      "email":this.email,
      "phone":this.phone,
      "occupation":this.occupation,
      "facebookUrl":this.facebookUrl,
      "linkedInUrl":this.linkedInUrl,
      "addendEvents":this.attendEvents,
      "contacts": this.contacts,
    };
  }
  // fromJSON method - convert JSON into a Product object
  User.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        password = json["password"],
        email = json["email"],
        phone = json["phone"],
        occupation = json["occupation"],
        facebookUrl = json["facebookUrl"],
        linkedInUrl = json["linkedInUrl"],
        showSocialMedia = json["showSocialMedia"],
        isAvailable = json ["isAvailable"],
        attendEvents = (json["attendEvents"] as List<dynamic>)
            .map((e) => Event.fromJSON(e))
            .toList(),
        contacts = (json["contacts"] as List<dynamic>)
            .map((c) => User.fromJSON(c))
            .toList();

}

