echo "Khởi tạo setup source"
echo "Đang khởi tạo..."
echo "===== CLEAN ====="
flutter clean
echo "==== PUB DET ===="
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

// Khởi tạo localizations
make generate

echo "Khởi tạo thành công..."