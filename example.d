import verex;

import std.stdio;

int
main(string[] args) {
	
	if(args.length <= 1) {
		writefln("Usage: %s <URL> [URL...]", args[0]);
		return 1;
	}
	
	// Create the class to test the regular expression
	auto e = (new VerEx())
			.searchOneLine()
			.startOfLine()
			.then("http")
			.maybe("s")
			.then("://")
			.maybe("www.")
			.anythingBut(" ")
			.endOfLine();
			
	foreach(i, url; args[1..$]) {
		// Use VerEx.test() function to find if URLs in arguments match.
		writefln("The URL '%s' is %sa valid URL.", url, e.test(url) ? "" : "NOT ");
	}
	
	return 0;
}
