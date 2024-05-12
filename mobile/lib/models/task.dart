class Task {
  final String id;
  final String text;
  final String status;

  Task({required this.id, required this.text, required this.status});

  // Método para criar uma instância de Task a partir de um Map (deserialização)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(id: json['id'], text: json['text'], status: json['status']);
  }

  // Método para converter uma instância de Task em um Map (serialização)
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'status': status};
  }
}
