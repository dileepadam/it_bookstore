import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePageListItem extends StatefulWidget {
  final String? url;
  final String? author;
  final String? title;
  final bool? isFavorite;
  final void Function(bool)? onTapFavorite;
  final VoidCallback? onTapItem;

  const HomePageListItem({
    super.key,
    this.url,
    this.author,
    this.title,
    this.onTapFavorite,
    this.onTapItem,
    this.isFavorite,
  });

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTapItem != null) {
          widget.onTapItem!();
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 50.w,
                height: 60.h,
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
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator(
                          color: Colors.lightBlueAccent),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.warning_rounded),
                ),
              ),
              title: Text(widget.title ?? "N/A"),
              subtitle: Text(widget.author ?? "N/A"),
              trailing: IconButton(
                icon: Icon(widget.isFavorite!
                    ? Icons.favorite_outlined
                    : Icons.favorite_border_outlined),
                onPressed: () {
                  if (widget.onTapFavorite != null) {
                    widget.onTapFavorite!(!widget.isFavorite!);
                  }
                  setState(() {});
                },
              ),
            ),
            const Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
