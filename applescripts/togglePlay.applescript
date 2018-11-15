tell application "Google Chrome" to count every tab of front window
	tell application "Google Chrome"
	repeat with t in tabs of windows
		tell t
			if URL starts with "https://www.netflix.com/" then
				execute javascript "
								var v = document.querySelector('video');
								if (v.paused) {
								  v.play();
								}
								else {
								  v.pause();
								}"
				exit repeat
			end if
		end tell
	end repeat
end tell
