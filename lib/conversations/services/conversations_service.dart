import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level_up_coach/conversations/models/conversation.dart';

class ConversationsService {
  ConversationsService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // final List<Conversation> conversations = [
  //   Conversation(
  //     name: 'John Doe',
  //     clientId: '1',
  //     lastMessage: 'Hey, how are you doing?',
  //     avatarUrl: 'https://example.com/avatar1.jpg',
  //     time: '10:30 AM',
  //     isRead: false,
  //     unreadCount: 3,
  //   ),
  //   Conversation(
  //     name: 'Jane Smith',
  //     clientId: '2',
  //     lastMessage: 'Meeting at 2pm tomorrow',
  //     avatarUrl: 'https://example.com/avatar2.jpg',
  //     time: 'Yesterday',
  //     isRead: true,
  //     unreadCount: 0,
  //   ),
  //   Conversation(
  //     name: 'Team Flutter',
  //     clientId: '3',
  //     lastMessage: 'Alice: I fixed the bug!',
  //     avatarUrl: 'https://example.com/avatar3.jpg',
  //     time: '2 days ago',
  //     isRead: false,
  //     unreadCount: 1,
  //   ),
  //   Conversation(
  //     name: 'Mom',
  //     clientId: '4',
  //     lastMessage: 'Call me when you get home',
  //     avatarUrl: 'https://example.com/avatar4.jpg',
  //     time: '1 hour ago',
  //     isRead: true,
  //     unreadCount: 0,
  //   ),
  // ];

  Future<List<Conversation>> retrieveConversations() async {
    // An async function to retrieve the profile data, called for each clientId
    Future<Conversation> retrieveConversationsData(String id) async {
      final profileDocSnapshot =
          await _firestore.collection('profiles').doc(id).get();
      return Conversation.fromJsonWithId(
        id: profileDocSnapshot.id,
        json: profileDocSnapshot.data() ?? {},
      );
    }

    final QuerySnapshot<Map<String, Object?>> querySnapshot =
        await _firestore.collection('conversations').get();

    Iterable<String> conversationIds = querySnapshot.docs.map<String>(
      (docSnapshot) => docSnapshot.id,
    );

    var futures = <Future<Conversation>>[];
    for (final id in conversationIds) {
      futures.add(retrieveConversationsData(id));
    }
    List<Conversation> conversations = await Future.wait(futures);

    return conversations;
  }
}
