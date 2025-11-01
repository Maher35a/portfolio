import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioWebApp());
}

class PortfolioWebApp extends StatelessWidget {
  const PortfolioWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B0B), // أسود داكن
        primaryColor: const Color(0xFF0A7A5A),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.grey[200],
          displayColor: Colors.grey[200],
        ),
      ),
      home: const PortfolioWeb(),
    );
  }
}

class PortfolioWeb extends StatefulWidget {
  const PortfolioWeb({Key? key}) : super(key: key);

  @override
  State<PortfolioWeb> createState() => _PortfolioWebState();
}

class _PortfolioWebState extends State<PortfolioWeb> {
  // index of the currently active section
  int _selectedIndex = 0;

  // section titles and placeholders (سنستبدل المحتوى لاحقًا)
  final List<String> _titles = ['Home', 'About', 'Services', 'Projects', 'Contact'];

  // بسيط لوضع محتوى أقسام مؤقت
  Widget _sectionWidget(int index) {
    switch (index) {
      case 0:
        return _homeSection();
      case 1:
        return _aboutSection();
      case 2:
        return _servicesSection();
      case 3:
        return _projectsSection();
      case 4:
        return _contactSection();
      default:
        return const SizedBox.shrink();
    }
  }

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Sidebar width ثابتة على الشاشات الكبيرة
  static const double _sidebarWidth = 320;

