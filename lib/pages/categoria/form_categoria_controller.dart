import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_place_core/core/model/categoria_model.dart';

class FormCategoriaController {
  FormCategoriaController(this._categoria);
  CategoriaModel _categoria;
  final _firebaseStorage = FirebaseStorage.instance.ref();
  final _imagePicker = ImagePicker();

  final _categoriasRef = FirebaseFirestore.instance.collection('categorias');

  CategoriaModel get categoria => _categoria;
  Future<void> salvaCategoria() async {
    if(_categoria.id != null){
      await _categoriasRef.doc(_categoria.id).update(_categoria.toJson());
    } else{
      await _categoriasRef.add(_categoria.toJson());
    }
    
  }

  Future<String> escolheESalvaImagem(ImageSource source) async {
    final arquivo = await _imagePicker.getImage(source: source);
    if (arquivo != null) {
      final imagem = await arquivo.readAsBytes();
      final dataImagem = imagem.buffer.asUint8List();
      final uploadTask = _firebaseStorage
          .child('categorias')
          .child(dataImagem.hashCode.toString())
          .putData(dataImagem);
      final onTaskCompletada = await uploadTask.onComplete;
      final categoriaUrl = await onTaskCompletada.ref.getDownloadURL();
      return categoriaUrl;
    }
    return null;
  }

  void setNomeCategoria(String nome) => _categoria.nome = nome;
  void setDescricaoCategoria(String descricao) =>
      _categoria.descricao = descricao;
  void setUrlImagemCategoria(String urlImagem) =>
      _categoria.urlImagem = urlImagem;
}
