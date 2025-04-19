#!/bin/bash

TEMPLATE_PATH="tool/templates/intl/pubspec.yaml.tmpl"

# Hàm chuyển snake_case thành PascalCase
to_pascal_case() {
  echo "$1" | awk -F'_' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1' OFS=''
}

generate_for_module() {
  MODULE="$1"
  MODULE_PATH="lib/modules/$MODULE"
  TEMP_PUBSPEC="$MODULE_PATH/pubspec.yaml"
  TEMP_ANALYSIS="$MODULE_PATH/analysis_options.yaml"
  CLASS_NAME="$(to_pascal_case "$MODULE")Localizations"

  echo "🛠️  Generating localization for module: $MODULE"
  echo "👉 Using class name: $CLASS_NAME"

  if [ ! -d "$MODULE_PATH" ]; then
    echo "❌ Module path $MODULE_PATH không tồn tại. Bỏ qua."
    return
  fi
2
  # Tạo pubspec.yaml từ template
  cat "$TEMPLATE_PATH" | sed \
    -e "s/{{MODULE}}/$MODULE/g" \
    -e "s/{{CLASS_NAME}}/$CLASS_NAME/g" \
    > "$TEMP_PUBSPEC"

  # Tạo analysis_options.yaml tạm
  echo "include: package:flutter_lints/flutter.yaml" > "$TEMP_ANALYSIS"

  # Di chuyển vào module và chạy lệnh
  cd "$MODULE_PATH" || {
    echo "❌ Failed to cd into $MODULE_PATH"
    return
  }

  flutter pub get
  flutter pub run intl_utils:generate

  cd - > /dev/null

  # Cleanup
  rm "$TEMP_PUBSPEC"
  rm "$TEMP_ANALYSIS"
  rm -rf "$MODULE_PATH/.dart_tool"
  rm -rf "$MODULE_PATH/.packages"
  rm -rf "$MODULE_PATH/pubspec.lock"

  echo "✅ Done generating l10n for $MODULE"
}

# Danh sách module (bạn có thể lấy từ tham số hoặc hardcode)
for dir in lib/modules/*/; do
  [ -d "$dir" ] || continue
  MODULE=$(basename "$dir")
  MODULES+=("$MODULE")
done

for MODULE in "${MODULES[@]}"; do
  generate_for_module "$MODULE"
done