  @override
  Widget build(BuildContext context) {
    final bool isLarge = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      // لو شاشة صغيرة، نظهر AppBar مع زر لفتح Drawer
      appBar: isLarge
          ? null
          : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () => _onSelect(0),
          ),
        ],
      ),
      drawer: isLarge
          ? null
          : Drawer(
        child: SafeArea(
          child: _SidebarContent(
            selectedIndex: _selectedIndex,
            onSelect: (i) {
              Navigator.of(context).pop();
              _onSelect(i);
            },
          ),
        ),
      ),
      body: Row(
        children: [
          // Sidebar (ثابت على الشاشات الكبيرة)
          if (isLarge)
            SizedBox(
              width: _sidebarWidth,
              child: SafeArea(
                child: _SidebarContent(
                  selectedIndex: _selectedIndex,
                  onSelect: _onSelect,
                ),
              ),
            ),

          // المحتوى الرئيسي - يتمدد ليملأ المساحة المتبقية
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey<int>(_selectedIndex),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                color: const Color(0xFF0B0B0B),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // عنوان القسم في الأعلى (يمكن إخفاؤه لاحقاً)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        _titles[_selectedIndex],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // محتوى القسم نفسه
                    Expanded(
                      child: SingleChildScrollView(
                        child: _sectionWidget(_selectedIndex),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// محتوى الـ Sidebar منفصل لاستعماله في Drawer أو كحاوية ثابتة
class _SidebarContent extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _SidebarContent({
    Key? key,
    required this.selectedIndex,
    required this.onSelect,
  }) : super(key: key);

  // أزرار التنقل بالـ Sidebar
  @override
  Widget build(BuildContext context) {
    // ألوان التصميم
    const Color accentGreen = Color(0xFF1FB57A); // أخضر داكن فاتح شوية
    const Color panel = Color(0xFF0F1112); // لون خلفية اللوحة الجانبية

    return Container(
      color: panel,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: Column(
        children: [
          // الصورة والاسم
          Column(
            children: [
              // صورة شخصية (استبدل المسار assets/profile.jpg)
              CircleAvatar(
                radius: 56,
                backgroundImage: const AssetImage('assets/profile.jpg'),
                backgroundColor: Colors.black26,
              ),
              const SizedBox(height: 14),
              const Text(
                'Ahmed Maher', // استبدل باسمك
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'Flutter Developer',
                style: TextStyle(fontSize: 13, color: Colors.grey[400]),
              ),
              const SizedBox(height: 14),
              // أيقونات سوشيال (تستدعى لاحقًا روابط فعلية)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'GitHub',
                    icon: const Icon(Icons.code),
                    color: Colors.grey[300],
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'LinkedIn',
                    icon: const Icon(Icons.work_outline),
                    color: Colors.grey[300],
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'Behance',
                    icon: const Icon(Icons.palette_outlined),
                    color: Colors.grey[300],
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // فاصل
          Container(height: 1, color: Colors.grey[900]),
          const SizedBox(height: 12),

          // قائمة التنقل
          _SidebarButton(
            label: 'Home',
            icon: Icons.home_outlined,
            isActive: selectedIndex == 0,
            accent: accentGreen,
            onTap: () => onSelect(0),
          ),
          _SidebarButton(
            label: 'About',
            icon: Icons.person_outline,
            isActive: selectedIndex == 1,
            accent: accentGreen,
            onTap: () => onSelect(1),
          ),
          _SidebarButton(
            label: 'Services',
            icon: Icons.design_services_outlined,
            isActive: selectedIndex == 2,
            accent: accentGreen,
            onTap: () => onSelect(2),
          ),
          _SidebarButton(
            label: 'Projects',
            icon: Icons.collections_outlined,
            isActive: selectedIndex == 3,
            accent: accentGreen,
            onTap: () => onSelect(3),
          ),
          _SidebarButton(
            label: 'Contact',
            icon: Icons.mail_outline,
            isActive: selectedIndex == 4,
            accent: accentGreen,
            onTap: () => onSelect(4),
          ),

          // spacer to push version / copyright to bottom
          const Spacer(),

          // ملاحظة أو رابط تحميل السيرة (مثال)
          Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_outlined),
                label: const Text('Download CV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentGreen,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '© ${DateTime.now().year} YourName',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// زر Sidebar مُصمم (مع تمييز للزر النشط)
class _SidebarButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final Color accent;
  final VoidCallback onTap;

  const _SidebarButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.accent,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // إذا كان الزر نشط، نظهر خلفية خفيفة وخط بلون accent
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? accent.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? accent : Colors.grey[400]),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isActive ? accent : Colors.grey[300],
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ----- أقسام المحتوى (مؤقتة، هنضيف التفاصيل خطوة بخطوة لاحقًا) -----

Widget _homeSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // عرض جانبي "بطاقة" كبيرة مثل الصورة اليسارية في المثال
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بطاقة الصورة (تأخذ ثلث العرض تقريبًا)
          Flexible(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(right: 24, bottom: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1112),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 86,
                    backgroundImage: AssetImage('assets/formal.jpg'),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Jose Niko',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text('Flutter Developer', style: TextStyle(color: Colors.grey[400])),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.facebook, size: 18),
                      SizedBox(width: 12),
                      Icon(Icons.language, size: 18),
                      SizedBox(width: 12),
                      Icon(Icons.linked_camera, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About me',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Prolific, full stack web developer with a passion for metrics and building world class applications. '
                      'This is placeholder text to emulate the layout. We will replace this text with your real bio later.',
                  style: TextStyle(color: Colors.grey[300], height: 1.4),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    4,
                        (i) => Container(
                      width: 220,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101214),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Service ${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('Short description of the service goes here.', style: TextStyle(color: Colors.grey[400])),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _aboutSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'About',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),
      Text(
        'Detailed about me content will go here. Replace with your real biography, achievements, and highlights.',
        style: TextStyle(color: Colors.grey[300], height: 1.5),
      ),
      const SizedBox(height: 18),
      // إضافة عناصر أخرى لاحقًا
    ],
  );
}

Widget _servicesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: List.generate(
          6,
              (i) => Container(
            width: 260,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: const Color(0xFF101214), borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Service ${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('Short explanation of the service.', style: TextStyle(color: Colors.grey[400])),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _projectsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 14,
        runSpacing: 14,
        children: List.generate(
          4,
              (i) => Container(
            width: 360,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFF0F1112),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text('Project ${i + 1}', style: const TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _contactSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Text('Email: your.email@example.com', style: TextStyle(color: Colors.grey[300])),
      const SizedBox(height: 8),
      Text('Phone: +20 10 0996 25565', style: TextStyle(color: Colors.grey[300])),
      const SizedBox(height: 18),
      ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send),
        label: const Text('Send a message'),
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1FB57A), foregroundColor: Colors.black),
      ),
    ],
  );
}
