# rz_library_utilities

A lightweight Flutter utility library by [rzrasel](https://github.com/rzrasel) for common validations, helpers and reusable logic. Built to work directly with `TextFormField.validator` using `String?` pattern.

[![Pub Version](https://img.shields.io/pub/v/rz_library_utilities)](https://pub.dev/packages/rz_library_utilities)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)

## Features

- **Email Validation** - RFC format check
- **Email DNS Validation** - `InternetAddress.lookup` + auto skip on web
- **Mobile Validation** - country code aware, E.164 converter
- **Email or Mobile** - single field validator
- **Password Validation** - min/max, uppercase, lowercase, digit, special
- **Username Validation** - `a-zA-Z0-9_.-` with edge rules
- **Date Validation** - parse, future check, adult check
- **Empty Text Validation** - generic required field

## Installation

#### Install:

### Install (From GIT):

#### Latest Version

![GitHub Tag](https://img.shields.io/github/v/tag/rzrasel/plugins-flutter-rz-library-utilities)

## Latest Tag

![GitHub Tag](https://img.shields.io/github/v/tag/rzrasel/plugins-flutter-rz-library-utilities?label=Latest%20Tag)

**Latest:** `vref-1.0.11`

Add the package to your `pubspec.yaml`:

```yaml
intl: ^0.20.3
dns_client: ^1.3.1
```

```yaml
dependencies:
  rz_library_utilities:
    git:
      url: https://github.com/rzrasel/plugins-flutter-rz-library-utilities.git
      ref: vref-1.0.1
```

Import:

```dart
import 'package:rz_library_utilities/rz_library_utilities.dart';
```

## 🧰 Git Commands

```bash
git init
git remote add origin https://github.com/rzrasel/flutter-plugins-rz-library-utilities.git
git remote -v
git fetch && git checkout master
git add .
git commit -m "Add Readme & Git Commit File"
git pull
git push --all
git status
git status
```

Recommended fix
```bash
git fetch origin
git pull --rebase origin master
git push origin master
```

⚠️ This permanently discards your uncommitted changes:

```bash
git restore .
git pull --rebase origin master
git push origin master
```

Since you're working on the README/workflow and likely want to keep your changes, use:

```bash
git stash
git pull --rebase origin master
git stash pop
git push origin master
```

## Fix - recommended

Delete all Pub cache - Bash

```bash
rm -rf ~/.pub-cache

rm -rf "$LOCALAPPDATA/Pub/Cache"
```

If you only want to delete Git plugin caches

```bash
rm -rf "$LOCALAPPDATA/Pub/Cache/git"
```

Close your Flutter IDE and run:

```bash

flutter pub cache repair
flutter clean
flutter pub get

```

## 🧩 Git Delete All Tag(s) From Remote:

```bash
git ls-remote --tags origin
git tag -l | xargs -n 1 git tag -d
git ls-remote --tags origin \
  | awk -F/ '/refs\/tags\// && !/\^\{\}$/ {print $3}' \
  | while read tag; do
      git push origin --delete "$tag"
    done
```

If you only want to delete vref-* tags

```bash
git tag -l "vref-*" | while read tag; do
    git tag -d "$tag"
    git push origin --delete "$tag"
done
```

## 🧩 Git Rebase Squash (Interactive)

```bash
git rebase -i HEAD~2
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

------------------------------------

git rebase -i 4daac6b7
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

git push --force
//git push -f --set-upstream origin master

------------------------------------

git rebase -i --root
i
[delete word: pick [make it] squash/s]
esc:wq↵

i
[change commit comment by #]
esc:wq↵

git push --force

//git push -f --set-upstream origin master
```

---

## ⏰ PHP Date Example

```php
echo date("D", (time() + 6 * 60 * 60)) . "day " . date("F j, Y, G:i:s", (time() + 6 * 60 * 60));
```

---

## 📚 Learn More

👉 https://youtu.be/V5KrD7CmO4o

---

## ✅ Done!