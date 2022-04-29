import '../Controllers/export.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:"Aplicativo Flutter",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Tabs("", "", ""),
    );
  }
}