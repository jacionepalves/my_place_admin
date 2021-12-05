import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_place_core/core/model/promocao_model.dart';

class ListaPromocaoController {
  CollectionReference promocoesRef = FirebaseFirestore.instance.collection('promocoes');
  final Stream<QuerySnapshot> _promocoesStream = 
      FirebaseFirestore.instance.collection('promocoes').snapshots();

  Stream<QuerySnapshot> get promocoesStream => _promocoesStream;
  
  List<PromocaoModel> getPromocoesFromData(List<QueryDocumentSnapshot> docs) {
    return List.generate(docs.length, (i) {
      final promocaoDoc = docs[i];
      return PromocaoModel.fromJson(
        promocaoDoc.id,
        promocaoDoc.data(),
      );
    });
  }

  Future<void> removePromocao (PromocaoModel promocao) async {
    await promocoesRef.doc(promocao.id).delete();
  }
}

