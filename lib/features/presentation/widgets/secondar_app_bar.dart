import 'package:flutter/material.dart';

class SecondaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onTapFavourite;

  const SecondaryAppBar({super.key, this.title, this.onTapFavourite});

  @override
  State<SecondaryAppBar> createState() => _SecondaryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SecondaryAppBarState extends State<SecondaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Center(child: Text(widget.title ?? "")),
      actions: [
        widget.onTapFavourite != null
            ? IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: widget.onTapFavourite,
              )
            : IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.transparent,
                ),
                onPressed: () {},
              )
      ],
    );
  }
}
