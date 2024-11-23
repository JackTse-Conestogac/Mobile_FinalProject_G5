import 'package:flutter/material.dart';
import '../entities/User.dart';

//When the entities are ready I will modify this to take an entity as a constructor parameter
class ContactTile extends StatelessWidget {
  ContactTile(this.user);

  User user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement ContactTile
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.occupation),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("TEMP"),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  debugPrint("Delete ${user.name}");
                },
              )
            ],
          )
        ],
      ),
      trailing: FilledButton(
        onPressed: () {
          debugPrint("Email ${user.email}");
        },
        child: Text("Email"),
      ),
    );
  }
}
