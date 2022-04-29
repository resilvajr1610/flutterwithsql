import '../Controllers/export.dart';

class Tabs extends StatefulWidget{
  var _cpf, _nome, _id;

  Tabs(cpf, nome, id) {
    this._cpf = cpf;
    this._nome = nome;
    this._id = id;
  }
  @override
  _TabsState createState() => _TabsState();

}

class _TabsState extends State<Tabs>{

   var cpfuser, nomeuser, iduser;

  int abaAtual = 0;
  TelaInicial? telaInicial;
  carrinhoPage? carrinho;
  produtosPage? produtos;
  categoriasPage? categorias;

  List<Widget>? pages;
  Widget? pagAtual;


  @override
  void initState(){
    telaInicial = TelaInicial();
    carrinho = carrinhoPage();
    produtos = produtosPage("", "");
    categorias = categoriasPage();

    pages = [telaInicial!, carrinho!, produtos!, categorias!];
    pagAtual = telaInicial;
    super.initState();
  }


  @override
  Widget build(BuildContext context){

  cpfuser = widget._cpf;
  nomeuser = widget._nome;
  iduser = widget._id;

    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            title:Text(
              abaAtual == 0
                  ? "Página Inicial"
                  : abaAtual == 1
                  ? "Carrinho"
                  : abaAtual == 2 ? "Produtos" : "Categorias",
              style:TextStyle(
                  color:Colors.white,
                  fontSize:15.0,
                  fontWeight: FontWeight.bold
              ),

            ),
            centerTitle: true,

            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.account_box,
                    // size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                  }),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],

          ),


          //COLOCAR DRAWER
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                ListTile(

                  onTap: () {

                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => cadastroPage(iduser)
                    ));
                  },

                  leading: Icon(Icons.people),

                  title: Text(
                    "Inserir/Editar Usuários",

                    style: TextStyle(fontSize: 16.0),

                  ),
                )
              ],
            ),
          ),

          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: abaAtual,
            onTap: (index) {
              setState(() {
                abaAtual = index;
                pagAtual = pages?[index];
              });
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "Carrinho",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_library,
                ),
                label: "Produtos",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: "Categoria",
              ),
            ],
          ),


          //TRAZER O CONTEÚDO DA PÁGINA INICIAL HOME
          body:pagAtual,


        )
    );
  }


}