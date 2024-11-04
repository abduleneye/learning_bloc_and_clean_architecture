/*

//This a follow/unfollow button.

--------------------------------------------------------------------------------

To use this widget, you need

- a function(e.g. toggleFollow()),
- isFollowing(e.g false -> then we will show the follow button instead of unfollow button)
   
 */

import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isFollowing;

  const FollowButton({
    super.key,
    required this.onPressed,
    required this.isFollowing,
  });

  //BUILD UI

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding on the outside
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      // button
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
          onPressed: onPressed,
          // color
          color:
              isFollowing ? Theme.of(context).colorScheme.primary : Colors.blue,
          // text
          child: Text(isFollowing ? 'Unfollow' : 'Follow'),
        ),
      ),
    );
  }
}
