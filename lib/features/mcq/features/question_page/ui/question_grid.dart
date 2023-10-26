import 'package:flutter/material.dart';
import 'package:pulzion23/features/mcq/models/mcq_questions_model.dart';

class QuestionGrid extends StatelessWidget {
  final PageController pgController;
  final List<Question> questions;
  const QuestionGrid({super.key, 
    required this.questions,
    required this.pgController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent.withOpacity(0.7),
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              'Questions Overview',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Not Answered', Colors.grey),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildLegendItem('Answered', Colors.green),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildLegendItem('Bookmarked', Colors.yellow),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 00,
                ),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  children: questions.map((e) {
                    bool isAnswered = e.answer != null && e.answer != -1;
                    bool isBookmarked = e.reviewStatus ?? false;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        pgController.animateToPage(
                          questions.indexOf(e),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Builder(builder: (context) {
                        var color = !isAnswered && !isBookmarked
                            ? Colors.grey
                            : isAnswered && !isBookmarked
                                ? Colors.green
                                : isBookmarked
                                    ? Colors.yellow
                                    : Colors.white;

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: color,
                              width: 2,
                            ),
                            color: color.withOpacity(0.7).withAlpha(150),
                          ),
                          child: Center(
                            child: Text(
                              '${questions.indexOf(e) + 1}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        color: color.withOpacity(0.7).withAlpha(150),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 11,
        ),
      ),
    );
  }
}
