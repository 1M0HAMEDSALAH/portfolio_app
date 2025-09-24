import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const PortfolioApp());
  });
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohamed Salah Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0D47A1),
          secondary: Color(0xFF1976D2),
          surface: Color(0xFFF5F5F5),
        ),
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFF64B5F6),
          surface: Color(0xFF121212),
        ),
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PortfolioScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/Flutter Logo.json',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Mohamed Salah',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 400) {
        if (!_showFab) setState(() => _showFab = true);
      } else {
        if (_showFab) setState(() => _showFab = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Portfolio of Mohamed Salah',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Toggle theme mode - would need provider for state management
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: const Column(
          children: [
            HeroSection(),
            SizedBox(height: 60),
            AboutMeSection(),
            SizedBox(height: 60),
            ProjectsSection(),
            SizedBox(height: 60),
            SkillsSection(),
            SizedBox(height: 60),
            ExperienceSection(),
            SizedBox(height: 60),
            ContactSection(),
            SizedBox(height: 40),
            FooterSection(),
          ],
        ),
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.keyboard_arrow_up),
            )
          : null,
    );
  }
}

/// 🎯 Hero Section
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'profile',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/468773310_2026811581104469_8810425690671696538_n.jpg"),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Mohamed Salah",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "🚀 Flutter Developer",
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "📱 Mobile Apps Specialist",
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    "⚡ Node.js & Firebase Expert",
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
                pause: const Duration(milliseconds: 2000),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse("https://github.com/1M0HAMEDSALAH");
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(Icons.work),
                  label: const Text('View Projects'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                ),
                const SizedBox(width: 15),
                OutlinedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse(
                        "https://drive.google.com/file/d/13UIZXXb_QmfQF9wHmGbGb78WI98LBF2J/view");
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download CV'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 🧑 About Me Section
class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "About Me",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "Passionate Flutter Developer",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "I am Mohamed Salah, a dedicated Flutter Developer with extensive experience in building high-performance cross-platform mobile applications. I specialize in creating intuitive user interfaces and robust backend integrations using cutting-edge technologies.\n\nWith a strong foundation in Dart, Flutter, Firebase, and Node.js, I've successfully delivered real-world projects including the Mashariq App for health event management and the Hajj App for pilgrimage services. My expertise extends to state management solutions like BLoC and GetX, ensuring scalable and maintainable codebases.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildInfoChip(
                          Icons.location_on, "Zagazig, Egypt", context),
                      _buildInfoChip(
                          Icons.email, "Available for hire", context),
                      _buildInfoChip(
                          Icons.code, "2+ Years Experience", context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(text),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
  }
}

