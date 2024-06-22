// Card model
class CardModel {
  final String id;
  final String color;
  final String value;

  CardModel({
    required this.id,
    required this.color,
    required this.value,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      color: json['color'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'value': value,
    };
  }
}