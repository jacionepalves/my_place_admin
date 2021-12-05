import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_place_admin/pages/categoria/form_categoria_page.dart';
import 'package:my_place_core/widgets/mp_app_bar.dart';
import 'package:my_place_core/widgets/mp_button_icon.dart';
import 'package:my_place_core/widgets/mp_empty.dart';
import 'package:my_place_core/widgets/mp_list_tile.dart';
import 'package:my_place_core/widgets/mp_list_view.dart';
import 'package:my_place_core/widgets/mp_loading.dart';
import 'lista_categoria_controller.dart';

class ListaCategoriaPage extends StatelessWidget {
  final _controller = ListaCategoriaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text('Lista de Categorias'),
        actions: [
          MPButtonIcon(
            iconData: Icons.add,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FormCategoriaPage(null),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.categoriasStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categorias =
                _controller.getCategoriasFromDocs(snapshot.data.docs);
            if (categorias.isEmpty || categorias == null) {
              return MPEmpty();
            } else {
              return MPListView(
                itemCount: categorias.length,
                itemBuilder: (context, i) => MPListTile(
                  leading: Hero(
                    tag: categorias[i].id,
                    child: categorias[i].urlImagem != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(categorias[i].urlImagem),
                          )
                        : Icon(Icons.category),
                  ),
                  title: Text(categorias[i].nome),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _controller.removeCategoria(categorias[i]);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FormCategoriaPage(categorias[i]),
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
