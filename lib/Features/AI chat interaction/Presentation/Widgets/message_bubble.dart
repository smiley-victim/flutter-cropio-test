import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../Core/Constants/appconstants.dart';



//// message widgets

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.text,
    this.image,
    required this.isFromUser,
    required this.recevierImg,
  });

  final String? text;
  final bool isFromUser;
  final String recevierImg;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isFromUser ? 20 : 0, right: isFromUser ? 0 : 20),
      child: Row(
        mainAxisAlignment:
            isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          s10,
          Offstage(
            offstage: isFromUser,
            child: const CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                'https://picsum.photos/200/300',
              ),
            ),
          ),
          s10,
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              decoration: BoxDecoration(
                color: isFromUser
                    ? const Color.fromARGB(255, 207, 197, 253).withOpacity(0.7)
                    : const Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Column(children: [
                    if (text case final text?) MarkdownBody(data: text),
                    if (image case final image?) image,
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration textFieldDecoration(BuildContext context, String hintText) =>
    InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