/// 📂 Enhanced Projects Section
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        "title": "Mashariq App",
        "desc":
            "A comprehensive health events management application built with Flutter and Firebase, featuring real-time updates, user authentication, and seamless event booking system.",
        "image": "assets/mashariq.png",
        "tech": ["Flutter", "Firebase", "BLoC", "REST API"],
        "status": "Live on Play Store",
        "codeLink": "https://github.com/1M0HAMEDSALAH/mashariq-app",
        "liveLink":
            "https://play.google.com/store/apps/details?id=sa.com.mashariq.app"
      },
      {
        "title": "Hajj Mashariq App",
        "desc":
            "An innovative mobile platform providing essential services for pilgrims, including navigation, prayer times, group coordination, and emergency assistance features.",
        "image": "assets/hajj.png",
        "tech": ["Flutter", "Firebase", "BLoC", "REST API"],
        "status": "Live on Play Store",
        "codeLink": "https://github.com/1M0HAMEDSALAH/hajj-app",
        "liveLink":
            "https://play.google.com/store/apps/details?id=sa.mashariq.hajj.app"
      },
      {
        "title": "Quran App",
        "desc": "Full-featured Quran application.",
        "image": "assets/quran.png",
        "tech": ["Flutter", "Firebase", "GetX"],
        "status": "Done",
        "codeLink": "https://github.com/1M0HAMEDSALAH/quran",
        "liveLink": ""
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Featured Projects",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            "Here are some of my recent works",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
          const SizedBox(height: 30),
          ...projects.map((project) => _buildProjectCard(project, context)),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showProjectDetails(project, context);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                      ),
                      child: Image.asset(
                        project["image"]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project["title"]!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              project["status"]!,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  project["desc"]!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (project["tech"] as List<String>)
                      .map((tech) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(project["codeLink"] ?? "");
                        if (project["codeLink"] != null &&
                            project["codeLink"]!.isNotEmpty) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.code, size: 16),
                      label: const Text('View Code'),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(project["liveLink"] ?? "");
                        if (project["liveLink"] != null &&
                            project["liveLink"]!.isNotEmpty) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.launch, size: 16),
                      label: const Text('Live Demo'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProjectDetails(Map<String, dynamic> project, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(project["title"]!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project["desc"]!),
            const SizedBox(height: 15),
            const Text("Technologies Used:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text((project["tech"] as List<String>).join(", ")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }
}

/// 💡 Enhanced Skills Section
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  final skills = {
    "Flutter & Dart": {
      "level": 0.95,
      "icon": Icons.flutter_dash,
      "color": Colors.blue
    },
    "Firebase": {"level": 0.9, "icon": Icons.cloud, "color": Colors.orange},
    "Node.js": {"level": 0.85, "icon": Icons.javascript, "color": Colors.green},
    "BLoC Pattern": {
      "level": 0.88,
      "icon": Icons.architecture,
      "color": Colors.purple
    },
    "REST APIs": {"level": 0.92, "icon": Icons.api, "color": Colors.red},
    "Git & GitHub": {
      "level": 0.9,
      "icon": Icons.code_outlined,
      "color": Colors.black
    },
  };

  @override
  void initState() {
    super.initState();
    _controllers = skills.keys
        .map((skill) => AnimationController(
              duration: const Duration(milliseconds: 1500),
              vsync: this,
            ))
        .toList();

    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            ))
        .toList();

    // Start animations with delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Technical Skills",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skill = skills.keys.elementAt(index);
              final skillData = skills[skill]!;
              return AnimatedBuilder(
                animation: _animations[index],
                builder: (context, child) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            skillData["icon"] as IconData,
                            size: 40,
                            color: skillData["color"] as Color,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            skill,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: (skillData["level"] as double) *
                                _animations[index].value,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(10),
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              skillData["color"] as Color,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${((skillData["level"] as double) * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: skillData["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 💼 Experience Section
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        "title": "Flutter Developer",
        "company": "Freelance / Projects",
        "period": "Sep 2024 - Present",
        "description":
            "Working on professional mobile applications using Flutter, Firebase, and Node.js. Focused on delivering high-quality apps with clean architecture (BLoC) and seamless user experiences.",
        "achievements": [
          "Developed and published 'Mashariq App' for health events management",
          "Built 'Hajj App' providing services for pilgrims",
          "Implemented state management with BLoC and GetX for scalable apps",
          "Integrated real-time APIs, authentication, and Firebase services"
        ]
      },
      {
        "title": "Computer Science Student",
        "company": "Zagazig University",
        "period": "2020 - 2024",
        "description":
            "Studied Computer Science with a focus on software engineering, algorithms, and mobile application development.",
        "achievements": [
          "Graduated with a degree in Computer Science",
          "Built multiple academic and personal Flutter projects",
          "Gained strong foundation in programming (Java, C++, Dart)",
          "Learned modern mobile development practices and state management"
        ]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Experience",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          ...experiences.map((exp) => _buildExperienceCard(exp, context)),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.work,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp["title"]!,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          exp["company"]!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          exp["period"]!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                exp["description"]!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Key Achievements:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...((exp["achievements"] as List<String>).map(
                (achievement) => Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(achievement)),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

/// 📬 Enhanced Contact Section
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Let's Work Together",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            "Have a project in mind? Let's discuss how we can bring your ideas to life!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactButton(
                context,
                icon: Icons.email,
                label: 'mohamedsalah.xv80@gmail.com',
                onTap: () {
                  // Open email
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'mohamedsalah.xv80@gmail.com',
                  );
                  launchUrl(emailLaunchUri);
                },
                color: Colors.red,
              ),
              _buildContactButton(
                context,
                icon: Icons.code,
                label: 'GitHub',
                onTap: () async {
                  final url = Uri.parse("https://github.com/1M0HAMEDSALAH");
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                color: Colors.black,
              ),
              _buildContactButton(
                context,
                icon: Icons.work,
                label: 'LinkedIn',
                onTap: () async {
                  final url = Uri.parse(
                      "https://www.linkedin.com/in/mohamed-salah-9804a2247/");
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                color: Colors.blue,
              ),
              _buildContactButton(
                context,
                icon: Icons.phone,
                label: 'Call --> +20 1093942943',
                onTap: () {
                  // Make call
                  launchUrl(Uri(scheme: 'tel', path: '+201093942943'));
                },
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _downloadCV();
              },
              icon: const Icon(Icons.download),
              label: const Text('Download CV'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadCV() async {
    final url = Uri.parse(
        "https://drive.google.com/file/d/13UIZXXb_QmfQF9wHmGbGb78WI98LBF2J/view");
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}

/// 🔗 Footer Section
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flutter_dash,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                'Built with Flutter',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            '© 2024 Mohamed Salah. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Designed & Developed with ❤️ in Zagazig, Egypt',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}
