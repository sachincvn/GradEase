import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/extensions/string_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';

class NoteCard extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback? onTapCallback;
  final VoidCallback? onRemoveNoteCallBack;

  const NoteCard({
    Key? key,
    required this.note,
    this.onTapCallback,
    this.onRemoveNoteCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 14, right: 14, bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF313a4d),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorPallete.transparentColor,
                  minRadius: 28,
                  child: Image.network(
                    note.uploadedBy.profileImage ?? StringConstants.avtarImage,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: note.uploadedBy.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                          children: [
                            const TextSpan(text: " - "),
                            TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontWeight: FontWeight.w300),
                              text: note.uploadedBy.email,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "uploaded on - ${note.createdDate.formatDateTime('yyyy-MM-dd hh:mm a')}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onRemoveNoteCallBack,
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              note.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              note.description ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPallete.whiteColor,
                    width: .5,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      Uri.parse(note.filepath).pathSegments.last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.cloud_download),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
