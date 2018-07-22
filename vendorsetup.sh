for combo in $(curl -s https://raw.githubusercontent.com/SimplixDot/platform_vendor_cos/oreo/simplix.devices  | sed -e 's/#.*$//' | awk '{printf "simplix_%s-userdebug\n", $1}')
do
    add_lunch_combo $combo
done
