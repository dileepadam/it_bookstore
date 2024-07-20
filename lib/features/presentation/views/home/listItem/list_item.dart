import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePageListItem extends StatefulWidget {
  final String? url;
  final String? author;
  final String? title;
  final void Function(bool)? onTapFavorite;
  final VoidCallback? onTapItem;

  const HomePageListItem(
      {super.key,
      this.url,
      this.author,
      this.title,
      this.onTapFavorite,
      this.onTapItem});

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTapItem != null) {
          widget.onTapItem!();
        }
      },
      child: ListTile(
        leading: Container(
          width: 50,
          height: 60,
          color: Colors.grey[300],
          child: CachedNetworkImage(
            imageUrl: widget.url ?? "",
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.warning_rounded),
          ),
        ),
        title: Text(widget.title ?? "N/A"),
        subtitle: Text(widget.author ?? "N/A"),
        trailing: IconButton(
          icon: Icon(_isFavorite
              ? Icons.favorite_outlined
              : Icons.favorite_border_outlined),
          onPressed: () {
            _isFavorite = !_isFavorite;
            if (widget.onTapFavorite != null) {
              widget.onTapFavorite!(_isFavorite);
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
