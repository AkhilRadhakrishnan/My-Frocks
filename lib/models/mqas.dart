import 'dart:convert';

class MQAs {
  final List<MQA> qas;
  MQAs({this.qas});
  factory MQAs.fromRawJson(dynamic str) =>
      MQAs.fromJson(str);
  factory MQAs.fromJson(dynamic json) => MQAs(
      qas: List<MQA>.from(json.map((x) => MQA.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(qas.map((x) => x.toJson())),
      };
}

class MQA {
  final String qa_id;
  final String qa_question;
  final String qa_answer;
  MQA({this.qa_id,
      this.qa_question,
      this.qa_answer,});
  factory MQA.fromJson(Map<String, dynamic> json) => MQA(
        qa_id: json["qa_id"],
        qa_question: json["qa_question"],
        qa_answer: json["qa_answer"],
      );
  Map<String, dynamic> toJson() => {
        "qa_id": qa_id,
        "qa_question": qa_question,
        "qa_answer": qa_answer,
      };
}
