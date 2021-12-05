import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_place_core/core/model/produto_model.dart';

class FormProdutoController {
  FormProdutoController(this.produto);

  final _categoriasRef = FirebaseFirestore.instance.collection('categorias');
  final _produtosRef = FirebaseFirestore.instance.collection('produtos');
  ProdutoModel produto;
  final _firebaseStorage = FirebaseStorage.instance.ref();
  final _imagePicker = ImagePicker();

  Future<QuerySnapshot>get categoriasFuture => _categoriasRef.get();

  List<String> getCategoriasFromData(List<QueryDocumentSnapshot> docs){
    return List.generate(docs.length, (i) {
      final doc = docs[i];
      return doc.data()['nome'];
    });
  }
  Future<String> escolheESalvaImagem(ImageSource source) async {
    final arquivo = await _imagePicker.getImage(source: source);
    if (arquivo != null) {
      final imagem = await arquivo.readAsBytes();
      final dataImagem = imagem.buffer.asUint8List();
      final uploadTask = _firebaseStorage
          .child('produtos')
          .child(dataImagem.hashCode.toString())
          .putData(dataImagem);
      final onTaskCompletada = await uploadTask.onComplete;
      final categoriaUrl = await onTaskCompletada.ref.getDownloadURL();
      return categoriaUrl;
    }
    return null;
  }

  Future<void> salvaProduto() async {
    if (produto.id != null){
      await _produtosRef.doc(produto.id).update(produto.toJson());
    } else{
      await _produtosRef.add(produto.toJson());
    }
  }

  void setNomeProduto(String nome){
    produto.nome = nome;
  }

  void setDescricaoProduto(String descricao){
    produto.descricao = descricao;
  }

  void setPrecoProduto(String preco){
    produto.preco = preco;  }

  void setCategoriaProduto(String categoria){
    produto.categoria = categoria;  }

  void setUrlImagemProduto(String urlImagem){
    produto.urlImagem = urlImagem;
  }
}