import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vbee_app/app/model/Pokemon.dart';
import 'package:vbee_app/app/pokemon/PokemonNotifier.dart';
import 'package:vbee_app/base/theme/custom_theme.dart';

class PokemonHome extends StatefulWidget {
  CustomTheme customTheme;
  var title;

  PokemonHome(this.title, this.customTheme);

  @override
  State<StatefulWidget> createState() {
    return _MyPokemonState();
  }
}

class _MyPokemonState extends State {
  var notifier = PokemonNotifier();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifier.getMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (BuildContext context, List<Pokemon> value, Widget child) {
          return value != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    return await notifier.reload();
                  },
                  child: value.isEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return const Center(child: Text('No Pokemon!'));
                          })
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo is ScrollEndNotification &&
                                scrollInfo.metrics.extentAfter == 0) {
                              notifier.getMore();
                              return true;
                            }
                            return false;
                          },
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(),
                                  ),
                              padding: EdgeInsets.only(top: 20),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: value.length,
                              cacheExtent: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return PokemonItem(pokemon: value[index]);
                              }),
                        ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget PokemonItem({Pokemon pokemon}) {
  return Card(
    child: Row(
      children: [
        Expanded(
            child: Column(
          children: [Text(pokemon.name), Text(pokemon.stats.toString())],
        )),
        Expanded(
            child: Column(
          children: [Image.network(pokemon.defaultImage)],
        ))
      ],
    ),
  );
}
