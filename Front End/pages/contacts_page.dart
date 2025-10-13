import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_Cards.dart';

import '../models/CustomInfo.dart';

import '../services/auth_services.dart';

class ContactsPage extends StatefulWidget {
const ContactsPage({ Key? key }) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  late Future<List<ContactInfo>> futureContacts;

  @override
  void initState() {
    super.initState();
    futureContacts = ContactService.getAllContacts();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<ContactInfo>>(
      
      future: futureContacts,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No contacts available'));
        }

        final contacts = snapshot.data!;

        return SingleChildScrollView(

          child: Padding(

            padding: const EdgeInsets.all(17.0),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text("You can reach us via", style: AppTextStyles.welcomeTitle),

                AppHeight(20.0),

                Wrap(
                
                  spacing: 10.0,
                  runSpacing: 20.0,
                  alignment: WrapAlignment.center,
                  children: List.generate(contacts.length, (index) {
                
                    final info = contacts[index];
                
                    final int rowIndex = index ~/ 2;
                    final bool isRowEven = rowIndex % 2 == 0;
                    final bool isLeftCard = index % 2 == 0;

                    final bool useOrange =
                        (isRowEven && isLeftCard) || (!isRowEven && !isLeftCard);

                    final cardColor = useOrange
                        ? const Color(0xFF0C092B)
                        : const Color(0xFFAA331B);

                    final titleColor = useOrange
                        ? const Color(0xFFAA331B)
                        : const Color(0xFF0C092B);

                    final bool alignRight = index % 2 != 0;  
                
                    return CustomCards(
                
                      info: ContactInfo(
                
                        title: info.title,
                        hotline: info.hotline,
                        landline: info.landline,
                        mobile: info.mobile,
                        imagePath: "assets/images/Logo.png",
                        cardColor: cardColor,
                        titleColor: titleColor,
                        alignRight: alignRight,
                      ),
                
                    );
                
                  }),
                
                ),
              ],
            ),

          ),

        );

      },

    );

  }

}