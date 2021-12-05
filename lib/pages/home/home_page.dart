import 'package:flutter/material.dart';
import 'package:my_place_admin/pages/categoria/lista_categoria_page.dart';
import 'package:my_place_admin/pages/produto/lista_produto_page.dart';
import 'package:my_place_admin/pages/promocao/lista_promocao_page.dart';
import 'package:my_place_core/core/model/usuario_model.dart';
import 'package:my_place_core/widgets/mp_app_bar.dart';
import 'package:my_place_core/widgets/mp_logo_admin.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.usuario, {Key key}) : super(key: key);
  final UsuarioModel usuario;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: MPLogoAdmin(
          fontSize: 28,
        ),
        withLeading: false,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _Button(
              text: 'Categorias',
              iconData: Icons.category,
              page: ListaCategoriaPage(),
            ),
            _Button(
              text: 'Produtos',
              iconData: Icons.fastfood,
              page: ListaProdutoPage(),
            ),
            _Button(
              text: 'Promoções',
              iconData: Icons.campaign,
              page: ListaPromocaoPage(),
            ),
            _Button(
              text: 'Pedidos Pendentes',
              iconData: Icons.pending,
              page: Scaffold(),
            ),
            _Button(
              text: 'Pedidos Finalizado',
              iconData: Icons.flag,
              page: Scaffold(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  _Button({
    this.page,
    this.iconData,
    this.text,
  });

  final Widget page;
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        child: Container(
          width: 100,
          height: 90,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(
                iconData,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 6),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
