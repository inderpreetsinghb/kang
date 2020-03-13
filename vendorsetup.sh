for device in $(cat vendor/kang/kang.devices)
do
add_lunch_combo kang_$device-userdebug
done
