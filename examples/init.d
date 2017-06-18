#!/usr/bin/env dub
/+
dub.json:
{
	"name": "init",
	"dependencies": {
		"derelict-git2": {
			"path": "../"
		}
	}
}
+/

import derelict.git2;
import std.stdio;
import std.string;

void main() {
	DerelictGit2.load();

	git_libgit2_init();
	scope(exit) git_libgit2_shutdown();

	git_repository *repo = null;

	int error = git_repository_init(&repo, "/tmp/...".toStringz, false);
	scope(exit) git_repository_free(repo);
	if(error < 0) {
		const(git_error)* e = giterr_last();
		writefln("Error %d/%d: %s", error, e.klass, e.message.fromStringz);
	}
}
