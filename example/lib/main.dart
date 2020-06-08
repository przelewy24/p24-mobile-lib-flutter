import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p24_sdk/p24_sdk.dart';
import 'package:p24_sdk_example/main_page.dart';

void main() {

	P24SdkVersion.value()
		.then((value) => print("Sdk version: $value"));

	runApp(
		MaterialApp(
			home: MainPage(),
		)
	);

}

