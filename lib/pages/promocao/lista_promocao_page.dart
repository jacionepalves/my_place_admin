import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place_core/widgets/mp_app_bar.dart';
import 'package:my_place_core/widgets/mp_button_icon.dart';
import 'package:my_place_core/widgets/mp_empty.dart';
import 'package:my_place_core/widgets/mp_list_tile.dart';
import 'package:my_place_core/widgets/mp_list_view.dart';
import 'package:my_place_core/widgets/mp_loading.dart';

import 'form_promocao_page.dart';
import 'lista_promocao_controller.dart';

class ListaPromocaoPage extends StatelessWidget {
  final _controller = ListaPromocaoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Promoções'),
        actions: [
          MPButtonIcon(
            iconData: Icons.add,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FormPromocaoPage(null),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.promocoesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final promocoes =
                _controller.getPromocoesFromData(snapshot.data.docs);
            if (promocoes.isEmpty || promocoes == null) {
              return MPEmpty();
            } else {
              return MPListView(
                itemCount: promocoes.length,
                itemBuilder: (context, i) => MPListTile(
                  leading: Icon(Icons.campaign),
                  title: Text(promocoes[i].nomeProduto),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _controller.removePromocao(promocoes[i]);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FormPromocaoPage(promocoes[i]),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: MPLoading(),
            );
          }
          return MPEmpty();
        },
      ),
    );
  }
}
