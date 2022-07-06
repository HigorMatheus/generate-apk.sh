#!/bin/bash
apk_name=$(date +%d-%m-%Y_%H-%M)-app-name.apk

echo '--------------------------------------------'
echo 'keytool_password=  keytool_password'
echo '--------------------------------------------'
echo '--------------------------------------------'
echo '----Generating the keystore to generate the apk----';
echo '--------------------------------------------'
echo "Make sure you're running the script with admin permission (chmod 777 generate-apk.sh)";
echo '--------------------------------------------'
sudo keytool -genkey -v -keystore my-upload-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000

if [ -d ./android/app/build ]; then
echo '--------------------------------------------'
echo 'removing ./android/app/build'
echo '--------------------------------------------'
    rm -rf ./android/app/build
fi

if [ -d ./android/build ]; then
echo '--------------------------------------------'
echo 'removing ./android/build'
echo '--------------------------------------------'
    rm -rf ./android/build
fi
if [ -f ./android/.gradle ]; then
echo '--------------------------------------------'
echo 'removing ./android/.gradle'
echo '--------------------------------------------'
    rm -rf ./android/.gradle
fi

if [ -d ./build ]; then
echo '--------------------------------------------'
echo 'removing ./build'
echo '--------------------------------------------'
    rm -rf ./build
fi

if [ -f ./android/app/my-upload-key.keystore ]; then
echo '--------------------------------------------'
echo 'removing ./android/app/my-upload-key.keystore'
echo '--------------------------------------------'
    rm -rf ./android/app/my-upload-key.keystore
fi

echo '--------------------------------------------'
echo 'moving my-upload-key.keystore to ./android/app'
echo '--------------------------------------------'
mv my-upload-key.keystore ./android/app

echo '--------------------------------------------'
echo 'generate app-debug.apk'
echo '--------------------------------------------'
yarn react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/


cd android && ./gradlew assembleDebug

cd ./../

mkdir build

mv android/app/build/outputs/apk/debug/app-debug.apk ./build/$apk_name

echo '--------------------------------------------'
echo 'apk generated success ./build/'$apk_name
echo '--------------------------------------------'
