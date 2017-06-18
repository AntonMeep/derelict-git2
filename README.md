derelict-git2 [![Page on DUB](https://img.shields.io/dub/v/derelict-git2.svg)](http://code.dlang.org/packages/derelict-git2) [![License](https://img.shields.io/dub/l/derelict-git2.svg)](https://github.com/ohdatboi/derelict-git2/blob/master/LICENSE)
=============

A dynamic binding to [libgit2](https://libgit2.github.com/) v0.25.1 for the D programming language.

Please see the sections on [Compiling and Linking](http://derelictorg.github.io/building/overview/) and [The Derelict Loader](http://derelictorg.github.io/loading/loader/) in the Derelict documentation for information on how to build DerelictPQ and load libpq at run time. In the meantime, here's some sample code.

## Example:
```
import derelict.git2;

void main() {
	DerelictGit2.load(); // Load libgit2

	// Now you can call libgit2 functions
}
```

