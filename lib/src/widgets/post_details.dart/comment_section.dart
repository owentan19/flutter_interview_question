import 'dart:math';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/modals/comment.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({
    Key? key,
    required this.comments,
  }) : super(key: key);

  final List<Comment> comments;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      initiallyExpanded: false,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      title: Text(
        _isExpanded
            ? 'Hide ${widget.comments.length} Comments'
            : 'View All ${widget.comments.length} Comments',
        style: const TextStyle(color: Vx.gray400),
      ),
      children: [
        ...widget.comments.map((comment) => _buildComment(comment)),
      ],
    ).pOnly(top: 10);
  }

  Widget _buildComment(Comment comment) {
    return VStack(
      [
        HStack(
          [
            _userProfileImage(comment.name),
            8.widthBox,
            VStack(
              [
                comment.name.text.bold.maxLines(1).make(),
                5.heightBox,
                comment.email.text.gray500.semiBold.caption(context).make(),
              ],
            ).expand(),
          ],
          crossAlignment: CrossAxisAlignment.start,
        ),
        4.heightBox,
        comment.body.text.caption(context).make(),
        const Divider()
      ],
    ).py(8);
  }

  Widget _userProfileImage(String userName) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: _getRandomColor(),
      child: Text(
        userName.split(' ').first,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Color _getRandomColor() {
    Random random = Random();
    // Generate a random color using the RGB format
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}
