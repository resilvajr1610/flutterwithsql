import '../Controllers/export.dart';
import 'package:http/http.dart' as http;

class Buscar extends StatelessWidget {
   var dados;
   var txtbuscar = new TextEditingController();
  @override
  Widget build(BuildContext context){
    return Material(
      child: TextFormField(
          controller: txtbuscar,
          style:TextStyle(color: Colors.black, fontSize: 16.0),
          cursorColor: Theme.of(context).primaryColor,
          decoration:InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
              suffixIcon: Material(
                  child: IconButton(
                    icon:Icon(
                    Icons.search,
                    color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => produtosPage(txtbuscar.text, "")
                      ));
                    })
              ),
              hintText: "Buscar Produtos"
          )
      ),
    );
  }
}
