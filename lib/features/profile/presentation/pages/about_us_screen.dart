import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Our App",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome to our student-centric app designed to make your academic life easier and more organized. Our app offers a range of features to help you stay on top of your studies and engage with the community.",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 24),
              _buildFeatureSection(
                context,
                icon: Icons.schedule,
                title: "View Class Timetable",
                description:
                    "Easily view your class timetable and keep track of your schedule. Never miss a class again!",
              ),
              const SizedBox(height: 16),
              _buildFeatureSection(
                context,
                icon: Icons.assignment,
                title: "Get Assignments",
                description:
                    "Access all your assignments in one place. Stay updated on upcoming due dates and submit your work on time.",
              ),
              const SizedBox(height: 16),
              _buildFeatureSection(
                context,
                icon: Icons.note_add,
                title: "Share and Download Notes",
                description:
                    "Share your notes with classmates and download notes shared by others. Collaborate and learn together.",
              ),
              const SizedBox(height: 16),
              _buildFeatureSection(
                context,
                icon: Icons.chat,
                title: "Community Chats",
                description:
                    "Engage in community chats with your peers. Discuss topics, ask questions, and share knowledge.",
              ),
              const SizedBox(height: 16),
              _buildFeatureSection(
                context,
                icon: Icons.forum,
                title: "Discussion on Topics",
                description:
                    "Participate in discussions on various topics. Share your insights and learn from others.",
              ),
              const SizedBox(height: 16),
              _buildFeatureSection(
                context,
                icon: Icons.assessment,
                title: "View Results and Assessments",
                description:
                    "View your results, course details, internal assessments, and marks directly from UUCMS. Stay informed about your academic progress.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureSection(BuildContext context,
      {required IconData icon,
      required String title,
      required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.white70,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
