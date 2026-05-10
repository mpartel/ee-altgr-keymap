#!/bin/sh
set -eu

if [ "$(id -u)" -eq 0 ]; then
    echo "Refusing to run as root: this script installs to your user config dir only." >&2
    exit 1
fi

BASE="${XDG_CONFIG_HOME:-$HOME/.config}/xkb"
SYMBOLS_DIR="$BASE/symbols"
RULES_DIR="$BASE/rules"
RULES_FILE="$RULES_DIR/evdev.xml"

SRC_DIR="$(cd "$(dirname "$0")/X11" && pwd)"

mkdir -p "$SYMBOLS_DIR" "$RULES_DIR"
install -m 644 "$SRC_DIR/ee_altgr" "$SRC_DIR/ee_uk_altgr" "$SYMBOLS_DIR/"

rules_content() {
    cat <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xkbConfigRegistry SYSTEM "xkb.dtd">
<xkbConfigRegistry>
  <layoutList>
    <layout>
      <configItem>
        <name>ee_altgr</name>
        <shortDescription>ee</shortDescription>
        <description>Estonian (US keyboard with AltGr combinations)</description>
        <languageList><iso639Id>est</iso639Id></languageList>
      </configItem>
    </layout>
    <layout>
      <configItem>
        <name>ee_uk_altgr</name>
        <shortDescription>ee</shortDescription>
        <description>Estonian (UK keyboard with Estonian letters)</description>
        <languageList><iso639Id>est</iso639Id></languageList>
      </configItem>
    </layout>
  </layoutList>
</xkbConfigRegistry>
EOF
}

if [ -e "$RULES_FILE" ]; then
    if ! rules_content | cmp -s - "$RULES_FILE"; then
        echo "Refusing to overwrite $RULES_FILE: contents differ from what this script would write." >&2
        echo "Merge the layout entries manually, or remove the file and re-run." >&2
        exit 1
    fi
else
    rules_content > "$RULES_FILE"
    echo "Wrote layout registry to $RULES_FILE"
fi

echo "Installed ee_altgr and ee_uk_altgr symbols to $SYMBOLS_DIR"
echo "Log out and back in for the layout selector to pick them up."
