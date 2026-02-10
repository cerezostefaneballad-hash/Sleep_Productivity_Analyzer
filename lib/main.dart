import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SleepProductivityApp());
}

//test123
//test

class SleepProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleep & Productivity Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: AnalyzerScreen(),
    );
  }
}

class AnalyzerScreen extends StatefulWidget {
  @override
  _AnalyzerScreenState createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  final TextEditingController sleepController = TextEditingController();
  final TextEditingController studyController = TextEditingController();
  final TextEditingController screenController = TextEditingController();

  String result = "";
  String recommendation = "";
  double balanceScore = 0;
  String lifestyleCategory = "";

  // 🔹 HISTORY LIST
  List<String> historyList = [];

  void analyzeData() {
    try {
      double sleepHours = double.parse(sleepController.text);
      double studyHours = double.parse(studyController.text);
      double screenTime = double.parse(screenController.text);

      // Arithmetic operation
      balanceScore = (studyHours * 2 + sleepHours) - screenTime;

      // If-Else Classification
      if (balanceScore >= 15) {
        lifestyleCategory = "Healthy";
      } else if (balanceScore >= 8) {
        lifestyleCategory = "Moderate";
      } else {
        lifestyleCategory = "Unhealthy";
      }

      // Switch for Recommendation
      switch (lifestyleCategory) {
        case "Healthy":
          recommendation = "Great job! Maintain your routine.";
          break;
        case "Moderate":
          recommendation = "Reduce screen time and increase sleep.";
          break;
        case "Unhealthy":
          recommendation =
          "Warning! Improve sleep and reduce screen time.";
          break;
        default:
          recommendation = "Invalid category.";
      }

      String record =
          "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} | Score: ${balanceScore.toStringAsFixed(2)} | $lifestyleCategory";

      setState(() {
        result =
        "Balance Score: ${balanceScore.toStringAsFixed(2)}\nLifestyle: $lifestyleCategory";
        historyList.insert(0, record); // Add to beginning of history
      });

    } catch (e) {
      setState(() {
        result = "Error: Please enter valid numbers.";
        recommendation = "";
      });
    }
  }

  void clearHistory() {
    setState(() {
      historyList.clear();
    });
  }

  void clearAll() {
    setState(() {
      sleepController.clear();
      studyController.clear();
      screenController.clear();
      result = "";
      recommendation = "";
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Healthy":
        return Colors.green;
      case "Moderate":
        return Colors.orange;
      case "Unhealthy":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Healthy":
        return Icons.check_circle;
      case "Moderate":
        return Icons.warning;
      case "Unhealthy":
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep & Productivity Analyzer",
            style: TextStyle(fontWeight: FontWeight.w600, color:  Colors.grey.shade50)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.grey.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Card
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Daily Input",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildInputField(
                          "Sleep Hours",
                          Icons.bedtime_outlined,
                          sleepController,
                        ),
                        SizedBox(height: 15),
                        _buildInputField(
                          "Study Hours",
                          Icons.school_outlined,
                          studyController,
                        ),
                        SizedBox(height: 15),
                        _buildInputField(
                          "Screen Time (Hours)",
                          Icons.smartphone_outlined,
                          screenController,
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: analyzeData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade800,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.analytics_outlined, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      "Analyze",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: clearAll,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                foregroundColor: Colors.grey.shade800,
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Icon(Icons.clear_all, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),

                // Results Section
                if (result.isNotEmpty) ...[
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getCategoryIcon(lifestyleCategory),
                                color: _getCategoryColor(lifestyleCategory),
                                size: 28,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Analysis Result",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(lifestyleCategory).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _getCategoryColor(lifestyleCategory).withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  recommendation,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _getCategoryColor(lifestyleCategory),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                ],

                // History Section
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.history_outlined,
                                  color: Colors.blue.shade800,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Analysis History",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                            if (historyList.isNotEmpty)
                              TextButton(
                                onPressed: clearHistory,
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red.shade600,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline, size: 18),
                                    SizedBox(width: 4),
                                    Text("Clear"),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 15),
                        if (historyList.isEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history_toggle_off_outlined,
                                  size: 60,
                                  color: Colors.grey.shade300,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "No analysis history yet",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ...historyList.map((record) {
                            final parts = record.split(' | ');
                            final time = parts[0];
                            final score = parts[1];
                            final category = parts[2];

                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(category).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(category),
                                    color: _getCategoryColor(category),
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  score,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(category),
                                trailing: Text(
                                  time,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade600),
        labelStyle: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}