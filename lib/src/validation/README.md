# Validation

A lightweight, pure Dart validation library for Flutter with `String?` message based validators. Works directly with `TextFormField.validator`.

All validators return `String?` - `null` means valid, `String` is the error message.

## Features

- **Email** - format validation
- **Email DNS** - format + DNS lookup validation (`InternetAddress.lookup`)
- **Mobile** - country code aware, E.164 normalize & convert
- **Email or Mobile** - combined validator
- **Password** - length, uppercase, lowercase, digit, special char
- **Username** - alphanumeric with `_ . -` rules
- **Date** - parsing, future check, adult check
- **Empty Check** - generic required field

```text
validation/
├── validation.dart
├── email_validation.dart
├── email_dns_validation.dart
├── mobile_validation.dart
├── email_or_mobile_validation.dart
├── password_validation.dart
├── username_validation.dart
└── date_validation.dart
```

## Usage

### 1. Basic Usage with TextFormField

```dart
import 'validation/validation.dart';

TextFormField(
  validator: (v) => Validation.email.validate(v),
)

TextFormField(
  validator: (v) => Validation.username.validate(v, min: 4, max: 20),
)

TextFormField(
  validator: (v) => Validation.password.validate(v, 
    minLength: 8,
    requireUppercase: true,
    requireSpecial: true,
  ),
)

TextFormField(
  validator: (v) => Validation.mobile.validate(v),
)

TextFormField(
  validator: (v) => Validation.validateEmptyText("Name", v),
)
```

2. Email with DNS Validation
<br>For web it auto-skips DNS check (kIsWeb).

```dart
// on submit, not in validator (async)
final error = await Validation.emailDns.validateWithDns(emailController.text);
if (error != null) {
// show error
} else {
// valid
}

// Or use isValidWithDns alias
final error2 = await Validation.emailDns.isValidWithDns(email);
```

3. Mobile Validation

```dart
// validates country code
validator: (v) => Validation.mobile.hasCountryCode(v)

// validates full number
validator: (v) => Validation.mobile.validate(v)

// get E.164 format: +8801XXXXXXXXX
String? normalized = Validation.mobile.normalizeAndConvert(mobile);
if (normalized != null) {
  print(normalized); // +8801712345678
}
```

Supported inputs: +8801712345678, 008801712345678, 8801712345678

4. Email or Mobile

```dart
TextFormField(
  validator: (v) => Validation.emailOrMobile.validate(v),
)
```

5. Password

```dart
validator: (v) => Validation.password.validate(v,
  minLength: 8,
  maxLength: 32,
  requireUppercase: true,
  requireLowercase: true,
  requireDigit: true,
  requireSpecial: true,
)
```

Returns specific messages:

- Password is required.
- Password must be at least 8 characters.
- Password must include at least one uppercase letter.

6. Date Validation

```dart
TextFormField(
  validator: (v) => Validation.date.isValid(v),
)

// Adult check (18+)
validator: (v) => Validation.date.isAdult(v),
```

# API: Validator Reference

| Validator                  | Method                                | Return Type       |
| -------------------------- | ------------------------------------- | ----------------- |
| `Validation.email`         | `validate(value, min, max)`           | `String?`         |
| `Validation.emailDns`      | `validateWithDns(value)`              | `Future<String?>` |
| `Validation.emailDns`      | `isValidWithDns(value)`               | `Future<String?>` |
| `Validation.mobile`        | `validate(value)`                     | `String?`         |
| `Validation.mobile`        | `hasCountryCode(value)`               | `String?`         |
| `Validation.mobile`        | `normalizeAndConvert(value)`          | `String?` (E.164) |
| `Validation.password`      | `validate(value, ...)`                | `String?`         |
| `Validation.username`      | `validate(value, min, max)`           | `String?`         |
| `Validation.emailOrMobile` | `validate(value)`                     | `String?`         |
| `Validation.date`          | `isValid(value)`                      | `String?`         |
| `Validation.date`          | `isAdult(value)`                      | `String?`         |
| `Validation`               | `validateEmptyText(fieldName, value)` | `String?`         |