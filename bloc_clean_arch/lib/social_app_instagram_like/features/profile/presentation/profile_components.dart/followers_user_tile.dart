import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FollowersUserTile extends StatelessWidget {
  final ProfileUser user;
  const FollowersUserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(
        user.email,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
      leading: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfilePage(uid: user.uid))),
    );
  }
}
