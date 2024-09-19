import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '           Geschwindigkeitsvergleich'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _sortedNumbers = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

/*growableList.sort((a, b) => a.compareTo(b));
print(growableList); // [A, AB, F, F]
To shuffle the elements of this list randomly, use [shuffle].
*/
  List<int> generated() {
    final random = Random();
    final numbers = List.generate(10000, (index) => index + 1);
    numbers.shuffle(random);
    return numbers;
  }

// Bubble Sort
  List<int> bubbleSort(List<int> list) {
    for (int i = 0; i < list.length - 1; i++) {
      for (int j = 0; j < list.length - i - 1; j++) {
        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
    return list;
  }

  // Quick Sort
  List<int> quickSort(List<int> list) {
    if (list.length <= 1) return list;
    int pivot = list[list.length ~/ 2];
    List<int> less = list.where((element) => element < pivot).toList();
    List<int> equal = list.where((element) => element == pivot).toList();
    List<int> greater = list.where((element) => element > pivot).toList();
    return quickSort(less) + equal + quickSort(greater);
  }

// Merge Sort
  List<int> mergeSort(List<int> list) {
    if (list.length <= 1) return list;
    int mid = list.length ~/ 2;
    List<int> left = mergeSort(list.sublist(0, mid));
    List<int> right = mergeSort(list.sublist(mid));
    return merge(left, right);
  }

  List<int> merge(List<int> left, List<int> right) {
    List<int> result = [];
    int i = 0, j = 0;
    while (i < left.length && j < right.length) {
      if (left[i] < right[j]) {
        result.add(left[i]);
        i++;
      } else {
        result.add(right[j]);
        j++;
      }
    }
    result.addAll(left.sublist(i));
    result.addAll(right.sublist(j));
    return result;
  }

  void _sortWithBubbleSort() {
    setState(() {
      _sortedNumbers = bubbleSort(generated());
    });
  }

  void _sortWithQuickSort() {
    setState(() {
      _sortedNumbers = quickSort(generated());
    });
  }

  void _sortWithMergeSort() {
    setState(() {
      _sortedNumbers = mergeSort(generated());
    });
  }

  @override
  Widget build(BuildContext context) {
    final randomNumbers = generated();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  color: Colors.grey.shade300,
                  child: Text(
                    randomNumbers.join(', '),
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.yellow,
                  iconSize: 78,
                  onPressed: _sortWithQuickSort,
                  icon: const Icon(Icons.airplanemode_active),
                ),
                IconButton(
                  color: Colors.blue,
                  iconSize: 58,
                  onPressed: _sortWithMergeSort,
                  icon: const Icon(Icons.airplanemode_active),
                ),
                IconButton(
                  color: Colors.red,
                  iconSize: 38,
                  onPressed: _sortWithBubbleSort,
                  icon: const Icon(Icons.airplanemode_active),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  color: Colors.grey.shade300,
                  child: Text(
                    _sortedNumbers.join(', '),
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
