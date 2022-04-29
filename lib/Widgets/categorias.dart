import '../Controllers/export.dart';
import 'package:http/http.dart' as http;

class AreaCategoria extends StatefulWidget {



  @override
  _AreaCategoriaState createState() => _AreaCategoriaState();
}

class _AreaCategoriaState extends State<AreaCategoria> {

  var carregando = false;
  var dados;

  listarDados() async{
    var url = Uri.parse("http://192.168.15.6/flutter/produtos/listar-categorias.php");
    var response = await http.get(url);
    var map = json.decode(response.body);
    var itens = map["result"];

    setState(() {
      carregando = true;
      this.dados = itens;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.listarDados();
    print('teste');
  }




  @override
  Widget build(BuildContext context){


    return Container(

      height:80.0,
      margin:EdgeInsets.only(top:10.0),
        child: !carregando
            ? new LinearProgressIndicator()
            : new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.dados != null ? this.dados.length : 0,
        itemBuilder: (context, i){
          final item = this.dados[i];
          print(item);
          return GestureDetector(
              onTap:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => produtosPage("", item['id'])
            ));

          },
          child: CardCategoria(
            nomeCat: item['nome'],
            totalProd: item['produtos'],
            imgCat: item['imagem'],
          ),
          );
        },
      )
    );
  }
}