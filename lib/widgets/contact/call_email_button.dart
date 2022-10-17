import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onestop_dev/functions/utility/phone_email.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';

enum ContactType { call, email }

class ContactButton extends StatelessWidget {
  final ContactType type;
  final String data;
  const ContactButton({Key? key, required this.type, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(data == '') return const SizedBox(width: 0,height: 0,);
    return TextButton(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        child: Container(
          height: 32,
          width: 100,
          color: kGrey9,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (type == ContactType.email)
                  ? const Icon(
                      Icons.email,
                      color: kWhite,
                    )
                  : const Icon(
                      Icons.call,
                      color: kWhite,
                    ),
              Container(
                width: 5,
              ),
              Text(
                (type == ContactType.email) ? 'Email' : 'Call',
                style: MyFonts.w500.setColor(kWhite).size(14),
              ),
            ],
          ),
        ),
      ),
      onPressed: () async {
        try {
          if (type == ContactType.email) {
            await launchEmailURL(data);
          } else {
            await launchPhoneURL(data);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
  }
}
