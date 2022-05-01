import '../Controllers/export.dart';

class TelaInicial extends StatefulWidget{
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {

  AreaCategoria area = new AreaCategoria();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(
        padding:EdgeInsets.only(left:20.0, top:30.0, right:20.0),
        children: <Widget>[
          Cabecalho(),
          AreaCategoria(),
          Buscar(),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Produtos Mais Vendidos",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Precionou' pressed");
                },
                child: Text(
                  "Ver Todos",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Column(
              children: <Widget>[
                CardProduto(230.0, 340.0, "", "")
              ],
          )
        ],
      ),
    );
  }
}