import 'package:flutter/material.dart';

class MyRegisterPlay2 extends StatelessWidget {
  const MyRegisterPlay2({super.key});

  @override
  Widget build(BuildContext context) {
    return GameTimelineScreenWithPopup();
  }
}

class GameTimelineScreenWithPopup extends StatefulWidget {
  const GameTimelineScreenWithPopup({super.key});

  @override
  _GameTimelineScreenWithPopupState createState() =>
      _GameTimelineScreenWithPopupState();
}

class _GameTimelineScreenWithPopupState
    extends State<GameTimelineScreenWithPopup> {
  // Variable to control the visibility of the "Choose Team" modal
  bool _showChooseTeamModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // Empty title as per the previous image's app bar
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Stack(
        children: [
          // Main content: Timeline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Timeline items
                    _buildTimelineItem(
                      time: '00 : 04 : 52',
                      title: '1st down Pass',
                      details: ['Receiver: #32 Bianca', 'Tackle / 6 yards'],
                    ),
                    _buildTimelineItem(
                      time: '00 : 05 : 28',
                      title: '2nd down Pass',
                      details: [
                        'QB: #1 Branca',
                        'Receiver: #25 Lisa',
                        'Tackle / 8 yards',
                      ],
                    ),
                    _buildTimelineItem(
                      time: '', // No time for FIRST DOWN in this section
                      title: 'FIRST DOWN',
                      isSpecial: true,
                    ),
                    _buildTimelineItem(
                      time: '', // No time for FIRST DOWN in this section
                      title: '3rd down Pass',
                      details: [
                        'QB: #1 Branca',
                        'Receiver: #63 Clara',
                        'Tackle / 12 yards',
                      ],
                    ),
                    // Add more timeline items if needed to fill the screen
                    SizedBox(
                      height: 150,
                    ), // Space for floating action buttons and modal
                  ]),
                ),
              ],
            ),
          ),

          // Dotted timeline line (positioned in the center)
          Positioned(
            left:
                MediaQuery.of(context).size.width / 2 - 0.5, // Center the line
            top: 0,
            bottom: 0,
            child: CustomPaint(
              painter: DottedLinePainter(),
              child: Container(),
            ),
          ),

          // Floating action buttons (up arrow and shuffle/random icon)
          Positioned(
            bottom: _showChooseTeamModal
                ? 220
                : 20, // Adjust position if modal is open
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'up_arrow_btn',
                  onPressed: () {
                    // Handle scroll up
                  },
                  mini: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  child: Icon(Icons.keyboard_arrow_up),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'shuffle_btn',
                  onPressed: () {
                    setState(() {
                      _showChooseTeamModal =
                          !_showChooseTeamModal; // Toggle modal visibility
                    });
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: Icon(
                    Icons.shuffle,
                  ), // Represents the shuffle/random icon
                ),
              ],
            ),
          ),

          // "Choose team" modal (positioned at the bottom)
          if (_showChooseTeamModal)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildChooseTeamModal(),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    List<String>? details,
    bool isSpecial = false, // For "FIRST DOWN"
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
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
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
                  : Colors.white, // Lighter blue for FIRST DOWN
              elevation: 0, // No shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSpecial
                      ? Colors.blue
                      : Colors.grey.shade300, // Blue border for FIRST DOWN
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSpecial ? Colors.blue : Colors.black87,
                      ),
                    ),
                    if (details != null) ...[
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: details
                            .map(
                              (detail) => Text(
                                detail,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                            .toList(),
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

  Widget _buildChooseTeamModal() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose team',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _showChooseTeamModal = false;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle OFFENSE selection
                    setState(() {
                      _showChooseTeamModal = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('OFFENSE'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle DEFENSE selection
                    setState(() {
                      _showChooseTeamModal = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('DEFENSE'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Reusing the DottedLinePainter from the previous example
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
