import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class AuthUUCMSWebScreen extends StatefulWidget {
  const AuthUUCMSWebScreen({super.key});

  @override
  State<AuthUUCMSWebScreen> createState() => _AuthUUCMSWebScreenState();
}

class _AuthUUCMSWebScreenState extends State<AuthUUCMSWebScreen> {
  late final WebViewController controller;
  final cookieManager = WebviewCookieManager();

  @override
  void initState() {
    super.initState();
    cookieManager.clearCookies();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            if (url == 'https://uucms.karnataka.gov.in/Login/Success') {
              final cookies = await cookieManager.getCookies(url);
              _handleLoginSuccess(cookies);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://uucms.karnataka.gov.in/Login/Index'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UUCMS'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  void _handleLoginSuccess(List<Cookie?> cookies) {
    List<String> cookieParts = [];

    for (Cookie? cookie in cookies) {
      if (cookie != null) {
        String cookiePart = '${cookie.name}=${cookie.value}';
        cookieParts.add(cookiePart);
      }
    }

    String cookieString = cookieParts.join('; ');
    if (cookieString.isNotEmpty) {
      context.read<UUCMSBloc>().add(UpdateLocalCookie(cookie: cookieString));
      Navigator.pop(context);
    }
  }
}
