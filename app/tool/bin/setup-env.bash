# Danh sách môi trường
echo "Chọn môi trường để setup"
echo "1) Development (dev)"
echo "2) Staging (staging)"
echo "2) Production (prod)"
read -p "Nhập số (1-2): " s

# Xác định môi trường
case $env_choice in
    1)
        FLAVOR="dev"
        ;;
    2)
        FLAVOR="staging"
        ;;
    3)
        FLAVOR="prod"
        ;;
    *)
        echo "Lựa chọn không hợp lệ! Thoát..."
        exit 1
        ;;
esac

# Chạy lệnh build
echo "🚀 Bắt đầu thiết lập môi trường: $FLAVOR"
echo "🔧 Đang thiết lập môi trường: $1"
echo "🏷  Tên ứng dụng: $APP_NAME"
echo "📦 Android ID: $APP_ID_ANDROID"
echo "📦 iOS ID: $APP_ID_IOS"


### 🛠️ Cập nhật Android ###
echo "🔧 Đang cập nhật Android..."
# echo "Hoàn thành thiết lập icon cho ứng dụng..."

# Đổi package name
echo "🔄 Đổi package name và app ID..."
flutter pub run change_app_package_name:main $PACKAGE_NAME

# Cập nhật tên app trong AndroidManifest.xml
echo "🔄 Đổi tên app trong AndroidManifest.xml..."
sed -i '' "s|android:label=\".*\"|android:label=\"$APP_NAME\"|g" android/app/src/main/AndroidManifest.xml


# Đổi applicationId trong build.gradle
echo "🔄 Cập nhật applicationId trong build.gradle..."
sed -i '' "s|applicationId \".*\"|applicationId \"$APP_ID\"|g" android/app/build.gradle

# 🛠️ Cập nhật android:name trong AndroidManifest.xml
sed -i '' "s/android:name=\"[^\"]*\.MainActivity\"/android:name=\"$APP_ID.MainActivity\"/" android/app/src/main/AndroidManifest.xml


echo "✅ Đã đổi tên app thành \"$APP_NAME\" thành công!"
### 🛠️ Cập nhật iOS ###
echo "🔧 Đang cập nhật iOS..."
# 🛠️ Đổi Bundle Identifier trong iOS (project.pbxproj)
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $APP_ID;/" ios/Runner.xcodeproj/project.pbxproj
# 🛠️ Đổi Bundle Identifier trong iOS (project.pbxproj)
sed -i '' "s/PRODUCT_BUNDLE_IDENTIFIER = .*;/PRODUCT_BUNDLE_IDENTIFIER = $APP_ID;/" ios/Runner.xcodeproj/project.pbxproj

# 🛠️ Đổi Display Name trong Info.plist
sed -i '' "s/<key>CFBundleDisplayName<\/key>\n\t<string>.*<\/string>/<key>CFBundleDisplayName<\/key>\n\t<string>$APP_NAME<\/string>/" ios/Runner/Info.plist

echo "🔄 Đổi icon cho ứng dụng..."
sed -i '' "s|image_path: .*|image_path: \"assets/icons/ic_logo_${FLAVOR}.png\"|g" pubspec.yaml
flutter pub run flutter_launcher_icons


# 🛠️ Dọn dẹp & Build lại
flutter clean
flutter pub get

# Kiểm tra lỗi
if [ $? -eq 0 ]; then
    echo "✅ Thiết lập thành công!"
else
    echo "❌ Thiết lập thất bại! Kiểm tra lại lỗi."
    exit 1
fi
