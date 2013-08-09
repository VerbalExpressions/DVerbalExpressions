DVerbalExpressions
==================

## Regular Expressions made easy

Verbal Expressions is a D module that helps to construct difficult regular expressions.

This D module is based off of the original Javascript [Verbal expressions library](https://github.com/jehna/VerbalExpressions) by [jehna](https://github.com/jehna/).

## Examples

### Testing if we have a valid URL

```D

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
         
// Use VerEx.test() function to find if it matches.
writefln("Match? %s", e.test("http://www.google.es") ? "yes" : "no");
```

## Compiling

Compiling the module using DMD:

```bash
$ dmd verex.d
```

Compiling your application with this module using DMD:

```bash
$ dmd -ofmy_application my_application.d verex.o
```

You can use varios DMD options to compile in 'debug', 'release' or 'unittest' modes.

## Using in your project

Include this module into your project with:

```D
import verex;
```

## API 

### Terms
* .anything()
* .anythingBut(string value)
* .something()
* .somethingBut(stringvalue)
* .endOfLine()
* .find(string value)
* .maybe(string value)
* .startOfLine()
* .then(string value)

### Special characters and groups
* .any(string value)
* .anyOf(string value)
* .br()
* .lineBreak()
* .range(string[] args)
* .tab()
* .word()

### Modifiers
* .withAnyCase()
* .searchOneLine()
* .searchGlobal()

### Functions
* .replace(string source, string value)
* .test()

### Other
* .add( expression )
* .multiple(string value)
* .alt()
