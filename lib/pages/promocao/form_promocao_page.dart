import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:my_place_core/core/model/produto_model.dart';
import 'package:my_place_core/core/model/promocao_model.dart';
import 'package:my_place_core/core/preco_utils.dart';
import 'package:my_place_core/widgets/mp_app_bar.dart';
import 'package:my_place_core/widgets/mp_button_icon.dart';
import 'package:my_place_core/widgets/mp_loading.dart';
import 'package:my_place_core/widgets/preco_desconto_Produto.dart';
import 'package:my_place_core/widgets/toasts/toast_utils.dart';
import 'package:select_form_field/select_form_field.dart';

import 'form_promocao_controller.dart';

class FormPromocaoPage extends StatefulWidget {
  FormPromocaoPage(this.promocao, {Key key}) : super(key: key);

  final PromocaoModel promocao;
  @override
  _FormPromocaoPageState createState() => _FormPromocaoPageState();
}

class _FormPromocaoPageState extends State<FormPromocaoPage> {
  final _formKey = GlobalKey<FormState>();
  MoneyMaskedTextController _descontoController;
  FormPromocaoController _controller;

  @override
  void initState() {
    _controller = FormPromocaoController(
      widget.promocao ?? PromocaoModel(),
    );
    _descontoController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      precision: 2,
      rightSymbol: ' %',
      initialValue: _controller.promocao.desconto ?? 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MPAppBar(
        title: Text(_controller.promocao.id == null
            ? 'Criar Promoção'
            : 'Editar Promoção'),
        actions: [
          MPButtonIcon(
            iconData: Icons.check,
            onTap: () async {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                await _controller.salvaPromocao();
                showSuccessToast('Promoçao foi Salva');
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Form(
            key: _formKey,
            child: FutureBuilder<List<ProdutoModel>>(
              future: _controller.produtosFuture,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final produtos = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        child: SelectFormField(
                          initialValue: _controller.promocao.idProduto,
                          labelText: 'Produto',
                          enabled: _controller.promocao.id == null,
                          items: produtos
                              .map((produto) => {
                                    'value': produto.id,
                                    'label': produto.nome,
                                  })
                              .toList(),
                          validator: (produto) =>
                              produto.isEmpty ? 'Campo Obrigatório' : null,
                          onChanged: (produto) {
                            setState(() {
                              _controller.setInfoProdutoPromocao(produto);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: 150,
                        child: TextFormField(
                          controller: _descontoController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"\d+"),
                            ),
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: 'Desconto',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (desconto) {
                            if (desconto == null || desconto == 'R\$') {
                              return 'Campo obrigatório';
                            } else if (double.parse(
                                    PrecoUtils.limpaStringDesconto(desconto)) ==
                                0) {
                              return 'Desconto tem que ser maior que 0%';
                            } else if (double.parse(
                                    PrecoUtils.limpaStringDesconto(desconto)) >=
                                100) {
                              return 'Desconto tem que ser menor que 100%';
                            }
                            return null;
                          },
                          onSaved: (desconto) {
                            final stringDesconto =
                                PrecoUtils.limpaStringDesconto(desconto);
                            _controller.setDescontoPromocao(
                                double.parse(stringDesconto));
                          },
                          onChanged: (desconto) {
                            final doubleDesconto = double.parse(desconto) / 100;
                            setState(() {
                              _controller.setDescontoPromocao(doubleDesconto);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      if (_controller.promocao.id != null ||
                          _controller.temProdutoEscolhido)
                        PrecoDescontoProduto(
                          desconto: _controller.promocao.desconto,
                          preco: _controller.calculaPrecoComDesconto(),
                        ),
                    ],
                  );
                } else {
                  return Center(
                    child: MPLoading(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
