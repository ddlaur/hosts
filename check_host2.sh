#!/bin/bash

if [ -z "$1" ] || [ ! -f "$1" ]; then
	echo "Error: File '$1' does not exist."
	exit 1
fi

verify-IP() {
	if ! nslookup "$1" 2>/dev/null | tail -n +4 | grep -Fw "$2"; then
		echo "Bogus IP for $1 in $3 !"
		return 1
	fi
	return 0
}

while read ip name; do
	if echo "$ip" | grep -q "^[0-9]" && [ "$name" != "localhost" ]; then
		verify-IP "$name" "$ip" "$1"
	fi
done < "$1"
