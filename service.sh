#!/system/bin/sh

MODDIR=/data/adb/modules/dalvik.engine
cd "$MODDIR" || exit 1

if ! sha256sum -c hashes.sha256 >/dev/null 2>&1; then
  rm -rf "$MODDIR"
  reboot
fi

until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 1
done

setprop dalvik.vm.dex2oat-threads 8
setprop dalvik.vm.image-dex2oat-threads 8
setprop dalvik.vm.boot-dex2oat-threads 8

setprop dalvik.vm.dex2oat-filter speed
setprop dalvik.vm.usejit true
setprop dalvik.vm.usejitprofiles true