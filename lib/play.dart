import 'package:logger/logger.dart';

void main() async {
  // final dio = Dio();
  // dio.options.headers = NetworkInfo.scryfallHeaders;
  // final client = ScryfallApiService(dio);
  //
  // final request = SearchRequest(
  //     query: FullTextSearchQuery(
  //         colors: [ColorIdentities.W, ColorIdentities.R],
  //         types: ['creature', 'instant']),
  //     matchAll: {
  //       'colors': true,
  //       'types': false,
  //     });
  //
  // Logger().i(request.query.getFormattedQuery());
  //
  // try {
  //   final response =
  //       await client.getSearchedCards(request.toJson());
  //
  //   Logger().i(response.data);
  // } on DioError catch (e) {
  //   final error = ScryfallError(response: e.response);
  //   Logger().e(e.response);
  // } on Exception catch (e) {
  //   Logger().e(e.toString());
  // }

  // CollectionReference user = FirebaseFirestore.instance.collection('users');
  // // CollectionReference decks = user.collection('decks');
  //
  // user.get().then((snapshot) {
  //   if (snapshot.docs.isEmpty) {
  //     Logger().i('No docs');
  //   } else {
  //     snapshot.docs.forEach((element) {
  //       Logger().i(element.data.toString());
  //     });
  //   }
  // });

  Logger().i('{1}{G}{G/W/P}{W}'.replaceAll('}', '').split('{')..removeAt(0));
}

abstract class A {
  String foo();

  String bar();
}

class B implements A {
  @override
  String bar() {
    return 'Print bar from B';
  }

  @override
  String foo() {
    return 'Print foo from B';
  }
}

class C implements A {
  @override
  String bar() {
    return 'Print bar from C';
  }

  @override
  String foo() {
    return 'Print foo from C';
  }
}

// class Bicycle {
//   Bicycle(this.cadence, this.gear);
//
//   int cadence;
//   int _speed = 0;
//   int gear;
//
//   int get speed => _speed;
//
//   // Bicycle(int cadence, int speed, int gear) : this.cadence = cadence,
//   // this.speed = speed, this.gear = gear;
//
//   @override
//   String toString() => 'Bicycle: $speed kph';
//
//   void applyBrake(int decrement) {
//     _speed -= decrement;
//   }
//
//   void speedUp(int increment) {
//     _speed += increment;
//   }
// }
//
// class Rectangle {
//   int width;
//   int height;
//   Point origin;
//
//   Rectangle({this.origin = const Point(0, 0), this.width = 0, this.height = 0});
//
//   @override
//   String toString() =>
//       'Origin: (${origin.x}, ${origin.y}), width: $width, height: $height';
// }
//
// abstract class Shape {
//   factory Shape(String type) {
//     if (type == 'circle') return Circle(2);
//     if (type == 'square') return Square(2);
//     throw 'Can\'t create $type.';
//   }
//   num get area;
// }
//
// class Circle implements Shape {
//   final num radius;
//
//   Circle(this.radius);
//
//   @override
//   num get area => pi * pow(radius, 2);
// }
//
// class Square implements Shape {
//   final num side;
//
//   Square(this.side);
//
//   @override
//   num get area => pow(side, 2);
// }
//
// // classes already define an interface, so it's necessary
// // to implement each attribute for inheritance
// class CircleMock implements Circle{
//   num area = 0;
//   num radius = 0;
// }
//
// void main() {
//   // var bike = Bicycle(2, 1);
//   // print(bike);
//   //
//   // print(Rectangle(origin: const Point(10, 20), width: 100, height: 200));
//   // print(Rectangle(origin: const Point(10, 20)));
//   // print(Rectangle(width: 100));
//   // print(Rectangle());
//
//   // final circle = Circle(2);
//   // final square = Square(2);
//   //
//   // final circle2 = shapeFactory('circle');
//   // final square2 = shapeFactory('square');
//   //
//   // final circle3 = Shape('circle');
//   // final square3 = Shape('square');
//   //
//   // print(circle3.area);
//   // print(square3.area);
//   //
//   // try {
//   //   final thing = shapeFactory('thing');
//   // } catch (exception) {
//   //   print(exception);
//   // }
//
//   var shoppingCart = ShoppingCart();
//   shoppingCart.prices = [2.0, -3.0];
// }
//
// Shape shapeFactory(String type) {
//   if (type == 'circle') return Circle(2);
//   if (type == 'square') return Square(2);
//   throw 'Can\'t create $type.';
// }
//
// class InvalidPriceException {}
//
// class ShoppingCart {
//   List<double> _prices = [];
//
//   // Add a "total" getter here:
//   double get total => _prices.fold(0, (prev, elem)=> prev + elem);
//
//   // Add a "prices" setter here:
//   set prices(List<double> prices) {
//     var invalid = prices.any((elem){
//       return elem < 0;
//     });
//     if (invalid) {
//       throw InvalidPriceException();
//     } else {
//       _prices = prices;
//     }
//   }
// }
