#!/bin/sh

test_description='operations that cull histories in unusual ways'
. ./test-lib.sh

test_commit () {
	echo "$1" >"$1.file" &&
	git add "$1.file" &&
	test_tick &&
	git commit -m "$1"
}

test_expect_success setup '
	test_commit A &&
	test_commit B &&
	test_commit C &&
	git checkout -b side HEAD^ &&
	test_commit D &&
	test_commit E &&
	git merge master
'

test_expect_success 'rev-list --first-parent --boundary' '
	git rev-list --first-parent --boundary HEAD^..
'

test_done
