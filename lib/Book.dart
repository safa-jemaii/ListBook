class Book {
  final int id;
  final String titre;
  final String auteur;
  final String image;
  final String description;
  final double prix;
  int quantite;

  Book({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.image,
    required this.description,
    required this.prix,
    required this.quantite,

  });
 void addquan()
 {
   this.quantite+=1;
 }
  void removequan()
  {
    if(this.quantite>1) {
      this.quantite -= 1;
    }
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': titre,
      'author': auteur,
      'imageUrl': image,
      'description': description,
      'price': prix,
      'quantity': quantite,
    };
  }
}
