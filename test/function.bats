#!/usr/bin/env bats

load "../system/function/core.bash"
load "../system/function/text.bash"

FIXTURE=$'foo\nbar\nbaz\nfoo'
FIXTURE_TEXT="foo"

@test "get prints the value of a named variable" {
	ACTUAL=$(get "FIXTURE_TEXT")
	EXPECTED="foo"
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "calc evaluates an arithmetic expression" {
	ACTUAL="$(calc 1+2)"
	EXPECTED=3
	[ "$ACTUAL" -eq "$EXPECTED" ]
}

@test "line prints the line at the given number" {
	ACTUAL=$(get "FIXTURE" | line 2)
	EXPECTED="bar"
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "line prints the given number of surrounding lines" {
	ACTUAL=$(get "FIXTURE" | line 3 1)
	EXPECTED=$(echo -e "bar\nbaz\nfoo")
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "duplines prints lines that occur more than once" {
	ACTUAL=$(get "FIXTURE" | duplines)
	EXPECTED=$(echo -e "foo")
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "uniqlines prints lines that occur only once" {
	ACTUAL=$(get "FIXTURE" | uniqlines)
	EXPECTED=$'bar\nbaz'
	[ "$ACTUAL" = "$EXPECTED" ]
}

@test "git dispatches to git_* functions" {
	load "../system/function/git.bash"
	git_foo() { echo "foo:$*"; }
	ACTUAL="$(git foo a b)"
	[ "$ACTUAL" = "foo:a b" ]
}

@test "git passes other commands through" {
	load "../system/function/git.bash"
	ACTUAL="$(git -C / rev-parse --is-inside-work-tree 2>&1 || true)"
	[[ "$ACTUAL" == *"not a git repository"* ]]
}
