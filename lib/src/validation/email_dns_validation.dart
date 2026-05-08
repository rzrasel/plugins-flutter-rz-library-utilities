import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dns_client/dns_client.dart';

class EmailDnsValidation {

  const EmailDnsValidation._();
  const EmailDnsValidation._internal();
  static const instance = EmailDnsValidation._internal();

  static final RegExp _emailPattern = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$"
  );

  static String? isWeb() {
    if (kIsWeb) {
      return null;
    }
    return 'Not running on web platform.';
  }

  static String? isNotWeb() {
    if (!kIsWeb) {
      return null;
    }
    return 'This feature is not available on web.';
  }

  static String getPlatform() {
    return kIsWeb ? 'Web' : 'Mobile/Desktop';
  }

  static String? isValidFormat(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required.';
    }
    if (!_emailPattern.hasMatch(email.trim())) {
      return 'Invalid email format.';
    }
    return null;
  }

  static Future<String?> isDomainExists(String? email) async {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required.';
    }

    if (kIsWeb) return null;

    try {
      final domain = email.trim().toLowerCase().split('@').last;
      final result = await InternetAddress.lookup(domain)
          .timeout(const Duration(seconds: 15));

      if (result.isNotEmpty) {
        return null;
      } else {
        return 'Domain does not exist.';
      }
    } catch (_) {
      return 'Domain does not exist.';
    }
  }

  static Future<String?> hasMxRecord(String? email) async {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required.';
    }

    try {
      final domain = email.trim().toLowerCase().split('@').last;
      final dns = DnsOverHttps.google();
      final records = await dns.lookupDataByRRType(domain, RRType.MX)
          .timeout(const Duration(seconds: 15));
      dns.close();

      if (records.isNotEmpty) {
        return null;
      } else {
        return 'No mail server found for this domain.';
      }
    } catch (_) {
      return 'No mail server found for this domain.';
    }
  }

  static Future<List<String>> _getMxHosts(String domain) async {
    try {
      final dns = DnsOverHttps.google();
      final records = await dns.lookupDataByRRType(domain, RRType.MX);
      dns.close();
      if (records.isEmpty) return [domain];
      // records look like "10 gmail-smtp-in.l.google.com."
      final hosts = records.map((e) {
        final parts = e.split(' ');
        return parts.last.replaceAll('.', '').trim();
      }).toList();
      return hosts.isEmpty ? [domain] : hosts;
    } catch (_) {
      return [domain];
    }
  }

  static Future<String?> isUserExistsSmtp(String? email, {String fromEmail = "no-reply@gmail.com"}) async {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required.';
    }

    // check format first - your isValidFormat now returns String?
    final formatError = isValidFormat(email);
    if (formatError != null) return formatError;

    if (kIsWeb) {
      return 'SMTP check is not available on web.';
    }

    try {
      final cleanEmail = email.trim().toLowerCase();
      final domain = cleanEmail.split('@').last;
      final fromDomain = fromEmail.trim().toLowerCase().split('@').last;
      final mxHosts = await _getMxHosts(domain);

      if (mxHosts.isEmpty) {
        return 'No mail server found for this domain.';
      }

      for (final host in mxHosts) {
        Socket? socket;
        try {
          socket = await Socket.connect(host, 25, timeout: const Duration(seconds: 10));

          Future<String> recv() async {
            final data = await socket!.first.timeout(const Duration(seconds: 5));
            return utf8.decode(data, allowMalformed: true);
          }

          void send(String cmd) => socket!.write('$cmd\r\n');

          var data = await recv();
          if (!data.startsWith('220')) {
            await socket.close();
            continue;
          }

          send('HELO $fromDomain');
          await recv();
          send('MAIL FROM: <$fromEmail>');
          await recv();
          send('RCPT TO: <$cleanEmail>');
          final response = await recv();
          final code = response.length >= 3 ? response.substring(0, 3) : '';

          send('RSET');
          await recv().catchError((_) => '');
          send('QUIT');
          await socket.close();

          if (['250', '450', '451', '452'].contains(code)) {
            return null; // valid - user exists / catch-all
          }
          if (code == '550') {
            return 'User does not exist on this mail server.';
          }
        } catch (_) {
          try { await socket?.close(); } catch (_) {}
          continue;
        }
      }
      return 'User does not exist.';
    } catch (_) {
      return 'Unable to verify user existence.';
    }
  }

  static Future<String?> isEmailReachable(String? email) async {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required.';
    }

    // 1. Format check
    final formatError = isValidFormat(email);
    if (formatError != null) return formatError;

    // 2. Domain check
    final domainError = await isDomainExists(email);
    if (domainError != null) return domainError;

    // 3. MX check
    final mxError = await hasMxRecord(email);
    if (mxError != null) return mxError;

    return null;
  }
}
/*
Usages:

// Fast - offline
Validation.email.validate("test@gmail.com");

// Email DNS - async
Validation.emailDns.isValidFormat("test@gmail.com"); // sync bool
await Validation.emailDns.isDomainExists("test@gmail.com");
await Validation.emailDns.hasMxRecord("test@gmail.com");
await Validation.emailDns.isEmailReachable("test@gmail.com");
await Validation.emailDns.isUserExistsSmtp("test@gmail.com");

// DNS checks - recommended for Flutter
bool exists = await EmailDnsValidation.isDomainExists("test@gmail.com");
bool hasMx = await EmailDnsValidation.hasMxRecord("test@gmail.com");
bool reachable = await EmailDnsValidation.isEmailReachable("test@gmail.com");

// SMTP check - will FAIL on most mobile networks, Gmail returns 250 always
bool userExists = await EmailDnsValidation.isUserExistsSmtp("test@gmail.com");
*/