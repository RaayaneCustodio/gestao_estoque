class Customers {
  final String id;
  String nome;
  String telefone;
  String email;

  Customers({
    required this.id, 
    required this.nome, 
    required this.telefone, 
    required this.email,
  });


  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
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