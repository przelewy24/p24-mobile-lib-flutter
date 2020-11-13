#!/usr/bin/env bash

#get library version from pubspec.yaml (current commit)
versionLib=$(grep -A 0 'version:' pubspec.yaml | sed 's/^.*: //');

#break when unrecognized version of lib
[ -z "$versionLib" ] && echo "Unrecognized lib version from pubspec.yaml!" && exit 1;

#clone project to get last pubspec (prev commit)
git clone --quiet https://github.com/przelewy24/p24-mobile-lib-flutter.git;
cd p24-mobile-lib-flutter;

#get library version from pubspec.yaml (prev commit)  
pubspecYamlMaster=$(git show $1:pubspec.yaml);
versionLibMaster=$(echo "$pubspecYamlMaster" | grep -A 0 'version:' | sed 's/^.*: //');

#check if pubspec version is different, break when equal
[ "$versionLib" = "$versionLibMaster" ] && echo "Current P24 library version and P24 library version from master branch (pubspec.yaml) are same $versionLibMaster!" && exit 1;

#check if new library version was added to changelog, break if not
[ -z "$(grep $versionLib CHANGELOG.md)" ] && echo "Last changelog entry is not equal with sdk version from pubspec.yaml!" && exit 1;
