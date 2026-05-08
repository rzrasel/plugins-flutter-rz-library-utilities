import 'package:flutter/foundation.dart';
import '../utilities/utils/null_checker.dart';

void classPrint({required Type widgetName}) {
  if (kDebugMode) {
    print("|||||||||| Class Name : $widgetName ||||||||||");
  }
}

void printer(dynamic value) {
  if (kDebugMode) {
    print(value);
  }
}

//|------------------|METHOD - LOG DEBUG PRINT|------------------|
void debugLog({
  required String message,
  String? className,
  String? methodName,
  int lineNumber = -1,
}) {
  //|---------------------|CALL - LOG PRINT|---------------------|
  logPrint(
    message: message,
    className: className,
    methodName: methodName,
    lineNumber: lineNumber,
  );
}

//|------------------|METHOD - LOG DEBUG PRINT|------------------|
void debugLogPrint({
  required String message,
  String? className,
  String? methodName,
  int lineNumber = -1,
}) {
  //|---------------------|CALL - LOG PRINT|---------------------|
  logPrint(
    message: message,
    className: className,
    methodName: methodName,
    lineNumber: lineNumber,
  );
}

//|------------------|METHOD - LOG DEBUG PRINT|------------------|
void logDebugPrint({
  required String message,
  String? className,
  String? methodName,
  int lineNumber = -1,
}) {
  //|---------------------|CALL - LOG PRINT|---------------------|
  logPrint(
    message: message,
    className: className,
    methodName: methodName,
    lineNumber: lineNumber,
  );
}

//|---------------------|METHOD - LOG PRINT|---------------------|
void logPrint({
  required String message,
  String? className,
  String? methodName,
  int lineNumber = -1,
}) {
  //|-------------------|LOCAL VARIABLE SCOPE|-------------------|
  String strMessage = "DEBUG_LOG_PRINT:";
  if (!isNull(message)) {
    strMessage = "$strMessage $message";
  }
  if (!isNull(className)) {
    strMessage = "$strMessage $className}";
  }
  if (!isNull(methodName)) {
    strMessage = "$strMessage $methodName}";
  }
  if (lineNumber > -1) {
    strMessage = "$strMessage $lineNumber}";
  }
  StackTrace stackTrace = StackTrace.current;
  if (kDebugMode) {
    debugPrint(stackTrace.toString());
    debugPrint("📍 $strMessage");
  }
}

class _LogLog {
  static List<String>? stackTraceLines;
  static void log(String? message, {bool isDebug = true}) {
    final logCaller = _LogLog().logCaller();
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

  String? logCaller() {
    /*final type = runtimeType.toString();
    final package = _getPackage();*/
    //final trace = StackTrace.current.toString();
    //final match = RegExp(r'package:([^/]+)/').firstMatch(trace);
    String? traceLine = getPackageFilePath();
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

  String? getPackageFilePath() {
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

  String? getFullStackLine() {
    stackTraceLines = StackTrace.current.toString().split('\n');

    for (final line in stackTraceLines!) {
      if (line.contains('package:')) {
        return line.trim();
      }
    }
    return null;
  }

  String? getFileName() {
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