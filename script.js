var xml;
var xsl;
var booksNumber;

function loadXMLDoc(filename)
{
    if (window.ActiveXObject)
    {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    else
    {
        xhttp = new XMLHttpRequest();
    }
    xhttp.open("GET", filename, false);
    try {xhttp.responseType = "msxml-document"} catch(err) {} // Helping IE11
    xhttp.send("");
    return xhttp.responseXML;
}

function displayResult()
{
    xml = loadXMLDoc("transformed.xml");
    xsl = loadXMLDoc("transformToXHTML.xsl");
    //xml = loadXMLDoc("library.xml");
    //xsl = loadXMLDoc("library.xsl");
    booksNumber = xml.getElementsByTagName("book").length;
    //alert(booksNumber);

// code for IE
    if (window.ActiveXObject || xhttp.responseType == "msxml-document")
    {
        ex = xml.transformNode(xsl);
        document.getElementById("example").innerHTML = ex;
    }
// code for Chrome, Firefox, Opera, etc.
    else if (document.implementation && document.implementation.createDocument)
    {
        xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml, document);
        document.getElementById("example").appendChild(resultDocument);
    }
}

function showInput(tData) {

    //alert("in showInput()")

    tData.setAttribute("class", "write");
    tData.setAttribute("onclick", ";");

}


function newElement()
{
    booksNumber+=1;
    let entry = "<book id='b"+booksNumber+"'>" +
        "<title> </title>" +
        "<authors><author> </author></authors>" +
        "<series inedx=' '> </series>" +
        "<publisher> </publisher>" +
        "<pubdate> </pubdate>" +
        "<pages>none</pages>" +
        "<price currency='PLN'>0.00</price>" +
        "</book>";
    //alert(entry);

    parser = new DOMParser();
    let newBook = parser.parseFromString(entry,"text/xml");
    x = newBook.firstElementChild;

    return x;
}

function getInputValues(){

    var inputs = document.getElementsByClassName("write");

    //alert("length=" + inputs.length);

    for (i=0; i< inputs.length ;i++)
    {
        //alert("i: "+i);


        let modified = inputs[i];
        //alert("modified: " + modified.innerHTML);
        let input = modified.getElementsByTagName("input")[0];
       // alert("input: " + input.innerHTML);
        let bookId = modified.parentElement.id;

        //alert("book id: "+ bookId);

        //alert("inputType: "+ input.name);
        //alert("inputValue: "+ input.value);

        //xml.getElementById(bookId).innerHTML
        //let book = xml.getElementById(bookId)
        //alert(book.getElementsByTagName(input.name)[0].childNodes[0].nodeValue);
        let text;
        if(input.name === "index")
        {
            if (input.value<0 || input.value>999)
            {
                alert("avaible value for Number in series: [0,999]");
                return;
            }
            else
            {
                xml.getElementById(bookId).getElementsByTagName("series")[0].setAttribute("index", Math.floor(input.value));
            }
        }
        else if(input.name === "price")
        {
            if (input.value<0 || input.value>999)
            {
                alert("avaible value for price: [0,999]");
                return;
            }
            else
            {
                xml.getElementById(bookId).getElementsByTagName("price")[0].childNodes[0].nodeValue = Math.round(input.value*100)/100;
            }

        }
        else
        {
            if(input.value.length>50)
            {
                alert("max string length: 50");
                return;
            }
            xml.getElementById(bookId).getElementsByTagName(input.name)[0].childNodes[0].nodeValue = input.value;
        }
        //for(j=0; j< book.childNodes.length; j++)
        //{
//
        //    alert("book.childNodes.length "+ book.childNodes.length);
        //    //book.childNodes[i].nodeValue
        //    alert(j +":j "+ book.childNodes[j].nodeName+" : "+book.childNodes[j].nodeValue);
        //}
        //alert(j +"."+xml.getElementById(bookId).getElementsByTagName(input.name)[0].nodeName);


    }

    transformXML();
}

function sanitizeText() {

}

function deleteBook(element) {

    let bookId = element.parentElement.parentElement.id;
    xml.getElementById(bookId).remove();

    transformXML();
}



function addBook() {

    xml.getElementsByTagName("books")[0].appendChild(newElement());

    transformXML();
}
function transformXML()
{
    xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);
    resultDocument = xsltProcessor.transformToFragment(xml, document);
    let old =  document.getElementById("example").firstElementChild;
    document.getElementById("example").replaceChild(resultDocument,old);

    let currentdate = new Date();
    let datetime = currentdate.getDate() + "/"
        + (currentdate.getMonth()+1)  + "/"
        + currentdate.getFullYear() + " "
        + currentdate.getHours() + ":"
        + currentdate.getMinutes() + ":"
        + currentdate.getSeconds();

    document.getElementById("generated").innerHTML = datetime;

}
function showSource()
{
    let outputXml = new XMLSerializer().serializeToString(xml);

    console.log(vkbeautify.xml(outputXml));
}

