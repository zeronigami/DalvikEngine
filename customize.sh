#!/system/bin/sh

ui_print " "
ui_print "  Dalvik Engine Installer"
ui_print "  Pure ART Performance Module"
ui_print " "

EXPECTED_ID="dalvik.engine"

grep -q "id=$EXPECTED_ID" module.prop || abort "Invalid module ID"

cd "$MODPATH" || abort "Invalid module path"

CORES=$(grep -c ^processor /proc/cpuinfo)

if [ "$CORES" -ge 8 ]; then
  DEX_THREADS=8
else
  DEX_THREADS=4
fi

ui_print "  Detected CPU cores: $CORES"
ui_print "  Using dex2oat threads: $DEX_THREADS"

cat <<EOF >> "$MODPATH/system.prop"

dalvik.vm.dex2oat-threads=$DEX_THREADS
dalvik.vm.image-dex2oat-threads=$DEX_THREADS
dalvik.vm.boot-dex2oat-threads=$DEX_THREADS
EOF

ui_print "  Dalvik configuration applied"
ui_print " "
