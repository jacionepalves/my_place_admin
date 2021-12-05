import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_core/core/model/produto_model.dart';
import 'package:my_place_core/core/model/promocao_model.dart';

class ListaProdutoController {
  CollectionReference produtosRef =
      FirebaseFirestore.instance.collection('produtos');
  CollectionReference promocoesRef =
      FirebaseFirestore.instance.collection('promocoes');
  final Stream<QuerySnapshot> _produtosStream =
      FirebaseFirestore.instance.collection('produtos').snapshots();

  Stream<QuerySnapshot> get produtosStream => _produtosStream;

  List<ProdutoModel> getProdutosFromData(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final produtoDoc = docs[i];
      return ProdutoModel.fromJson(
        produtoDoc.id,
        produtoDoc.data(),
      );
    });
  }

  Future<List<PromocaoModel>> getPromocoesProduto(ProdutoModel produto) async {
    final querySnapshot =
        await promocoesRef.where('idProduto', isEqualTo: produto.id).get();
    final docs = querySnapshot.docs;
    return List.generate(
        docs.length, (i) => PromocaoModel.fromJson(docs[i].id, docs[i].data()));
  }

  Future<void> removeProduto(ProdutoModel produto) async {
    await produtosRef.doc(produto.id).delete();
    final promocoesProduto = await getPromocoesProduto(produto);
    promocoesProduto.forEach((promocao) async {
      await promocoesRef.doc(promocao.id).delete();
    });
  }
}
