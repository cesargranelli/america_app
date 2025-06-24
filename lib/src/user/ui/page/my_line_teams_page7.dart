import 'package:flutter/material.dart';

class MyLineTeamsPage7 extends StatelessWidget {
  const MyLineTeamsPage7({super.key});

  @override
  Widget build(BuildContext context) {
    return GameTimelineScreen();
  }
}

class GameTimelineScreen extends StatefulWidget {
  const GameTimelineScreen({super.key});

  @override
  _GameTimelineScreenState createState() => _GameTimelineScreenState();
}

class _GameTimelineScreenState extends State<GameTimelineScreen> {
  // You might manage the active tab state here, e.g., using a Provider or BLoC
  // For simplicity, we'll just display the Timeline tab.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // Empty title as per the image
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab('Timeline', isSelected: true),
                  _buildTab('Estatísticas', isSelected: false),
                ],
              ),
              const SizedBox(height: 8), // Small space below tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Ataque',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Defesa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // Small space below Attack/Defense
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Timeline dotted line
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 1, // Center the line
            top: 0,
            bottom: 0,
            child: CustomPaint(
              painter: DottedLinePainter(),
              child: Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                _buildTimelineItem(
                  time: '',
                  title: 'Início do 1° tempo',
                  isFirst:
                      true, // Mark as first item for potentially different styling
                ),
                _buildTimelineItem(
                  time: '17 : 37 : 55',
                  title: '1ª descida / pass',
                  subtitle: 'Resultado: reception',
                ),
                _buildTimelineItem(
                  time: '17 : 39 : 00',
                  title: '2ª descida / run',
                  subtitle: 'Resultado: reception',
                ),
                _buildTimelineItem(
                  time: '',
                  title: 'FIRST DOWN',
                  isSpecial: true, // Mark as special for different styling
                ),
                // Add more timeline items as needed
                SizedBox(height: 100), // Space for buttons at the bottom
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle "ENCERRAR 1° TEMPO" action
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.white, // White background
                  foregroundColor: Colors.blue, // Blue text
                  side: BorderSide(color: Colors.blue), // Blue border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'ENCERRAR 1° TEMPO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle "CONTINUAR 1° TEMPO" action
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue, // Blue background
                  foregroundColor: Colors.white, // White text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'CONTINUAR 1° TEMPO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, {required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 50, // Adjust width as needed
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    String? subtitle,
    bool isFirst = false,
    bool isSpecial = false,
  }) {
    return Container(
      margin: EdgeInsets.only(top: isFirst ? 20 : 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width / 2 -
                30, // Adjust width to align text
            alignment: Alignment.centerRight,
            child: Text(
              time,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ), // Adjust vertical position for dot
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Card(
              color: isSpecial
                  ? Colors.blue[50]
                  : Colors
                        .grey[50], // Lighter blue for FIRST DOWN, light grey for others
              elevation: 0, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSpecial
                      ? Colors.blue
                      : Colors
                            .grey
                            .shade300, // Blue border for FIRST DOWN, light grey for others
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSpecial ? Colors.blue : Colors.black87,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
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

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors
          .grey
          .shade400 // Dotted line color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    const double dashHeight = 5;
    const double dashSpace = 5;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
