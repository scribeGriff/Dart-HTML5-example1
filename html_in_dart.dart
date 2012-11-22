import 'dart:html';
import 'dart:math';
import 'dart:isolate';

class HtmlInDart {
  InputElement numBottles;
  InputElement mySlider;
  num consumptionRate = 2000;
  num bottleNumber;
  Timer timer;

  HtmlInDart();

  Future<HtmlInDart> createStyles() {
    final c = new Completer();
    // Adds the opening and closing <style> tags, sets the type and adds it to the head section.
    var myStyle = new StyleElement();
    document.head.nodes.add(myStyle);
    // Defines most of the styles used in the example.  A few styles have been defined inline.
    myStyle
      ..type = "text/css"
      ..innerHTML = "#home {background-color: #E1CF75;"
          "font-family: Verdana, Geneva, sans-serif;}"
      ..addHtml("#page {width:1000px; margin:20px auto;"
          "background-color:rgba(255,255,255,0.7); border-radius:15px; overflow:hidden;}")
      ..addHtml("#output {width:50%; height:600px; margin:10px; padding:20px;"
          "background-color:white; float:right; border-top-right-radius:20px;"
          "border-bottom-right-radius:20px; overflow:auto;}")
      ..addHtml("#titleHeading {margin:30px; text-align:center; border-bottom: 2px inset Khaki;"
    		  "overflow:hidden; padding-bottom:10px;}")
      ..addHtml("#input1 {width:30%; margin:30px 50px; padding:0 20px 20px 20px;"
          " border-bottom: 2px inset Khaki;}")
      ..addHtml("#input2 {width:30%; margin:30px 50px; padding:0 20px;}")
      ..addHtml("h4 {text-align:center;}");

    c.complete(this);
    return c.future;
  }

  Future<HtmlInDart> buildPage() {
    final c = new Completer();
    // Create a page div that will enclose our example and add it to the body section.
    var page = new DivElement();
    page.id = "page";
    document.body.nodes.add(page);

    // Create another div for the output text to be written to.
    var outputCont = new DivElement();
    outputCont.id = "output";
    page.nodes.add(outputCont);

    // Our page gets a heading.
    var titleHeading = new HeadingElement.h2();
    titleHeading
        ..id = "titleHeading"
        ..text = "Welcome to 99 Bottles or Less of Dart Beer!";
    page.nodes.add(titleHeading);

    // Now define two divs to hold the user input and provide a title for each div.
    // Add both to the page div.
    var inputCont1 = new DivElement();
    inputCont1.id = "input1";
    page.nodes.add(inputCont1);

    var inputHeading1 = new HeadingElement.h4();
    inputHeading1
        ..id = "inputHeading1"
        ..text = "Enter the number of Dart beers on the wall (1-99):";
    inputCont1.nodes.add(inputHeading1);

    var inputCont2 = new DivElement();
    inputCont2.id = "input2";
    page.nodes.add(inputCont2);

    var inputHeading2 = new HeadingElement.h4();
    inputHeading2
        ..id = "inputHeading2"
        ..text = "Rate of Consumption:";
    inputCont2.nodes.add(inputHeading2);

    // Now create the user interface elements.
    // The first element is a text field with a submit button.
    numBottles = new InputElement();
    numBottles.attributes = ({
      "id": "numBottles",
      "type": "text"
    });
    inputCont1.nodes.add(numBottles);

    var commenceButton = new ButtonElement();
    commenceButton.attributes = ({
      "id": "commenceButton",
      "type": "button",
    });
    commenceButton.innerHTML = "commence";
    inputCont1.nodes.add(commenceButton);

    // The second interface element is a slider (or range) element.
    mySlider = new InputElement();
    mySlider.attributes = ({
      "id": "mySlider",
      "type": "range",
      "min": "500",
      "max": "8000",
      "step": "20",
      "value": "2000"
    });
    inputCont2.nodes.add(mySlider);

    // Now add labels to the slider and style the labels inline.
    var labelFast = new LabelElement();
    labelFast
        ..text = "fast"
        ..style.float = "left"
        ..style.paddingRight = "50px";
    inputCont2.nodes.add(labelFast);

    var labelSlow = new LabelElement();
    labelSlow
        ..text = "slow"
        ..style.float = "right";
    inputCont2.nodes.add(labelSlow);

    c.complete(this);
    return c.future;
  }

  Future<HtmlInDart> addListeners() {
    final c = new Completer();

    query('#commenceButton').on.click.add(
        (e) => startConsuming());

    query('#mySlider').on.mouseUp.add((e) {
      consumptionRate = int.parse(mySlider.value);
    });

    c.complete(this);
    return c.future;
  }

  void startConsuming() {
    query('#commenceButton').attributes['disabled'] = 'disabled';
    query('#output').innerHTML = "";
    numBottles.value == "" ? numBottles.value = "24" : numBottles.value;
    bottleNumber = int.parse(numBottles.value) ;
    bottleNumber > 99 || bottleNumber < 1 ? bottleNumber = 24 : bottleNumber;
    consume();
  }

  void consume() {
    String s, s1, s2, s3, s4;
    if (bottleNumber <= 0) {
      s1 = "Sorry, there are no bottles of Dart beer left. <br>";
      s2 = "Time for more coding with Dart!";
      s = "$s1 $s2";
      query('#commenceButton').attributes.remove('disabled');
    } else {
      s1 = "$bottleNumber bottles of Dart beer on the wall, <br>";
      s2 = "$bottleNumber bottles of Dart beer, <br>";
      s3 = "Take one down and pass it around, <br>";
      s4 = "${bottleNumber - 1} bottles of Dart beer on the wall. <br><br>";
      s = "$s1 $s2 $s3 $s4";
      bottleNumber -= 1;
      timer = new Timer(consumptionRate, (Timer timer) => consume());
    }
    write(s);
  }

  void write(String message) {
    query('#output').addHtml("$message<br>");
    query('#output').scrollTop = 100000;
  }
}

void main() {
  var htmlExample = new HtmlInDart().createStyles()
      .chain((HtmlInDart htmlExample) => htmlExample.buildPage())
      .chain((HtmlInDart htmlExample) => htmlExample.addListeners());
}