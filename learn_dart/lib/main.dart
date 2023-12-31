// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

void test() {
  debugPrint('--test--');
  final f = 0;
  const c = 0;
  var v = 0;
  var l = [0, 1, 2];
  var sInt = {0, 1, 2};
  var sObj = {0, 1, 2, 'a'};
  var m = {'a': 0, 'b': 'w'};
  m['c'] = 'q';
  debugPrint('$f, $c, $v, $l, $sInt, $sObj, $m');

  String? s = null;
  s = 's';
  debugPrint(s);

  List<int?>? ll = [0, 1, 2, null];
  ll = null;
  print(ll);

  // cherry-picking non-null values
  var z = null;
  var x = null;
  var b = 2;
  print(z ?? x ?? b);
}

void test2(String? str1, String? str2, String? str3) {
  debugPrint('--test2--');
  String? str = str1;
  str ??= str2;
  str ??= str3;
  debugPrint(str);
}

void test3(List<String>? l) {
  debugPrint('--test3--');
  var num = 0;
  if (l != null) {
    num = l.length;
  }
  debugPrint('num is $num');

  l?.add('value1');
  l?.add('value2');
  var len = l?.length ?? 0;
  debugPrint('len is $len');
}

enum E { a, b, c }

void testEnum() {
  debugPrint('--testEnum--');
  print(E.a);
  print(E.a.name);
  print(E.a.index);
  print(E.a.hashCode);
}

abstract class Person {
  final String name;

  Person(this.name);

  void run() {
    debugPrint('running');
  }

  void breath() {
    debugPrint('breathing');
  }
}

class GoodPerson extends Person {
  GoodPerson() : super('goodname');
}

void testClass() {
  debugPrint('--testClass--');
  // final p = Person('foo');
  // p.run();
  // p.breath();
  // debugPrint(p.name);

  final gp = GoodPerson();
  debugPrint(gp.name);
  gp.run();
  gp.breath();
}

// class Cat extends Object {
class Cat {
  final String firstName;
  final String lastName;
  Cat(this.firstName, this.lastName);
  factory Cat.fluffBall() {
    return Cat('FluffBall', 'lastBall');
  }

  @override
  bool operator ==(covariant Cat other) => other.firstName == firstName;

  @override
  int get hashCode => firstName.hashCode;
  // int get hashCode => super.hashCode;
}

extension Run on Cat {
  void run() {
    debugPrint('Cat $firstName is running!');
  }
}

extension FullName on Cat {
  String get fullName => '$firstName $lastName';
}

void testFactory() {
  debugPrint('--testFactory--');
  final fb = Cat.fluffBall();
  debugPrint(fb.firstName);
}

void testCustomOperators() {
  debugPrint('--testCustomOperators--');
  final cat1 = Cat('newCat', 'lastName');
  final cat2 = Cat('newCat', 'lastName');
  if (cat1 == cat2) {
    debugPrint('cat1==cat2');
  } else {
    debugPrint('cat1!=cat2');
  }
}

void testExtension() {
  debugPrint('--testExtension--');
  final c = Cat('catName', 'lastName');
  c.run();
  debugPrint(c.fullName);
}

Future<int> testFuture(int n) {
  debugPrint('--testFuture--');
  return Future.delayed(const Duration(seconds: 3), () => n * 2);
}

void testAsync() async {
  debugPrint('--testAsync--');
  print(await testFuture(20));
}

Stream<String> getStream() {
  return Stream.value('Foo');
}

Stream<String> getPeriodicStream() {
  return Stream.periodic(const Duration(seconds: 1), (value) {
    return 'Bar';
  });
}

void testStream() async {
  debugPrint('--testStream--');
  await for (final result in getStream()) {
    print(result);
  }
}

void testPeriodicStream() async {
  debugPrint('--testPeriodicStream--');
  await for (final result in getPeriodicStream()) {
    print(result);
  }
}

Iterable<int> myGenegator() sync* {
  yield 1;
  yield 2;
  yield 3;
}

void testGenerator() {
  debugPrint('--testGenerator--');
  print(myGenegator());

  for (final value in myGenegator()) {
    print(value);
  }
}

class MyGeneric<A, B> {
  final A valueA;
  final B valueB;
  MyGeneric(this.valueA, this.valueB);
}

void testMyGeneric() {
  debugPrint('--testGeneric--');
  final p1 = MyGeneric('name', 1);
  print(p1);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint('--start--');
    test();
    test2(null, 'bar', 'baz');
    test3(null);
    test3([]);
    testEnum();
    testClass();
    testFactory();
    testCustomOperators();
    testExtension();
    // var x = testFuture(2);
    testAsync();
    testStream();
    testPeriodicStream();
    testGenerator();
    testMyGeneric();
    debugPrint('--end--');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
