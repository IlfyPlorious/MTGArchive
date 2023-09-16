import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/network/responsemodels/firebase/deck_card.dart';
import 'package:playground/network/responsemodels/friends/chat/message.dart';
import 'package:playground/network/responsemodels/friends/friend_request.dart';
import 'package:playground/network/responsemodels/friends/friendship.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/utils/constants.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  FirestoreService({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  Future<void> addUser(User? user) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    await users.doc(user?.uid).set(
          FirebaseUser(
                  email: user?.email,
                  name: user?.displayName,
                  imageUrl: user?.photoURL,
                  id: user?.uid)
              .toJson(),
          SetOptions(merge: true),
        );
  }

  Future<List<Deck>> getDecksByUserId(String userId) async {
    DocumentReference user = firebaseFirestore.collection('users').doc(userId);
    CollectionReference decks = user.collection('decks');

    final decksList = <Deck>[];
    final decksSnapshot = await decks.get();

    if (decksSnapshot.docs.isNotEmpty) {
      for (final deck in decksSnapshot.docs) {
        final deckData = deck.data() as Map<String, dynamic>;
        decksList.add(Deck.fromJson(deckData)..id = deck.id);
      }
    }
    return decksList;
  }

  Future<String> addDeckForUser(Deck deck, String userId) async {
    CollectionReference userDecks =
        firebaseFirestore.collection('users').doc(userId).collection('decks');

    String id = emptyString;
    await userDecks.add(deck.toJson()).then((value) => id = value.id);

    DocumentReference deckDoc = userDecks.doc(id);

    await deckDoc.update({'id': id});

    return id;
  }

  Future<Deck> getDeckById(String deckId, String userId) async {
    DocumentReference user = firebaseFirestore.collection('users').doc(userId);
    CollectionReference decks = user.collection('decks');
    DocumentReference deckRef = decks.doc(deckId);
    Deck? deck;
    final deckSnapshot = await deckRef.get();

    if (deckSnapshot.exists) {
      final deckData = deckSnapshot.data() as Map<String, dynamic>;
      deck = Deck.fromJson(deckData);
    }

    if (deck == null) {
      throw Exception('Issue getting deck from archives');
    } else {
      return deck;
    }
  }

  Future<void> addCardToDeck(ScryfallCard card, Deck deck, int count) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);

    final categoryReference = deckReference.collection(card.cardType!);
    final cardData = await getDeckCardById(deck, card.getId() ?? emptyString);
    final cardNewCount = (cardData?.count ?? 0) + count;
    await categoryReference.doc(card.getId()).set({
      'name': card.name,
      'color_identity': card.colorIdentity,
      'artUrl': card.imageUris?.artCrop,
      'count': cardNewCount,
      'price': card.prices?.eur,
    });

    await updateDeckImageUrl(card, deck);
    await updateDeckColors(card.colorIdentity?.join('') ?? emptyString, deck);
  }

  Future<Map<String, List<DeckCard>>> getCardsForDeck(Deck deck) async {
    final cards = <String, List<DeckCard>>{};
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);

    for (var type in BaseCardTypes.values) {
      final typeCollection = deckReference.collection(type.name);
      final typeCollectionSnapshot = await typeCollection.get();
      final cardsForType = typeCollectionSnapshot.docs.map((docSnapshot) {
        final cardData = docSnapshot.data();
        return DeckCard.fromJson(cardData)
          ..id = docSnapshot.id
          ..imageUris = ImageUris(artCrop: cardData['artUrl'])
          ..prices = Prices(eur: cardData['price']);
      }).toList();

      cards[type.name] = cardsForType;
    }

    return cards;
  }

  Future<DeckCard?> getDeckCardById(Deck deck, String id) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);
    for (var type in BaseCardTypes.values) {
      final typeCollection = deckReference.collection(type.name);
      final cardSnapshot = await typeCollection.doc(id).get();
      if (cardSnapshot.exists) {
        final cardData = cardSnapshot.data() as Map<String, dynamic>;
        return DeckCard.fromJson(cardData)..id = id;
      }
    }

    return null;
  }

  Future<void> removeCardFromDeck(
      BaseCardTypes type, DeckCard card, Deck deck, int count) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);
    final typeCollection = deckReference.collection(type.name);
    final cardCount = (card.count ?? 1) - count;
    final deckSnapshot = await deckReference.get();
    final deckData = Deck.fromJson(deckSnapshot.data() as Map<String, dynamic>);

    if (cardCount <= 0) {
      final updatedDeck = deckData
        ..backgroundUrl?.remove(card.imageUris?.artCrop)
        ..colors?.remove(card.colorIdentity?.join(''));
      await deckReference.update(updatedDeck.toJson());
      await typeCollection.doc(card.getId()).delete();
    } else {
      await typeCollection.doc(card.getId()).update({'count': cardCount});
    }
  }

  Future<void> updateDeckImageUrl(ScryfallCard card, Deck deck) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);

    final deckSnapshot = await deckReference.get();
    final deckData = deckSnapshot.data() as Map<String, dynamic>;
    final readDeck = Deck.fromJson(deckData);

    if (readDeck.backgroundUrl == null) {
      await deckReference.update({
        'background_url': [card.imageUris?.artCrop]
      });
    } else {
      if (readDeck.backgroundUrl?.contains(card.imageUris?.artCrop) == false) {
        await deckReference.update({
          'background_url': readDeck.backgroundUrl
            ?..add(card.imageUris?.artCrop)
        });
      }
    }
  }

  Future<void> updateDeckColors(String colors, Deck deck) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);

    final deckSnapshot = await deckReference.get();
    final deckData = deckSnapshot.data() as Map<String, dynamic>;
    final readDeck = Deck.fromJson(deckData);

    if (readDeck.colors == null) {
      await deckReference.update({
        'colors': [colors]
      });
    } else {
      await deckReference.update({'colors': readDeck.colors?..add(colors)});
    }
  }

  Future<void> deleteDeck(Deck deck) async {
    final deckReference = firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('decks')
        .doc(deck.id);

    await deckReference.delete();
  }

  Future<List<FirebaseUser>> getAllUsers() async {
    final userCollectionReference = firebaseFirestore.collection('users');

    final usersList = <FirebaseUser>[];
    final usersSnapshot = await userCollectionReference.get();

    if (usersSnapshot.docs.isNotEmpty) {
      for (final user in usersSnapshot.docs) {
        final userData = user.data();
        usersList.add(FirebaseUser.fromJson(userData));
      }
    }
    return usersList;
  }

  Future<void> sendFriendRequest(FirebaseFriendRequest friendRequest) async {
    final friendRequestsCollection =
        firebaseFirestore.collection('friend_requests');

    await friendRequestsCollection
        .doc(friendRequest.id)
        .set(friendRequest.toJson());
  }

  Future<void> cancelFriendRequest(FirebaseFriendRequest friendRequest) async {
    final friendRequestsCollection =
        firebaseFirestore.collection('friend_requests');

    final friendRequestsSnapshot = await friendRequestsCollection
        .where('from_user', isEqualTo: friendRequest.fromUser)
        .where('to_user', isEqualTo: friendRequest.toUser)
        .get();

    for (final friendRequest in friendRequestsSnapshot.docs) {
      await friendRequestsCollection.doc(friendRequest.id).delete();
    }
  }

  Future<List<FirebaseFriendRequest>> getSentFriendRequestsForUser(
      String uid) async {
    final friendRequestsCollection =
        firebaseFirestore.collection('friend_requests');

    final friendRequests = <FirebaseFriendRequest>[];

    final friendRequestsSnapshot =
        await friendRequestsCollection.where('from_user', isEqualTo: uid).get();

    for (final friendRequest in friendRequestsSnapshot.docs) {
      final data = friendRequest.data();
      friendRequests.add(FirebaseFriendRequest.fromJson(data));
    }

    return friendRequests;
  }

  Future<FirebaseUser> getUserData(String userUID) async {
    final userCollectionRef = firebaseFirestore.collection('users');
    final userSnapshot = await userCollectionRef.doc(userUID).get();
    final userData = userSnapshot.data();
    return FirebaseUser.fromJson(userData as Map<String, dynamic>);
  }

  Future<List<FirebaseFriendRequest>> getReceivedFriendRequestsForUser(
      String userUID) async {
    final friendRequestsCollection =
        firebaseFirestore.collection('friend_requests');

    final friendRequests = <FirebaseFriendRequest>[];

    final friendRequestsSnapshot = await friendRequestsCollection
        .where('to_user', isEqualTo: userUID)
        .get();

    for (final friendRequest in friendRequestsSnapshot.docs) {
      final data = friendRequest.data();
      friendRequests.add(FirebaseFriendRequest.fromJson(data));
    }

    return friendRequests;
  }

  Future<void> createFriendship(FirebaseFriendRequest friendRequest) async {
    final friendshipsCollection = firebaseFirestore.collection('friendships');

    final id = const Uuid().v4();
    final friendship = FirebaseFriendship(
        idUser1: friendRequest.fromUser,
        idUser2: friendRequest.toUser,
        id: id,
        startDate: DateTime.now().toString());

    await friendshipsCollection.doc(friendship.id).set(friendship.toJson());
  }

  Future<void> acceptFriendRequest(FirebaseFriendRequest friendRequest) async {
    await createFriendship(friendRequest);
    await cancelFriendRequest(friendRequest);
    await cancelFriendRequest(FirebaseFriendRequest(
        toUser: friendRequest.fromUser, fromUser: friendRequest.toUser));
  }

  Future<List<FirebaseUser>> getFriendsListForUser(String userId) async {
    final friendshipsCollection = firebaseFirestore.collection('friendships');

    final friendList = <FirebaseUser>[];

    final friendshipsSnapshot1 =
        await friendshipsCollection.where('id_user_1', isEqualTo: userId).get();

    final friendshipsSnapshot2 =
        await friendshipsCollection.where('id_user_2', isEqualTo: userId).get();

    for (final friendshipSnapshot in friendshipsSnapshot1.docs) {
      final data = friendshipSnapshot.data();
      final friendship = FirebaseFriendship.fromJson(data);

      final friendUser = await getUserData(friendship.idUser2 ?? emptyString);

      friendList.add(friendUser);
    }

    for (final friendshipSnapshot in friendshipsSnapshot2.docs) {
      final data = friendshipSnapshot.data();
      final friendship = FirebaseFriendship.fromJson(data);

      final friendUser = await getUserData(friendship.idUser1 ?? emptyString);
      friendList.add(friendUser);
    }

    return friendList;
  }

  Future<void> removeFriendship(FirebaseFriendship firebaseFriendship) async {
    final friendshipsCollection = firebaseFirestore.collection('friendships');

    final friendshipsSnapshot1 = await friendshipsCollection
        .where('id_user_1', isEqualTo: firebaseFriendship.idUser1)
        .where('id_user_2', isEqualTo: firebaseFriendship.idUser2)
        .get();

    final friendshipsSnapshot2 = await friendshipsCollection
        .where('id_user_2', isEqualTo: firebaseFriendship.idUser1)
        .where('id_user_1', isEqualTo: firebaseFriendship.idUser2)
        .get();

    for (final friendshipSnapshot in friendshipsSnapshot1.docs) {
      final data = friendshipSnapshot.data();
      final friendship = FirebaseFriendship.fromJson(data);

      await friendshipsCollection.doc(friendship.id).delete();
    }

    for (final friendshipSnapshot in friendshipsSnapshot2.docs) {
      final data = friendshipSnapshot.data();
      final friendship = FirebaseFriendship.fromJson(data);

      await friendshipsCollection.doc(friendship.id).delete();
    }
  }

  Future<FirebaseFriendship> getFriendshipFor(
      String userId, String friendId) async {
    final friendshipsCollection = firebaseFirestore.collection('friendships');

    final friendshipsSnapshot1 = await friendshipsCollection
        .where('id_user_1', isEqualTo: userId)
        .where('id_user_2', isEqualTo: friendId)
        .get();

    final friendshipsSnapshot2 = await friendshipsCollection
        .where('id_user_2', isEqualTo: userId)
        .where('id_user_1', isEqualTo: friendId)
        .get();

    if (friendshipsSnapshot1.docs.isNotEmpty) {
      final data = friendshipsSnapshot1.docs.first.data();
      final friendship = FirebaseFriendship.fromJson(data);

      return friendship;
    }

    if (friendshipsSnapshot2.docs.isNotEmpty) {
      final data = friendshipsSnapshot2.docs.first.data();
      final friendship = FirebaseFriendship.fromJson(data);

      return friendship;
    }

    return const FirebaseFriendship();
  }

  Future<void> addMessageToDatabase(
      FirebaseMessage firebaseMessage, FirebaseFriendship friendship) async {
    final friendshipReference =
        firebaseFirestore.collection('friendships').doc(friendship.id);

    final chatReference = friendshipReference.collection('chat');
    await chatReference.add(firebaseMessage.toJson());
  }

  Future<List<FirebaseMessage>> getChatMessages(
      FirebaseFriendship friendship) async {
    final chatReference = firebaseFirestore
        .collection('friendships')
        .doc(friendship.id)
        .collection('chat');

    final chatSnapshot = await chatReference.orderBy('timestamp').get();
    final chatDocs = chatSnapshot.docs;

    return chatDocs.map((doc) => FirebaseMessage.fromJson(doc.data())).toList();
  }
}
