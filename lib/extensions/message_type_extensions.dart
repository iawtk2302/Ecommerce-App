import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/promotion.dart';

extension MessageTypeExt on MessageType {
  String toMessageTypeString() {
    switch (this) {
      case MessageType.text:
        return "text";
      case MessageType.image:
        return "image";
      case MessageType.voice:
        return "voice";
      default:
        return "text";
    }
  }
}
