# Using HTML5 input range Attribute with the Timer Class in Dart #

Compliant with Dart Editor version 0.2.10 r16761  
 Dart SDK version 0.2.10.1 r16761   
9:31 PM Sunday, January 13, 2013   
Blog entry at [scribeGriff.com/studios](http://www.scribegriff.com/studios/index.php?post/2011/12/28/Using-the-HTML5-input-range-Attribute-with-setInterval-in-Dart)  
Comments: Update to M2.    
Tags: Dart, Timer, HTML, DOM

----------

**Update 13 January 2013:** Some minor changes as Dart marches towards version 2 of the html library: 

    addHtml(String)
    innerHTML(String)

is now

    appendHtml(String)
    innerHtml(String)

and the use of futures has changed some:

    void main() {
      var htmlExample = new HtmlInDart().createStyles();
      htmlExample
          ..then((htmlExample) => htmlExample.buildPage())
          ..then((htmlExample) => htmlExample.addListeners());
    }

Finally, dart.js has been moved to pub so we now use a pubspec.yaml file and change the html file to:

    <script src="packages/browser/dart.js"></script>
 
----------

**Update 15 October 2012:** A lot has happened with the Dart programming language since I originally wrote this post last year.  Perhaps the biggest change as it relates to this old blog post is that we now have a Timer class available on both the client and the server side through the dart:isolate library.  But besides saying goodbye to both setInterval and clearInterval in our original example, we also incorporate some of the other really nice language features Dart has implemented in the past 10 months [(M1 Language Changes)](http://www.dartlang.org/articles/m1-language-changes/), including:

* Method cascades
* Futures for asynchronous control
* No + for string concatenation
* Elements now have factory constructors:

so even though this still works:

	DivElement myDiv1 = new Element.tag("div");

you can now just do this:

	var myDiv1 = new DivElement();

This is just to name just a few of the changes.  The post itself has been updated although the intent remains simply to illustrate how one could do a variety of assorted tasks in Dart and not to suggest a specific way of doing things.  

Although not absolutely necessary for this example, we now use futures to build this simple application:

    void main() {
      var htmlExample = new HtmlInDart().createStyles()
        .chain((HtmlInDart htmlExample) => htmlExample.buildPage())
        .chain((HtmlInDart htmlExample) => htmlExample.addListeners());
    }
