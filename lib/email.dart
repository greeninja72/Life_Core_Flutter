import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> emailSend() async {
  final Email email = Email(
    body: 'Test Message',
    subject: 'Life Core',
    recipients: ['sh183694@gmail.com'],
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    error.toString();
  }
}
