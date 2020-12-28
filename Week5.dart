import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class Person{
  String name;
  String age;
  Gender gender;
  String birthDay;

  Person(this.name, this.age, this.gender, this.birthDay);

  String getGender(){
    if(gender == Gender.WOMEN) return '여자';
    else return '남자';
  }

}

enum Gender { MAN, WOMEN }
Gender _gender = Gender.MAN;
final _valueList = ['15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25'];
var _selectedValue = '15';

class SecondPage extends StatelessWidget{
  final Person person;
  SecondPage({@required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 정보 확인'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('아래의 내용이 맞으면 확인 버튼을 눌러주세요.',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                    SizedBox(
                      height: 40,
                    ),
                    Text('이름: ' + person.name,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),),
                    Text('나이: ' + person.age,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),),
                    Text('생년월일: ' + person.birthDay,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),),
                    Text('성별: ' + person.getGender(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      child: Text('확인'),
                      onPressed: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('가입 완료!'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(person.name + ' 님, 가입을 축하드립니다!'),
                                    Text('(OK를 눌러 창을 닫습니다)'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          }),
                    )
                  ])))

    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }*/

  final myController = TextEditingController();
  DateTime _selectedTime;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('회원가입 페이지'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '성함을 여기에 입력하세요',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('나이를 선택해주세요.',
                        style: TextStyle(
                          fontSize: 15,
                        )
                      ),
                      DropdownButton(
                          value: _selectedValue,
                          items: _valueList.map(
                                (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          }
                      ),
                      RaisedButton(
                        onPressed: (){
                          Future<DateTime> selectedDate = showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2030),
                            builder: (BuildContext context, Widget child){
                              return Theme(
                                data: ThemeData.dark(),
                                child: child,
                              );
                            },
                          );

                          selectedDate.then((dateTime){
                            setState(() {
                              _selectedTime = dateTime;
                            });
                          });
                        },
                        child: Text('생년월일'),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Text('성별',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      RadioListTile(
                          title: Text('남자'),
                          value: Gender.MAN,
                          groupValue: _gender,
                          onChanged: (value){
                            setState((){
                              _gender = value;
                            });
                          }),
                      RadioListTile(
                          title: Text('여자'),
                          value: Gender.WOMEN,
                          groupValue: _gender,
                          onChanged: (value){
                            setState(() {
                              _gender = value;
                            });
                          }),
                      RaisedButton(
                        child: Text('회원 가입하기'),
                        onPressed: () async {
                          //'회원가입 정보 확인'페이지에 객체로 정보 전달
                          final person = Person(myController.text, _selectedValue, _gender, '$_selectedTime');
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondPage(person: person)),
                          );
                        },
                      ),
                    ])))
    );
  }
}
