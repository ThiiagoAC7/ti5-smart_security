import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

const apiUrl = "10.0.2.2:5000";
const deubom = "success";

Future loginValidate(userName, password) async {
  var client = http.Client();
  try {
    var url = Uri.http(apiUrl, "/api/signin");
    // var key = await getApiKeyFromDevice();
    var key = await getApiKeyFromDB(userName);
    saveApiKey(key);
    dev.log("login - key", error: key);
    var response = await client.post(
      url,
      body: jsonEncode({
        "user_name": userName,
        "password": password,
      }),
      headers: {
        "Content-Type": "application/json",
        "Authorization": key,
      },
      encoding: Utf8Codec(),
    );
    Map login = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (login['status'] == 'success') {
        dev.log("login - id", error: login['data']['id']);
        saveUserId(login['data']['id']);
        return Future.value(login['status']);
      }
    } else {
      return Future.value(login['message']);
    }
  } finally {
    client.close();
  }
  return Future.value(false);
}

Future registerValidate(userName, password) async {
  var client = http.Client();
  try {
    var url = Uri.http(apiUrl, "/api/register");
    var response = await client.post(
      url,
      body: jsonEncode({
        "user_name": userName,
        "password": password,
      }),
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Utf8Codec(),
    );
    Map login = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (login['status'] == 'success') {
        dev.log('register', error: login['data']['api_key']);
        saveApiKey(login['data']['api_key']);
        return Future.value(login['status']);
      }
    } else {
      return Future.value(login["message"]);
    }
  } finally {
    client.close();
  }
  return Future.value(false);
}

Future<String> getApiKeyFromDB(userName) async {
  dev.log("getApiKeyFromDB - inicio");
  var client = http.Client();
  try {
    var url = Uri.http(apiUrl, "/api/api_key");
    var response = await client.get(
      url,
      headers: {
        "user_name": userName,
      },
    );
    if (response.statusCode == 200) {
      Map login = jsonDecode(response.body);
      if (login['status'] == 'success') {
        dev.log("getApiKeyFromDb - success ", error: login["api_key"]);
        return Future<String>.value(login["api_key"]);
      }
    }
  } finally {
    dev.log("getApiKeyFromDB - fim");
    client.close();
  }
  return Future<String>.value('erro');
}

Future<List> getActivityLog() async {
  var client = http.Client();
  try {
    var url = Uri.http(apiUrl, "/api/log_activity");
    var key = await getApiKeyFromDevice();
    dev.log("getActivityLog - api key", error: key);
    int id = await getUserIdFromDevice();
    dev.log("getActivityLog - id", error: id);
    var response = await client.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": key,
        "user_id": id.toString(),
      },
    );
    Map log = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (log['status'] == 'success') {
        return Future<List>.value(log["data"]);
      }
    } else {
      return Future<List>.value(log["message"]);
    }
  } finally {
    client.close();
  }
  return [];
}

saveApiKey(String apikey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('API_Token', apikey);
}

saveUserId(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_id', id);
}

Future getUserIdFromDevice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
}

Future getApiKeyFromDevice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("API_Token");
}
