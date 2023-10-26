class QuestionList {
  List<Question> questions = [];

  QuestionList.fromJson(List<dynamic> json) {
    for (int i = 0; i < json.length; i++) {
      Question question = Question.fromJson(json[i]);
      questions.add(question);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questions'] = questions.map((x) => x.toJson()).toList();

    return data;
  }
}

class Question {
  String? id;
  FkQuestion? fkQuestion;
  int? answer;
  bool? reviewStatus;

  Question({this.id, this.fkQuestion, this.answer, this.reviewStatus});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      fkQuestion: FkQuestion.fromJson(json['fk_question']),
      answer: json['answer'],
      reviewStatus: json['review_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fk_question'] = fkQuestion?.toJson();
    data['answer'] = answer;
    data['review_status'] = reviewStatus;

    return data;
  }
}

class FkQuestion {
  String? id;
  String? statement;
  String? code;
  String? imageUrl;
  List<String>? options;

  FkQuestion({
    this.id,
    this.statement,
    this.code,
    this.imageUrl,
    this.options,
  });

  factory FkQuestion.fromJson(Map<String, dynamic> json) {
    return FkQuestion(
      id: json['id'],
      statement: json['statement'],
      code: json['code'],
      imageUrl: json['image_url'],
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['statement'] = statement;
    data['code'] = code;
    data['image_url'] = imageUrl;
    data['options'] = options;

    return data;
  }
}
