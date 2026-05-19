class Suppliers {
  final String id;
  String nome;
  String telefone;
  String email;

  Suppliers({
    required this.id,
    required this.nome, 
    required this.telefone, 
    required this.email,
  });


  factory Suppliers.fromJson(Map<String, dynamic> json) {
    return Suppliers(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      telefone: json['telefone'] ?? '',
      email: json['email'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }
}