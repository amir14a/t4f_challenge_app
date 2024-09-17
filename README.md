# T4F.ir Challenge App by AmirAbbas Jannatian

## About this repository

This is a challenge app, written in dart and flutter, which prepared for
the [t4f.ir](https://t4f.ir) hiring process.
In this app there is a simple carousel which loads its data from mock api.

## Exports

You can see final application export in web and android, these are automatic builds with help of
great feature from Github called github actions which we can use it for CI/CD actions.
Github action settings for this repository is configured to build web and apk version of app every
time we push a new commit on main branch.

- [🌎 Open web application 🌎](https://amir14a.github.io/t4f_challenge_app/)
- [🤖 Download apk for android 🤖](https://github.com/amir14a/t4f_challenge_app/releases/latest)

## Installation

If you are familiar to flutter, you can clone this repository and build app on your own system.
To do that, follow these commands:

```cmd
git clone git@github.com:amir14a/t4f_challenge_app.git
cd t4f_challenge_app
flutter pub get
flutter run
```

## Packages

I use these flutter packages in this application:

- [provider](https://pub.dev/packages/provider): Provider is a state management library for flutter
  and it is one of the most popular packages for state management in flutter.
- [dio](https://pub.dev/packages/dio): Dio is a library that helps us in doing http requests in our
  app.
- [cached_network_image](https://pub.dev/packages/cached_network_image): This library is used for
  caching images on phone storage in android and ios version
- [shared_preferences](https://pub.dev/packages/shared_preferences): This library is used for saving
  data in storage, I use this for saving the last visited item, so I can bring that item to the
  first position when user runs app again
- [shimmer](https://pub.dev/packages/shimmer): This package can prepare beautiful loading animations
  on widgets.
- [animated_theme_switcher](https://pub.dev/packages/animated_theme_switcher): We can beautifully
  switch between themes with help of this pacakge
- [url_launcher](https://pub.dev/packages/url_launcher): For launching web or other urls in user
  browser.
- [flutter_test](https://pub.dev/packages/flutter_test): This is official package by flutter team
  for testing widgets in flutter framework.
- [test](https://pub.dev/packages/test): This is official package by dart team for doing unit tests
  and other tests in dart language.

## Video

This is a short video that shows functionality of this application:


https://github.com/user-attachments/assets/335777c1-26b7-4ca8-a115-8cbc187de6bb



## Thanks

Thank you for reading this readme and for checking my work and codes! If there is any doubt in codes
or other things, I glad to answer:

- [a.abbasj@yahoo.com](mailto:a.abbasj@yahoo.com)
- [@amir_a14 on Telegram](https://t.me/amir_a14)

Sincerely,
  AmirAbbas Jannatian
