// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'Book.dart';
import 'DatabaseHelper.dart';
import 'Panier.dart';

class DetailPage extends StatefulWidget { // Add StatefulWidget here
  final Book book;

  const DetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(); // Return a state object here
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;
  late String _bookImage; // Add this variable to hold the book image

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() { // Initialize _bookImage in initState
    _bookImage = widget.book.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('some Details '),
       actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PanierPage(),
                ),
              );
            },
          )
        ],),

      body: SingleChildScrollView(       
         padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/$_bookImage'), // Use _bookImage here
             width: 300,
              height: 200,              ),
              const SizedBox(height: 20),
              Text(
                widget.book.titre, // Use widget.book here
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Auteur: ${widget.book.auteur}', // Use widget.book here
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Prix: ${widget.book.prix}', // Use widget.book here
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Description de la livre : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                widget.book.description, // Use widget.book here
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
             Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Quantity: $_quantity'),
    Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (_quantity > 1) {
                _quantity--;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Icon(Icons.remove, color: Colors.white),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            setState(() {
              _quantity++;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    ),
  ],
),
              ElevatedButton(
                onPressed: () async {
                  Book newBook = Book(
                    id: widget.book.id, // Use widget.book here
                    titre: widget.book.titre,
                    auteur: widget.book.auteur,
                    image: widget.book.image,
                    description: widget.book.description,
                    prix: widget.book.prix,
                    quantite: _quantity,
                  );
                  int res = await databaseHelper.saveBook(newBook);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Livre ajouté au panier'),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Ajouter à la carte'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
