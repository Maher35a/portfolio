import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart'; // لازم تضيف دي في pubspec.yaml

class PortfolioPage extends StatelessWidget {
  final List<Project> projects = [
    Project(
      title: 'AbuDhiab Car Rental App',
      description:
      'A Flutter-based car rental app available on both App Store and Google Play.',
      links: {
        'App Store':
        'https://apps.apple.com/ae/app/%D8%A3%D8%A8%D9%88%D8%B0%D9%8A%D8%A7%D8%A8-%D9%84%D8%AA%D8%A3%D8%AC%D9%8A%D8%B1-%D8%A7%D9%84%D8%B3%D9%8A%D8%A7%D8%B1%D8%A7%D8%AA/id1570665182?l=',
        'Google Play':
        'https://play.google.com/store/apps/details?id=com.app.abudhiabcarrental',
      },
    ),
    Project(
      title: 'GitHub Portfolio',
      description: 'My GitHub profile with all my projects and contributions.',
      links: {'GitHub': 'https://github.com/Maher35a'},
    ),
  ];

  final String phoneNumber = '01099625565'; // رقمك هنا

  Future<void> _launchWhatsApp(String phone) async {
    final url = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Ahmed Maher Portfolio'),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25.w,
              backgroundImage: const AssetImage('assets/formal.jpg'),
            ),
            SizedBox(height: 10.h),
            Text(
              'Ahmed Maher',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 9.sp, color: Colors.grey[800]),
            ),
            SizedBox(height: 12.h),
            _sectionTitle('About Me'),
            Text(
              'I’m Ahmed Maher, a passionate Flutter developer with hands-on experience in building cross-platform mobile applications. I enjoy turning complex ideas into elegant and functional apps using Flutter, Dart, and BLoC for scalable architecture. I’m always exploring how to integrate AI and APIs for smarter user experiences.',
              style:
              TextStyle(fontSize: 6.sp, height: 1.4, color: Colors.grey[900]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            _sectionTitle('Contact'),
            Text(
              'Phone: $phoneNumber',
              style: TextStyle(fontSize: 9.sp, color: Colors.blue[800]),
            ),
            SizedBox(height: 6.h),
            ElevatedButton.icon(
              onPressed: () => _launchWhatsApp(phoneNumber),
              icon: const Icon(Icons.chat, color: Colors.white),
              label: const Text('Contact on WhatsApp'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                textStyle: TextStyle(fontSize: 9.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            _sectionTitle('Projects'),
            Column(
              children: projects
                  .map((project) => ProjectCard(project: project))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        SizedBox(height: 3.h),
        Container(width: 40.w, height: 1.h, color: Colors.blue[700]),
        SizedBox(height: 6.h),
      ],
    );
  }
}

class Project {
  final String title;
  final String description;
  final Map<String, String> links;

  Project({
    required this.title,
    required this.description,
    required this.links,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  void _launchURL(BuildContext context, String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('URL to open: $url')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              project.description,
              style: TextStyle(fontSize: 8.sp, height: 1.3),
            ),
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              children: project.links.entries.map((entry) {
                return TextButton.icon(
                  onPressed: () => _launchURL(context, entry.value),
                  icon: Icon(Icons.link, size: 9.sp, color: Colors.blue),
                  label: Text(
                    entry.key,
                    style: TextStyle(fontSize: 8.sp, color: Colors.blue),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
