import 'package:flutter/foundation.dart';

class LogWriter {
  static const String FULL_CLASS_NAME = 'LogWriter';
  static const String CLASS_NAME = 'LogWriter';
  static const String DEBUG_PREFIX = "DEBUG_LOG_WRITER_PRINT: ";
  static List<String>? stackTraceLines;

  static void log(String? message, {bool isDebug = true}) {
    final logCaller = LogWriter()._logCaller();
    if(logCaller != null) {
      message = "$message $logCaller";
    }
    debugPrint("📍 DEBUG_LOG_WRITER_PRINT: $message");
    //final lines = StackTrace.current.toString().split('\n');

    /*for (final line in traceLines!) {
      if (line.contains('package:')) {
        debugPrint(line);
      }
    }*/
    /*debugPrint(caller.runtimeType.toString());

    final lines = StackTrace.current.toString();
    debugPrint("----PRINT----");
    debugPrint(lines);
    debugPrint("----PRINT----");*/
  }

  String? _logCaller() {
    /*final type = runtimeType.toString();
    final package = _getPackage();*/
    //final trace = StackTrace.current.toString();
    //final match = RegExp(r'package:([^/]+)/').firstMatch(trace);
    String? traceLine = _getPackageFilePath();
    int index = 0;
    int selfCounter = 0;
    if(traceLine != null) {
      for (final line in stackTraceLines!) {
        if(line.contains(traceLine)) {
          selfCounter++;
          continue;
        }
        if(index > selfCounter) {
          break;
        }
        index++;
      }
      if(index <= stackTraceLines!.length) {
        final caller = stackTraceLines![index];
        return caller;
      }
    }
    return null;
    /*debugPrint("----PRINT----");
    debugPrint(getPackageFilePath());
    debugPrint("----PRINT----");*/
  }

  String? _getPackageFilePath() {
    stackTraceLines = StackTrace.current.toString().split('\n');

    if(stackTraceLines != null) {
      for (final line in stackTraceLines!) {
        if (line.contains('package:')) {
          // Extract the part before line:column
          final match = RegExp(r'(package:[^ ]+)').firstMatch(line);
          return match?.group(1);
        }
      }
    }
    return null;
  }

  String? _getFullStackLine() {
    stackTraceLines = StackTrace.current.toString().split('\n');

    for (final line in stackTraceLines!) {
      if (line.contains('package:')) {
        return line.trim();
      }
    }
    return null;
  }

  String? _getFileName() {
    final trace = StackTrace.current.toString().split('\n');

    for (final line in trace) {
      if (line.contains('package:')) {
        final match = RegExp(r'package:[^/]+/([^:]+)').firstMatch(line);
        if (match != null) {
          return match.group(1); // file name
        }
      }
    }
    return null;
  }
}