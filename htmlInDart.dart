#import('dart:html');

class htmlInDart {
  num bottleNumber;
  num consumptionRate = 2000;
  num consumeIntervalID;
  InputElement numBottles;
  InputElement mySlider;

  htmlInDart() {
    // The constructor sets up the styles and the document.
    createStyles();
    buildPage();
    addListeners();
  }

  void createStyles() {
    // Adds the opening and closing <style> tags, sets the type and adds it to the head section.
    StyleElement myStyle = new Element.tag("style");
    myStyle.type = "text/css";
    window.document.head.nodes.add(myStyle);
    // Defines most of the styles used in the example.  A few styles have been defined inline.
    myStyle.innerHTML = "#home {background-color: #E1CF75; font-family: Verdana, Geneva, sans-serif;}";
    myStyle.innerHTML += "#page {width:1000px; margin:20px auto; background-color:rgba(255,255,255,0.7); " +
    		"border-radius:15px; overflow:hidden;}";
    myStyle.innerHTML += "#output {width:50%; height:600px; margin:10px; padding:20px; background-color:white; float:right;" +
    		"border-top-right-radius:20px; border-bottom-right-radius:20px; overflow:auto;}";
    myStyle.innerHTML += "#titleHeading {margin:30px; text-align:center; border-bottom: 2px inset Khaki; " +
    		"overflow:hidden; padding-bottom:10px;}";
    myStyle.innerHTML += "#input1 {width:30%; margin:30px 50px; padding:0 20px 20px 20px; border-bottom: 2px inset Khaki;}";
    myStyle.innerHTML += "#input2 {width:30%; margin:30px 50px; padding:0 20px;}";
    myStyle.innerHTML += "h4 {text-align:center;}";
  }

  void buildPage() {
    // Create a page div that will enclose our example and add it to the body section.
    DivElement page = new Element.tag("div");
    page.id = "page";
    window.document.body.nodes.add(page);
    // Create another div for the output text to be written to.
    DivElement outputCont = new Element.tag("div");
    outputCont.id = "output";
    page.nodes.add(outputCont);
    // Our page gets a heading.
    HeadingElement titleHeading = new Element.tag("h2");
    titleHeading.id = "titleHeading";
    page.nodes.add (titleHeading);
    document.query('#titleHeading').innerHTML = "Welcome to 99 Bottles or Less of Dart Beer!";
    // Now define two divs to hold the user input and provide a title for each div.  Add both to the page div.
    DivElement inputCont1 = new Element.tag("div");
    inputCont1.id = "input1";
    page.nodes.add(inputCont1);
    HeadingElement inputHeading1 = new Element.tag("h4");
    inputHeading1.id = "inputHeading1";
    inputCont1.nodes.add(inputHeading1);
    document.query('#inputHeading1').innerHTML = "Enter the number of Dart beers on the wall (1-99):";
    DivElement inputCont2 = new Element.tag("div");
    inputCont2.id = "input2";
    page.nodes.add(inputCont2);
    HeadingElement inputHeading2 = new Element.tag("h4");
    inputHeading2.id = "inputHeading2";
    inputCont2.nodes.add(inputHeading2);
    document.query('#inputHeading2').innerHTML = "Rate of Consumption:";
    // Now create the user interface elements.
    // The first element is a text field with a submit button.
    numBottles = new Element.tag ( "input" );
    numBottles.attributes = ({
      "id": "numBottles",
      "type": "text"
    });
    inputCont1.nodes.add(numBottles);
    ButtonElement commenceButton = new Element.tag("button");
    commenceButton.attributes = ({
      "id": "commenceButton",
      "type": "button",
    });
    commenceButton.innerHTML = "commence";
    inputCont1.nodes.add(commenceButton);
    // The second interface element is a slider (or range) element.
    mySlider = new Element.tag("input");
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
    LabelElement labelFast = new Element.tag("label");
    labelFast.innerHTML = "fast";
    labelFast.style.float = "left";
    labelFast.style.paddingRight = "50px";
    inputCont2.nodes.add(labelFast);
    LabelElement labelSlow = new Element.tag("label");
    labelSlow.innerHTML = "slow";
    labelSlow.style.float = "right";
    inputCont2.nodes.add(labelSlow);
  }
  
  void addListeners() {
    document.query('#commenceButton').on.click.add((e) {
      numBottles.value == "" ? numBottles.value = "24" : numBottles.value;
      bottleNumber = Math.parseInt(numBottles.value);
      startConsuming();
    });
    document.query('#mySlider').on.mouseUp.add((e) {
      consumptionRate = Math.parseInt(mySlider.value);
    });
  }
  
  void startConsuming() {
    document.query('#commenceButton').attributes['disabled'] = 'disabled';
    bottleNumber > 99 || bottleNumber < 1 ? bottleNumber = 24 : bottleNumber;
    consumeIntervalID = window.setInterval(consume, 0);
  }
  
  void consume() {
    String s, s1, s2, s3, s4;
    window.clearInterval(consumeIntervalID);
    if(bottleNumber <= 0) {
      s1 = "Sorry, there are no bottles of Dart beer left. <br>";
      s2 = "Time for more coding with Dart!";
      s = s1 + s2;
    } else {
      s1 = "$bottleNumber bottles of Dart beer on the wall, <br>";
      s2 = "$bottleNumber bottles of Dart beer, <br>";
      s3 = "Take one down and pass it around, <br>"; 
      s4 = "${bottleNumber-1} bottles of Dart beer on the wall. <br><br>";
      s = s1 + s2 + s3 + s4;
      bottleNumber -= 1;
      consumeIntervalID = window.setInterval(consume, consumptionRate);
    }
    write(s);
  }
  
  void write(String message) {
    document.query('#output').innerHTML += message + "<br>";
    document.query('#output').scrollTop = 100000;
  }
}

void main() {
  new htmlInDart();
}
