import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_flutter/config/app_assets.dart';
import 'package:laundry_flutter/config/app_colors.dart';
import 'package:laundry_flutter/config/app_session.dart';
import 'package:laundry_flutter/config/nav.dart';
import 'package:laundry_flutter/models/user_model.dart';
import 'package:laundry_flutter/pages/auth/login_page.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'Are you sure want to logout?',
      textNo: 'Cancel',
    ).then((yes) {
      if (yes ?? false) {
        AppSession.removeUser();
        AppSession.removeBearerToken();
        Nav.replace(context, const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSession.getUser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return DView.loadingCircle();
        UserModel user = snapshot.data!;
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
                child: Text(
                  'Account',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 70,
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            AppAssets.profile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    DView.spaceWidth(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DView.spaceHeight(4),
                          Text(
                            user.username,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          DView.spaceHeight(12),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DView.spaceHeight(4),
                          Text(
                            user.email,
                            //'asdasd asd asd asdasdasdasd adasda dasd asd asd asd asd asdasd',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              DView.spaceHeight(10),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.image),
                title: const Text('Change Profile'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.edit),
                title: const Text('Edit Account'),
                trailing: const Icon(Icons.navigate_next),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: OutlinedButton(
                  onPressed: () => logout(context),
                  child: const Text('Logout'),
                ),
              ),
              DView.spaceHeight(30),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: AppColors.primary,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.translate),
                title: const Text('Language'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.notifications),
                title: const Text('Notification'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.feedback),
                title: const Text('Feedback'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {},
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.support_agent),
                title: const Text('Support'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: const Icon(
                      Icons.local_laundry_service,
                      size: 50,
                      color: AppColors.primary,
                    ),
                    applicationName: 'Laundry',
                    applicationVersion: 'v0.0.1',
                    children: [
                      const Text('Laundry market app to monitor your laundry'),
                    ],
                  );
                },
                dense: true,
                horizontalTitleGap: 0,
                leading: const Icon(Icons.info),
                title: const Text('About'),
                trailing: const Icon(Icons.navigate_next),
              ),
              DView.spaceHeight(100),
            ],
          ),
        );
      },
    );
  }
}
