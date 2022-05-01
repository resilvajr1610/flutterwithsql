import '../Controllers/export.dart';
import 'package:http/http.dart' as http;

class CardProduto extends StatefulWidget {
  var _altura, _largura, _nomebusca, _idcat;

  CardProduto(altura, largura, nomebusca, idcat) {
    this._altura = altura;
    this._largura = largura;
    this._nomebusca = nomebusca;
    this._idcat = idcat;
  }
@override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  var cardText = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  var carregando = false;
  var dados;
  var nome, imagem, valor;
  var buscar;

  @override
  void initState() {
    super.initState();
    _listarDados();
  }

  _listarDados() async{
    buscar = widget._nomebusca;
    var url= Uri.encodeFull("http://${IP().value()}/flutter/produtos/listar.php?nome=${buscar}");
    var response = await http.get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    final map = json.decode(response.body);
    final itens = map["result"];
    if(map["result"] == 'Dados não encontrados!'){
      mensagem();
    }else{
      setState(() {
        carregando = true;
        this.dados = itens;
      });
    }
  }

  mensagem(){
    var alert = new AlertDialog(
      title: new Text('Listar Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text("Produto não encontrado"),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Tabs("","","")));
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context)=>alert);
  }

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget._altura,
            width: widget._largura,
            child: !carregando
                ? new LinearProgressIndicator()
                : new ListView.builder(
              itemCount: this.dados != null ? this.dados.length : 0,
              itemBuilder: (context, i){
                final item = this.dados[i];
                return new Container(
                  margin: EdgeInsets.only(bottom: 7.0),
                  child:Stack(
                    children: <Widget>[
                      Container(
                        child:Image.asset("assets/imagens/"+item['imagem'])),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        width: 340.0,
                        height: 60.0,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black, Colors.black12])),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['nome'],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Avaliação 5",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  item['valor'],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent),
                                ),
                                Text("Add",
                                    style: TextStyle(color: Colors.grey))
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }

}