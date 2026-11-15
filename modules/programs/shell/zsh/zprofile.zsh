# Android SDK
typeset android_sdk_path

for candidate in \
	"$HOME/Library/Android/sdk" \
	"$HOME/Android/Sdk" \
	/opt/android-sdk; do
	if [[ -d $candidate ]]; then
		android_sdk_path=$candidate
		break
	fi
done

if [[ -n $android_sdk_path ]]; then
	export ANDROID_HOME="$android_sdk_path"
	path=("$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools" "${path[@]}")
fi

unset android_sdk_path candidate
