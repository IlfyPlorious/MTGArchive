import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:uuid/uuid.dart';

class MockScryfallCard extends Mock implements ScryfallCard {}

class MockImageUris extends Mock implements ImageUris {}

class MockCardFace extends Mock implements CardFace {}

void main() {
  late ScryfallCard sut;
  late MockImageUris mockImageUris;
  late MockCardFace mockCardFace1;
  late MockCardFace mockCardFace2;

  setUp(() {
    mockImageUris = MockImageUris();
    mockCardFace1 = MockCardFace();
    mockCardFace2 = MockCardFace();
    sut = ScryfallCard(
        imageUris: mockImageUris, cardFaces: [mockCardFace1, mockCardFace2]);
  });

  test('initial values are correct', () {
    expect(sut.id, null);
  });

  group('Testing getImageUrl method', () {
    test('uses card imageUris', () {
      when(() => mockCardFace1.imageUris).thenReturn(null);
      sut.getImageUrl();
      verify(() => mockImageUris.normal).called(1);
    });

    test('first face uses cardFaces imageUris', () {
      when(() => mockImageUris.normal).thenReturn(null);
      when(() => mockCardFace1.imageUris)
          .thenReturn(ImageUris(normal: 'fakeUrl'));
      sut.getImageUrl();
      verify(() => mockCardFace1.imageUris?.normal).called(2);
      verifyNever(() => mockImageUris.normal);
    });

    test('second face uses cardFaces imageUris', () {
      when(() => mockImageUris.normal).thenReturn(null);
      when(() => mockCardFace1.imageUris)
          .thenReturn(ImageUris(normal: 'fakeUrl'));
      when(() => mockCardFace2.imageUris)
          .thenReturn(ImageUris(normal: 'fakeUrl'));
      sut.getImageUrl(firstFace: false);
      verifyNever(() => mockImageUris.normal);
      verify(() => mockCardFace2.imageUris?.normal).called(1);
    });
  });

  test('nothing to return', () {
    when(() => mockImageUris.normal).thenReturn(null);
    when(() => mockCardFace1.imageUris).thenReturn(null);
    when(() => mockCardFace2.imageUris).thenReturn(null);
    sut.getImageUrl();
    verify(() => mockImageUris.normal).called(1);
    verify(() => mockCardFace1.imageUris?.normal).called(1);
    verifyNever(() => mockCardFace2.imageUris?.normal);
    expect(sut.getImageUrl(), null);
  });

  group('testing getId method', () {
    test('testing null id', () {
      sut.id = null;
      expect(sut.getId(), null);
    });

    test('testing some id', () {
      sut.id = const Uuid().v4();
      expect(sut.getId().runtimeType, String);
    });
  });

  group('testing getName method', () {
    test('testing null name', () {
      sut.name = null;
      expect(sut.getName(), null);
    });

    test('testing some name', () {
      sut.name = 'Card name';
      expect(sut.getName().runtimeType, String);
    });
  });

  group('testing getManaCost method', () {
    test('manaCost for single faced card', () {
      when(() => mockCardFace1.manaCost).thenReturn(null);
      sut.getManaCost();
      verify(() => mockCardFace1.manaCost).called(1);
      expect(sut.getManaCost(), null);
      sut.manaCost = '{1B}';
      expect(sut.getManaCost()?.contains('{'), true);
      expect(sut.getManaCost()?.contains('}'), true);
    });

    test('manaCost for multi-faced faced card', () {
      when(() => mockCardFace1.manaCost).thenReturn('{1B}');
      sut.getManaCost();
      verify(() => mockCardFace1.manaCost).called(2);
      expect(sut.getManaCost().runtimeType, String);
      expect(sut.getManaCost()?.contains('{'), true);
      expect(sut.getManaCost()?.contains('}'), true);
    });
  });
}
