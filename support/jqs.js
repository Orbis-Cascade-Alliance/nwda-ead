//<!--
function getElement(elem) {
    if (document.getElementById) { // DOM3 = IE5, NS6
        return document.getElementById(elem)
    }
    else {
        if (document.layers) { // Netscape 4
            return document[elem];
        }
        else { // IE 4
            return document.all[elem];
        }
    }
}

function setOpacity(obj,value) {
	obj.style.opacity = value/10;
	//obj.style.filter = 'alpha(opacity=' + value*10 + ')';
}

var changing = false;
var heigths = new Array();

function hide(tag)
{
	var tt = getElement(tag);

	if (tt == null)
		return;

	tt.style.opacity = 0;
	//tt.style.filter = 'alpha(opacity=0)';
	heigths[tag] = tt.offsetHeight;
	tt.style.height = "0px";
	tt.style.overflow = "hidden";
}

function fade(tag)
{
    fadeBase(tag,2.5,20,true);
}

function fadeFast(tag)
{
    var tt = getElement(tag);
    if (tt == null)
        return;
        
    if(tt.style.display != "none" || tt.style.display == "")
    {
        tt.style.display = "none";
     }
    else
    {
        tt.style.display = "";
    }
}

function fadeBase(tag,step,timeout,fade)
{   
    
    var tt = getElement(tag);
    if (tt == null)
        return;
        
    if(tt.style.display == "none")
		return;

    if(changing)
        return;
        

    changing = true;

    tt.style.overflow = "hidden"
    
    if(typeof(heigths[tag]) == "undefined" || tt.clientHeight > 5)
        heigths[tag] = tt.clientHeight;
        
    if(tt.style.height != "0px" || tt.style.height == "")
        setTimeout(function () { fadeHlpr(tt,10,-step,timeout,fade);},timeout);
    else
        setTimeout(function () { fadeHlpr(tt,0,step,timeout,fade);},timeout);
        
}

function fadeHlpr(tt,op,inc,timeout,fade)
{
    op+=inc;
    
    if(fade)
        setOpacity(tt,op);
        
    tt.style.height = heigths[tt.id]*(op/10) + "px";

    if(10>op && 0<op)
        setTimeout(function () { fadeHlpr(tt,op,inc,timeout,fade);},timeout);
    else
    {
	    if(op == 10 && tt.id == "results")
	    {
			tt.style.overflow = "auto"
			if((heigths[tt.id]*(op/10)) > 3)
				tt.style.border = "solid 1px #47371f"
        }
        if(op == 0 && tt.id == "results")
	    {
			tt.style.overflow = "hidden"
			tt.style.border = "solid 0px #47371f"
        }
        changing = false;
    }
}

function showall()
{
    show('h_overview');
    show('h_top_odd');
    show('h_top_bioghist');
    show('h_top_scopecontent');
    show('h_use');
    show('h_ai');
    show('h_dsc');
    show('h_controlaccess');
}

function show(tag)
{

	var tt = getElement(tag);
	if (tt == null)
		return;
	if(tt.style.display == "none")
		tt.style.display = "";
	else
	{
		setOpacity(tt,10);
		tt.style.height = "";
	}
     
	if(tt.id == "results")
	{
		tt.style.overflow = "auto"
		tt.style.border = "solid 1px #47371f"
	}
}
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
if (typeof(_gat) == "object") {
var pageTracker = _gat._getTracker("UA-3516166-1");
pageTracker._setLocalRemoteServerMode();
pageTracker._initData();
pageTracker._trackPageview();
}
//-->