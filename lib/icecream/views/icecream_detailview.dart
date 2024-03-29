
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/icecream/model/icecream.dart';

class IcecreamDetailView extends StatelessWidget {
  const IcecreamDetailView({super.key, required this.icecream});

  final Icecream icecream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(icecream.flavor),
        backgroundColor: const Color.fromARGB(255, 242, 126, 192),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: icecream.image!,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: CachedNetworkImageProvider(
                          icecream.image!,
                          cacheKey: icecream.image!),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "\$${icecream.price.toString()}",
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 4, 35, 88),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                icecream.description!,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Toppings",
                style: TextStyle(
                    color: Color.fromARGB(255, 196, 30, 85),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(label: Text(icecream.toppings![index])),
                    );
                  },
                  itemCount: icecream.toppings!.length,
                ),
              ),
              const Text(
                "Ingredients",
                style: TextStyle(
                    color: Color.fromARGB(255, 196, 30, 85),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final ing = icecream.ingredients[index];
                  return Card(
                    child: ListTile(
                      title: Text(ing.name),
                      subtitle: Text("QTY- ${ing.quantity}"),
                    ),
                  );
                },
                itemCount: icecream.ingredients.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
