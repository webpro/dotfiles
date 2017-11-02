#!/usr/bin/env bats

@test "dotfiles" {
	run dotfiles
	[[ $output =~ "Usage" ]]
}

@test "json" {
	ACTUAL=$(echo '{"x":1}' | json)
	EXPECTED=$'{ "x": 1 }'
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "set-config" {
	run set-config KEY_A VALUE_1 MYFILE
	run set-config KEY_B VALUE_2 MYFILE
	run set-config KEY_A VALUE_3 MYFILE
	ACTUAL=`cat MYFILE`
	EXPECTED=$'export KEY_A="VALUE_3"\nexport KEY_B="VALUE_2"'
	[ "$ACTUAL" = "$EXPECTED" ]
	run rm MYFILE
}
