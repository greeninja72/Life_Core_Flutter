import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> emailSend() async {
  final Email email = Email(
    body: '필터교체 요청드립니다.\n\n' +
        '-년 : \n' +
        '-월 : \n' +
        '-일 : \n' +
        '-시간 : \n\n' +
        '-요청자 연락처 : \n' +
        '-주소 : \n',
    subject: '필터교체 요청드립니다.',
    recipients: ['lifecore0683@naver.com'],
  );

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    error.toString();
  }
}
