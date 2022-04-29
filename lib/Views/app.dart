import '../Controllers/export.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Aplicativo Flutter",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Tabs("", "", ""),
    );
  }
}