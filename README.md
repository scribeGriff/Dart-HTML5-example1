# Using HTML5 input range Attribute with the Timer Class in Dart #

Compliant with Dart Editor build 13393   
7:16 PM Monday, October 15, 2012   
Blog entry at [scribeGriff.com/studios](http://www.scribegriff.com/studios/index.php?post/2011/12/28/Using-the-HTML5-input-range-Attribute-with-setInterval-in-Dart)  
Comments: Much needed update to an old blog post.    
Tags: Dart, Timer, HTML, DOM

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
