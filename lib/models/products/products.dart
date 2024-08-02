


import 'dart:math';

import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.image
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json['name'],
    description: json['description'],
    price: json['price'],
    image: json['image']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'image': image
  };

  Map<String, dynamic> newProduct() => {
    'name': 'name',
    'description': 'description',
    'price': 0.0,
    'image': 'image'
  };

  final List<Product> products = List.generate(10, (index) {
  int randomNumber = Random().nextInt(100);
  return Product(
    name: 'Product ${index + 1}',
    description: 'Description ${index + 1}',
    price: (index + 1) * 100.0,
    image: 'https://example.com/images/product$randomNumber.png',
  );
});
  
  
  @override
  List<Object?> get props => [name, description, price, image]; 
}