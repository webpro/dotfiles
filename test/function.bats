#!/usr/bin/env bats

load "../system/.function"
load "../system/.function_text"

FIXTURE=$'foo\nbar\nbaz\nfoo'
FIXTURE_TEXT="foo"

@test "get" {
	ACTUAL=$(get "FIXTURE_TEXT")
	EXPECTED="foo"
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "calc" {
	ACTUAL="$(calc 1+2)"
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
