if /usr/local/opt/switchaudio-osx/SwitchAudioSource -c | grep -i "macbook pro speakers"; then
	if /usr/local/opt/switchaudio-osx/SwitchAudioSource -a | grep -i "Karl’s AirPods Pro"; then
		/usr/local/opt/switchaudio-osx/SwitchAudioSource -s "Karl’s AirPods Pro"
	elif /usr/local/opt/switchaudio-osx/SwitchAudioSource -a | grep -i "D10"; then
		/usr/local/opt/switchaudio-osx/SwitchAudioSource -s "D10 "
	fi
else
	/usr/local/opt/switchaudio-osx/SwitchAudioSource -s "MacBook Pro Speakers"
fi

