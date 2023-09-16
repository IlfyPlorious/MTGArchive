import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/apiservice/firestore_service.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/network/responsemodels/firebase/deck_card.dart';
import 'package:playground/network/responsemodels/friends/chat/message.dart';
import 'package:playground/network/responsemodels/friends/friend_request.dart';
import 'package:playground/network/responsemodels/friends/friendship.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/network/responsemodels/user.dart';

abstract class FirestoreServiceRepository {
  Future<String> addDeckForUser(Deck deck, String userId);

  Future<List<Deck>> getDecksByUserId(String userId);

  Future<void> addUser(User? user);

  Future<Deck> getDeckById(String deckId, String userId);

  Future<void> addCardToDeck({required ScryfallCard card, required Deck deck, required int count});

  Future<Map<String, List<DeckCard>>> getCardsForDeck({required Deck deck});

  Future<void> removeCardsFromDeck(
      BaseCardTypes category, DeckCard card, Deck deck, int count);

  Future<void> updateDeckImageUrl(
      {required ScryfallCard card, required Deck deck});

  Future<void> updateDeckColors(String colors, Deck deck);

  Future<void> deleteDeck(Deck deck);

  Future<List<FirebaseUser>> getAllUsers();

  Future<void> sendFriendRequest(FirebaseFriendRequest friendRequest);

  Future<void> cancelFriendRequest(FirebaseFriendRequest firebaseFriendRequest);

  Future<List<FirebaseFriendRequest>> getSentFriendRequestsForUser(String uid);

  Future<FirebaseUser> getUserData(String userUID);

  Future<List<FirebaseFriendRequest>> getReceivedFriendRequestsForUser(
      String userUID);

  Future<void> acceptFriendRequest(FirebaseFriendRequest receivedFriendRequest);

  Future<List<FirebaseUser>> getFriendListForUser(String userId);

  Future<void> removeFriendship(FirebaseFriendship firebaseFriendship);

  Future<FirebaseFriendship> getFriendshipFor(String userId, String friendId);

  Future<void> addMessageToDatabase(
      FirebaseMessage firebaseMessage, FirebaseFriendship friendship);

  Future<List<FirebaseMessage>> getChatMessages(FirebaseFriendship friendship);
}

class FirestoreServiceRepositoryImpl implements FirestoreServiceRepository {
  FirestoreServiceRepositoryImpl({required this.client});

  FirestoreService client;

  @override
  Future<String> addDeckForUser(Deck deck, String userId) async {
    try {
      return await client.addDeckForUser(deck, userId);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<Deck>> getDecksByUserId(String userId) async {
    try {
      return await client.getDecksByUserId(userId);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> addUser(User? user) async {
    try {
      await client.addUser(user);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<Deck> getDeckById(String deckId, String userId) async {
    try {
      return await client.getDeckById(deckId, userId);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> addCardToDeck(
      {required ScryfallCard card, required Deck deck, required int count}) async {
    try {
      await client.addCardToDeck(card, deck, count);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<Map<String, List<DeckCard>>> getCardsForDeck(
      {required Deck deck}) async {
    try {
      return await client.getCardsForDeck(deck);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> removeCardsFromDeck(
      BaseCardTypes category, DeckCard card, Deck deck, int count) async {
    try {
      await client.removeCardFromDeck(category, card, deck, count);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> updateDeckImageUrl(
      {required ScryfallCard card, required Deck deck}) async {
    try {
      await client.updateDeckImageUrl(card, deck);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> updateDeckColors(String colors, Deck deck) async {
    try {
      await client.updateDeckColors(colors, deck);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> deleteDeck(Deck deck) async {
    try {
      await client.deleteDeck(deck);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<FirebaseUser>> getAllUsers() async {
    try {
      return await client.getAllUsers();
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> sendFriendRequest(FirebaseFriendRequest friendRequest) async {
    try {
      await client.sendFriendRequest(friendRequest);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> cancelFriendRequest(FirebaseFriendRequest friendRequest) async {
    try {
      await client.cancelFriendRequest(friendRequest);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<FirebaseFriendRequest>> getSentFriendRequestsForUser(
      String uid) async {
    try {
      return await client.getSentFriendRequestsForUser(uid);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<FirebaseUser> getUserData(String userUID) async {
    try {
      return await client.getUserData(userUID);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<FirebaseFriendRequest>> getReceivedFriendRequestsForUser(
      String userUID) async {
    try {
      return await client.getReceivedFriendRequestsForUser(userUID);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> acceptFriendRequest(
      FirebaseFriendRequest receivedFriendRequest) async {
    try {
      await client.acceptFriendRequest(receivedFriendRequest);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<FirebaseUser>> getFriendListForUser(String userId) async {
    try {
      return await client.getFriendsListForUser(userId);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> removeFriendship(FirebaseFriendship firebaseFriendship) async {
    try {
      await client.removeFriendship(firebaseFriendship);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<FirebaseFriendship> getFriendshipFor(
      String userId, String friendId) async {
    try {
      return await client.getFriendshipFor(userId, friendId);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<void> addMessageToDatabase(
      FirebaseMessage firebaseMessage, FirebaseFriendship friendship) async {
    try {
      await client.addMessageToDatabase(firebaseMessage, friendship);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }

  @override
  Future<List<FirebaseMessage>> getChatMessages(
      FirebaseFriendship friendship) async {
    try {
      return await client.getChatMessages(friendship);
    } on Exception catch (err) {
      Logger().e(err);
      throw Exception(err);
    }
  }
}
