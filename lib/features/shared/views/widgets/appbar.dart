import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appColors.background,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(
          hPadding,
          0,
          hPadding,
          vPadding,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Hi there 👋🏾',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              XBox(10),
              Spacer(),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2019/02/11/20/20/woman-3990680_1280.jpg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.onLeadingTapped,
    this.hasLeading = true,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTapped;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasLeading ? leading : const SizedBox.shrink(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: hPadding,
          ),
          child: Row(
            children: [
              ...?actions,
            ],
          ),
        ),
      ],
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
