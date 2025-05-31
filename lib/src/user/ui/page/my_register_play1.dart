import 'package:flutter/material.dart';

class MyRegisterPlay1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GamePlayForm();
  }
}

class GamePlayForm extends StatefulWidget {
  @override
  _GamePlayFormState createState() => _GamePlayFormState();
}

class _GamePlayFormState extends State<GamePlayForm> {
  String? _attempt;
  String? _down;
  String? _playType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''), // No title in the image
        backgroundColor: Colors.white,
        elevation: 0.5, // Subtle shadow
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Qual é a tentativa?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildSelectableButton(
                    text: '1ST',
                    isSelected: _attempt == '1ST',
                    onPressed: () {
                      setState(() {
                        _attempt = '1ST';
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildSelectableButton(
                    text: 'TD',
                    isSelected: _attempt == 'TD',
                    onPressed: () {
                      setState(() {
                        _attempt = 'TD';
                      });
                    },
                    backgroundColor: Colors.grey.shade300,
                    textColor: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Handle skip question
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                label: Text(
                  'PULAR PERGUNTA',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Qual é a descida?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: <Widget>[
                _buildSelectableButton(
                  text: '1ª',
                  isSelected: _down == '1ª',
                  onPressed: () {
                    setState(() {
                      _down = '1ª';
                    });
                  },
                  minWidth: 80,
                ),
                _buildSelectableButton(
                  text: '2ª',
                  isSelected: _down == '2ª',
                  onPressed: () {
                    setState(() {
                      _down = '2ª';
                    });
                  },
                  minWidth: 80,
                ),
                _buildSelectableButton(
                  text: '3ª',
                  isSelected: _down == '3ª',
                  onPressed: () {
                    setState(() {
                      _down = '3ª';
                    });
                  },
                  minWidth: 80,
                  backgroundColor: Colors.grey.shade300,
                  textColor: Colors.grey.shade600,
                ),
                _buildSelectableButton(
                  text: '4ª',
                  isSelected: _down == '4ª',
                  onPressed: () {
                    setState(() {
                      _down = '4ª';
                    });
                  },
                  minWidth: 80,
                  backgroundColor: Colors.grey.shade300,
                  textColor: Colors.grey.shade600,
                ),
              ],
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Handle skip question
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                label: Text(
                  'PULAR PERGUNTA',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Como foi a jogada?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildSelectableButton(
                    text: 'PASSE',
                    isSelected: _playType == 'PASSE',
                    onPressed: () {
                      setState(() {
                        _playType = 'PASSE';
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildSelectableButton(
                    text: 'CORRIDA',
                    isSelected: _playType == 'CORRIDA',
                    onPressed: () {
                      setState(() {
                        _playType = 'CORRIDA';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle end play action
                  print(
                    'Attempt: $_attempt, Down: $_down, Play Type: $_playType',
                  );
                  // You can add your logic here to process the selected values
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('ENCERRAR JOGADA'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? minWidth,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.blue
            : (backgroundColor ?? Colors.white),
        foregroundColor: isSelected ? Colors.white : (textColor ?? Colors.blue),
        minimumSize: Size(minWidth ?? double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected
                ? Colors.blue
                : (backgroundColor == null ? Colors.blue : Colors.transparent),
            width: 1.0,
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
