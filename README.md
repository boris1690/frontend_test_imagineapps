# Flutter Test

## Demo

https://github.com/boris1690/frontend_test_imagineapps/assets/5614247/63aa747f-428f-46d3-9917-d1defd191efc


## Requirements
Flutter: 3.13.3

## Installation
- Add [Flutter](https://flutter.dev/docs/get-started/install 'Flutter') to your machine
- Open this project folder with Terminal/CMD
- Ensure there's no cache/build leftover by running `flutter clean` in the Terminal
- Run in the Terminal `flutter packages get`
- Run in the Terminal `flutter packages pub run build_runner build --delete-conflicting-outputs`

## API URL
- Copy Base Url from backend in path lib/Core/Constants/api.dart ==> replace in var apiUrl
<img width="863" alt="image" src="https://github.com/boris1690/frontend_test_imagineapps/assets/5614247/7b5aae96-af56-466d-a206-3f11dd489664">

<img width="862" alt="image" src="https://github.com/boris1690/frontend_test_imagineapps/assets/5614247/dfb90eaf-3654-4778-907b-8c8170906492">

## Additional steps for iOS
- Open ios folder inside Terminal/CMD
- Run in the Terminal `pod install`
- Run in the Terminal `pod update`

## Running the App
- Open Android Emulator or iOS Simulator
- Run `flutter run`



For more information, check out the [official documentation](https://flutter.dev/docs 'documentation')
