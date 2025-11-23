# This script ensures NativeTabView.framework has a valid CFBundleIdentifier in its Info.plist after build.
# Add this to your Xcode project and reference from a Run Script Phase after the frameworks are embedded.

FRAMEWORK_DIR="$BUILT_PRODUCTS_DIR/$FRAMEWORKS_FOLDER_PATH/NativeTabView.framework"
PLIST="$FRAMEWORK_DIR/Info.plist"

if [ -f "$PLIST" ]; then
    CFID=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$PLIST" 2>/dev/null)
    if [ -z "$CFID" ]; then
        echo "[fix-native-tabview] Setting CFBundleIdentifier in $PLIST"
        /usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string com.example.NativeTabView" "$PLIST"
    else
        echo "[fix-native-tabview] CFBundleIdentifier already set: $CFID"
    fi
else
    echo "[fix-native-tabview] Info.plist not found for NativeTabView.framework"
fi
