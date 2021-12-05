import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place_core/widgets/mp_app_bar.dart';
import 'package:my_place_core/widgets/mp_button_icon.dart';
import 'package:my_place_core/widgets/mp_empty.dart';
import 'package:my_place_core/widgets/mp_list_tile.dart';
import 'package:my_place_core/widgets/mp_list_view.dart';
import 'package:my_place_core/widgets/mp_loading.dart';

import 'form_produto_page.dart';
import 'lista_produto_controller.dart';


class ListaProdutoPage extends StatelessWidget {
  final _controller = ListaProdutoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Produtos'),
        actions: [
          MPButtonIcon(
            iconData: Icons.add,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FormProdutoPage(null),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.produtosStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final produtos =
                _controller.getProdutosFromData(snapshot.data.docs);
            if (produtos.isEmpty || produtos == null) {
              return MPEmpty();
            } else {
              return MPListView(
                itemCount: produtos.length,
                itemBuilder: (context, i) => MPListTile(
                  leading: Hero(
                    tag: produtos[i].id,
                    child: produtos[i].urlImagem != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(produtos[i].urlImagem),
                          )
                        : Icon(Icons.fastfood),
                  ),
                  title: Text(produtos[i].nome),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _controller.removeProduto(produtos[i]);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FormProdutoPage(produtos[i]),
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
