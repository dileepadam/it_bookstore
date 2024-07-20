import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/appValidator.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onTapFavourite;
  final String hintText;
  final void Function(String)? onChange;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const MainAppBar(
      {super.key,
      this.onTapFavourite,
      required this.hintText,
      this.onChange,
      this.textEditingController,
      this.focusNode});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  FocusNode? _focusNode;
  bool _hasFocus = false;

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _hasFocus = _focusNode!.hasFocus;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _focusNode = widget.focusNode ?? FocusNode();
    });
    _focusNode!.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        contextMenuBuilder: (context, editableTextState) {
          return SizedBox.shrink();
        },
        controller: widget.textEditingController,
        onChanged: widget.onChange!,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp(Validator().emojiRegexp),
          ),
        ],
        textAlign: TextAlign.left,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            if (widget.onTapFavourite != null) {
              widget.onTapFavourite!();
            }
          },
        ),
      ],
    );
  }
}
