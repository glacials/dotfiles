#!/bin/bash
un() {

	# do nothing if we can't find un.py
	if [ ! -f "$UN/un.py" ]; then
		return
	fi
	
	history > "$UN/history"
	
	$UN/un.py $UN
	
}
