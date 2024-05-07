import 'package:image_picker/image_picker.dart';

class SendMessageRequest {
  int receiverId;
  String title;
  String? content;
  XFile? image;

  SendMessageRequest({
    required this.receiverId,
    required this.title,
    this.content,
    this.image,
  });
}

class SendMessage {
  int receiverId;
  String title;
  String? content;
  XFile? image;
  bool hasImage;

  SendMessage({
    required this.receiverId,
    required this.title,
    this.content,
    this.image,
    this.hasImage = false,
  });
}

extension SendMessageToSendMessageRequest on SendMessage {
  SendMessageRequest toSendMessageRequest() {
    return SendMessageRequest(
      receiverId: receiverId,
      title: title,
      content: content,
      image: image
    );
  }
}
