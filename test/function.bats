#!/usr/bin/env bats

load "${DOTFILES_DIR}/system/.function"
load "${DOTFILES_DIR}/system/.function_text"

FIXTURE=$'foo\nbar\nbaz\nfoo'
FIXTURE_TEXT="foo"

@test "get" {
	ACTUAL=$(get "FIXTURE_TEXT")
	EXPECTED="foo"
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "is-executable" {
	run is-executable ls
	[ "$status" -eq 0 ]
}

@test "is-executable (false)" {
	run is-executable nonexistent
	[ "$status" -eq 1 ]
}

@test "is-supported" {
	run is-supported ls -a
	[ "$status" -eq 0 ]
}

@test "is-supported (false)" {
	run is-supported "ls --nonexistent"
	[ "$status" -eq 1 ]
}

@test "c (calc)" {
	ACTUAL="$(c 1+2)"
	EXPECTED=3
	[ "$ACTUAL" -eq "$EXPECTED" ]
}

@test "line" {
	ACTUAL=$(get "FIXTURE" | line 2)
	EXPECTED="bar"
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "line + surrounding lines" {
	ACTUAL=$(get "FIXTURE" | line 3 1)
	EXPECTED=$(echo -e "bar\nbaz\nfoo")
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "duplines" {
	ACTUAL=$(get "FIXTURE" | duplines)
	EXPECTED=$(echo -e "foo")
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "uniqlines" {
	ACTUAL=$(get "FIXTURE" | uniqlines)
	EXPECTED=$'bar\nbaz'
	[ "$ACTUAL" = "$EXPECTED" ]
}
