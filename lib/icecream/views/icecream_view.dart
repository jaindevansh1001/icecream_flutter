// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/icecream/model/icecream.dart';
import 'package:flutter_catalog/icecream/views/icecream_detailview.dart';
import 'package:flutter_catalog/icecream/widgets/icecream_card.dart';

class IcecreamView extends StatelessWidget {
  const IcecreamView({super.key});

  Future<List<Icecream>?> loadIcecreams() async {
    final rawIcecreams = await rootBundle.loadString("assets/icecream.json");
    await Future.delayed(const Duration(seconds: 1));
    final icecreams = icecreamDataFromJson(rawIcecreams);
    return icecreams.icecreams;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Icecream",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(
            "We have something yummy for you",
            style: Theme.of(context).textTheme.bodySmall!,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
                future: loadIcecreams(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final icecreams = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height / 2,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final icecream = icecreams[index];

                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IcecreamDetailView(
                                                  icecream: icecream,
                                                )));
                                  },
                                  child: IcecreamCard(icecream: icecream));
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: icecreams!.length,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                }),
          )
        ],
      ),
    );
  }
}