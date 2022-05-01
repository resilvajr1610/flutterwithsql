import '../Controllers/export.dart';
import 'package:http/http.dart' as http;

class cadastroPage extends StatefulWidget {
  var _id;

  cadastroPage(id) {

    this._id = id;
  }
  @override
  _cadastroPageState createState() => _cadastroPageState();
}

class _cadastroPageState extends State<cadastroPage> {
  bool _toggleVisibility = true;

  String? _email;
  String? _nome;
  String? _senha;
  String? _cpf;
  String? _telefone;

  var nome, cpf, telefone, email, senha;
  var nometxt, emailtxt, senhatxt, cpftxt, telefonetxt;
  var dados;
  var caminhoImg = "assets/imagens/cadastro.png";
  var nomebtn = "Inserir";

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _emailtxt() {
    return TextFormField(
      controller: emailtxt,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (email) {
        _email = email!;
      },
      validator: (email) {
        String? errorMessage;
        if (email!.contains("@")) {
          errorMessage = "Seu email está incorreto";
        }
        if (email.isEmpty) {
          errorMessage = "O campo email é requerido";
        }

        return errorMessage;
      },
    );
  }

  Widget _nometxt() {
    return TextFormField(
      controller: nometxt,
      decoration: InputDecoration(
        hintText: "Nome",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        ),
      ),
      onSaved: (username) {
        _nome = username?.trim();
      },
      validator: (username) {
        String? errorMessage;
        if (username!.isEmpty) {
          errorMessage = "O nome é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _cpftxt() {
    return TextFormField(
      controller: cpftxt,
      decoration: InputDecoration(
        hintText: "CPF",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (cpf) {
        _cpf = cpf?.trim();
      },
      validator: (cpf) {
        String? errorMessage;
        if (cpf!.isEmpty) {
          errorMessage = "O cpf é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _telefonetxt() {
    return TextFormField(
      controller: telefonetxt,
      decoration: InputDecoration(
        hintText: "Telefone",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (telefone) {
        _telefone = telefone?.trim();
      },
      validator: (telefone) {
        String? errorMessage;
        if (telefone!.isEmpty) {
          errorMessage = "O telefone é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _senhatxt() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        hintText: "Senha",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (password) {
        _senha = password;
      },
      validator: (password) {
        String? errorMessage;

        if (password!.isEmpty) {
          errorMessage = "O campo senha é requerido";
        }
        return errorMessage;
      },
    );
  }

  mensagem(res){
    var alert = new AlertDialog(
      title: new Text('Inserir Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text(res),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context)=>alert);

    if(res == 'Inserido com Sucesso'){
      nometxt.text = "";
      telefonetxt.text = "";
      emailtxt.text = "";
      senhatxt.text = "";
      cpftxt.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget._id != ""){
      caminhoImg = "assets/imagens/excluir.png";
      nomebtn = "Editar";
      recuperarDados();
    }
    nometxt = new TextEditingController();
    emailtxt = new TextEditingController();
    senhatxt = new TextEditingController();
    cpftxt = new TextEditingController();
    telefonetxt = new TextEditingController();
  }

  //método para recuperar os dados do usuário logado
  recuperarDados() async{

    var url= Uri.encodeFull("http://${IP().value()}/flutter/usuarios/recuperarDados.php?id=${widget._id}");
    var response = await http.get(Uri.parse(url),
        headers: {"Accept": "application/json"});

    final map = json.decode(response.body);
    final itens = map["result"];

      setState(() {

        this.dados = itens;

        nome = dados[0]["nome"];
        cpf = dados[0]["cpf"];
        telefone = dados[0]["telefone"];
        email = dados[0]["email"];
        senha = dados[0]["senha"];

        nometxt = new TextEditingController(text: nome);
        emailtxt = new TextEditingController(text: email);
        senhatxt = new TextEditingController(text: senha);
        cpftxt = new TextEditingController(text: cpf);
        telefonetxt = new TextEditingController(text: telefone);
      });
  }

  //método para inserir na api
  void _inserir() async{
    var url = Uri.parse("http://${IP().value()}/flutter/usuarios/inserir.php");
    var response = await http.post(url,
      body:{
      "nome": nometxt.text,
      "email": emailtxt.text,
      "cpf": cpftxt.text,
      "telefone": telefonetxt.text,
      "senha": senhatxt.text,
      "id" : widget._id.toString(),
    });

    if (response.statusCode == 200) {
      print(response.body.toString());
    }

    final map = json.decode(response.body);
    final res = map["message"];
    print(res);
    mensagem(res);
  }

  mensagemExcluir(){
    var alert = new AlertDialog(
      title: new Text('Excluir Usuário'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text("Deseja Realmente Excluir o Usuário"),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Sim'),
          onPressed: () {
            excluirUsuario(widget._id);
          },
        ),
        new FlatButton(
          child: new Text('Não'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    //showDialog(context: context, child: alert);
  }

  excluirUsuario(id){
    http.get(
        Uri.parse(
            "http://192.168.2.112/flutter/usuarios/excluir.php?id=${id}"),
        headers: {"Accept": "application/json"});
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Tabs("", "", "")
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      mensagemExcluir();
                    },
                    child:Image(
                      image:AssetImage(caminhoImg),
                      height:120.0,
                      width:120.0,
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: _nometxt(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: _cpftxt(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: _telefonetxt(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: _emailtxt(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: _senhatxt(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                    _inserir();
                     },
                    child: Button(
                     btnText: nomebtn,
                     ),
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Já possui Cadastro?",
                          style: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage()));
                          },
                          child: Text(
                            "Logar",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void onSubmit(Function authenticate) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print("Seu Email: $_email, sua senha: $_senha");
      authenticate(_email, _senha);
    }
  }
}