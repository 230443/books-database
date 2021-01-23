var xml;
var xsl;

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
    entry = "<book id=''> <title></title>" +
        "<authors><author></author></authors>" +
        "<series inedx=''></series>" +
        "<publisher></publisher>" +
        "<pages></pages>" +
        "<price></price>"
}

function getInputValues(){

    var inputs = document.getElementsByClassName("write");

    alert("length=" + inputs.length);

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
        xml.getElementById(bookId).getElementsByTagName(input.name)[0].childNodes[0].nodeValue = input.value;
        //for(j=0; j< book.childNodes.length; j++)
        //{
//
        //    alert("book.childNodes.length "+ book.childNodes.length);
        //    //book.childNodes[i].nodeValue
        //    alert(j +":j "+ book.childNodes[j].nodeName+" : "+book.childNodes[j].nodeValue);
        //}
        //alert(j +"."+xml.getElementById(bookId).getElementsByTagName(input.name)[0].nodeName);


    }

    xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);
    resultDocument = xsltProcessor.transformToFragment(xml, document);
     let old =  document.getElementById("example").firstElementChild;
    document.getElementById("example").replaceChild(resultDocument,old);
    //document.getElementById("example").appendChild(resultDocument);

}

function sanitizeText() {

}