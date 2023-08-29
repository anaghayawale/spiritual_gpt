import 'package:flutter/material.dart';

class GetStartedWidget extends StatelessWidget {
  const GetStartedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<IconData, String> listTileData = {
      Icons.integration_instructions: 'Introduction',
      Icons.privacy_tip_rounded: 'Privacy Policy',
      Icons.contact_page_rounded: 'Contact Us',
      Icons.code: 'About Developer'
    };

    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          IconData icon = listTileData.keys.elementAt(index);
          String title = listTileData.values.elementAt(index);
          return ListTile(
            leading: Icon(icon),
            title: Text(title),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(title),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('This is a demo dialog.'),
                          Text('I am too lazy information right now.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Got it!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        });
  }
}
