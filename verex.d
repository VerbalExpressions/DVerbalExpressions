module verex;

import std.regex;
import std.string;

debug {
	import std.stdio;
}

class VerEx {
	
	private:
	
		string		prefixes;
		string		source;
		string		suffixes;
		string		pattern;
		
		enum Flags {
			Global			= 1,
			Multiline		= 2,
			CaseInsensitive	= 4
		}
		
		string createFlags(string append = "") {
			return (modifiers & Flags.CaseInsensitive ? "i" : "") ~ append;
		}
		
		string reduceLines(string value) {
			ptrdiff_t index = indexOf(value, '\n');
			return (index == -1 ? value : value[0..index]);
		}
		
	public:
	
		uint modifiers;
		
		this() {
		}
		
		~this() {
		}
		
		// TODO Implement opAssign.
		
		ref VerEx add(string value) {
			source ~= value;
			pattern = prefixes ~ source ~ suffixes;
			debug(verbose) writefln("prefixes=%s — source=%s — suffixes=%s — pattern=%s", prefixes, source, suffixes, pattern);
			debug writefln("pattern=%s", pattern);
			return this;
		}
		
		ref VerEx startOfLine(bool enable = true) {
			prefixes = enable ? "^" : "";
			return add("");
		}
		
		ref VerEx endOfLine(bool enable = true) {
			suffixes = enable ? "$" : "";
			return add("");
		}
		
		ref VerEx then(string value) {
			return add("(?:" ~ value ~ ")");
		}
		
		ref VerEx find(string value) {
			return then(value);
		}
		
		ref VerEx maybe(string value) {
			return add("(?:" ~ value ~ ")?");
		}
		
		ref VerEx anything() {
			return add("(?:.*)");
		}
		
		ref VerEx anythingBut(string value) {
			return add("(?:[^" ~ value ~ "]*)");
		}
		
		ref VerEx something() {
			return add("(?:.+)");
		}
		
		ref VerEx somethingBut(string value) {
			return add("(?:[^" ~ value ~ "]+)");
		}
		
		string replace(string source, string value) {
			return std.regex.replace(source, std.regex.regex(pattern, createFlags()), value);
		}
		
		ref VerEx lineBreak() {
			return add("(?:(?:\\n)|(?:\\r\\n))");
		}
		
		ref VerEx br() {
			return lineBreak();
		}
		
		ref VerEx tab() {
			return add("\\t");
		}
		
		ref VerEx word() {
			return add("\\w+");
		}
		
		ref VerEx anyOf(string value) {
			return add("[" ~ value ~ "]");
		}
		
		ref VerEx any(string value) {
			return anyOf(value);
		}
		
		ref VerEx range(string[] args) {
			// TODO Implement this.
			return this;
		}
		
		ref VerEx addModifier(char modifier) {
			switch (modifier) {
				case 'i':
					modifiers |= Flags.CaseInsensitive;
					break;
				case 'm':
					modifiers |= Flags.Multiline;
					break;
				case 'g':
					modifiers |= Flags.Global;
					break;
				default:
					break;
			}

			return this;
		}
		
		ref VerEx removeModifier(char modifier) {
			switch (modifier) {
				case 'i':
					modifiers ^= Flags.CaseInsensitive;
					break;
				case 'm':
					modifiers ^= Flags.Multiline;
					break;
				case 'g':
					modifiers ^= Flags.Global;
					break;
				default:
					break;
			}

			return this;
		}
	
		ref VerEx withAnyCase(bool enable = true) {
			enable ? addModifier('i') : removeModifier('i');
			return this;
		}
		
		ref VerEx searchOneLine(bool enable = true) {
			enable ? addModifier('m') : removeModifier('m');
			return this;
		}
		
		ref VerEx searchGlobal(bool enable = true) {
			enable ? addModifier('g') : removeModifier('g');
			return this;
		}
		
		ref VerEx multiple(string value) {
			if(value.length > 0 && value[0] != '*' && value[0] != '+') {
				add("+");
			}
			return add(value);
		}
		
		ref VerEx alt(string value) {
			if(indexOf(prefixes, '(') == -1) {
				prefixes ~= "(";
			}
			if(indexOf(suffixes, ')') == -1) {
				suffixes = suffixes ~ ")";
			}
			add(")|(");
			return then(value);
		}
		
		bool test(string value) {
			string toTest = modifiers & Flags.Multiline ? value : reduceLines(value);
			return cast(bool)std.regex.match(toTest, std.regex.regex(pattern, createFlags(modifiers & Flags.Global ? "g" : "")));
		}
}
