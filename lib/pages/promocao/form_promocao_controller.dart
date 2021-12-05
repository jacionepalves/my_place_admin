import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_core/core/model/produto_model.dart';
import 'package:my_place_core/core/model/promocao_model.dart';
import 'package:my_place_core/core/preco_utils.dart';

class FormPromocaoController {
  FormPromocaoController(this.promocao);

  final _produtosRef = FirebaseFirestore.instance.collection('produtos');
  final _promocoesRef = FirebaseFirestore.instance.collection('promocoes');
  final PromocaoModel promocao;
  List<ProdutoModel> listaProdutos;

  bool get temProdutoEscolhido => promocao.idProduto != null;
  Future<List<ProdutoModel>> get  produtosFuture => getTodosProdutos();
  Future<List<ProdutoModel>> getTodosProdutos() async {
    final querySnapshot = await _produtosRef.get();
    listaProdutos = querySnapshot.docs
      .map((doc) => ProdutoModel.fromJson(doc.id, doc.data()))
      .toList();
    return listaProdutos;
  }

  void setInfoProdutoPromocao(String produtoId){
    final produto = listaProdutos.firstWhere((prod) => prod.id == produtoId);
    if (produto != null){
      promocao.idProduto = produto.id;
      promocao.nomeProduto = produto.nome;
      promocao.urlImagem = produto.urlImagem;
      promocao.valorOriginalProduto = double.parse(PrecoUtils.limpaStringPreco(produto.preco));
      promocao.idProduto = produto.id;
    }
  }

  void setDescontoPromocao(double desconto){
    promocao.desconto = desconto;
  }

  ProdutoModel getProdutoEscolhido (){
    return listaProdutos.firstWhere((produto) => produto.id == promocao.idProduto);
  }
  double calculaPrecoComDesconto(){
    final produto = getProdutoEscolhido();
    final preco = double.parse(PrecoUtils.limpaStringPreco(produto.preco));
    return preco - ((preco * (promocao.desconto ?? 0))/ 100);
  }

  Future<void> salvaPromocao() async{
    await _promocoesRef.doc(promocao.idProduto).set(promocao.toJson());
  }
}