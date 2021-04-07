import 'dart:convert';
import 'dart:io';

import 'package:dart_ast_support/select_folder_screen.dart';

Future startServer() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    if (request.uri.path == '/files') {
      request.response.headers.add('content-type', 'application/json; charset=utf-8');
      request.response.write(jsonEncode(items));
      await request.response.close();
      return;
    }

    request.response.write('Необходимо выбрать папку с файлами. После этого выполнить GET запрос /files');

    await request.response.close();
  }
}
