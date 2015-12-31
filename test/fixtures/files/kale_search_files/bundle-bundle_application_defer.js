/**
 * Main javascript file for NDL application
 * @version $Id: application.js 1867 2011-09-06 12:43:40Z  $
 * @author gmoore
 */
var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}
function submitAutoComplete(name)
{
	document.qlookup.value=name;
	document.submit();
}
function resetFacet(field,value)
{
	var f=document.quickform;
	if ( field == "fg") f.fg.value="-"+value;
	else if ( field == "man") f.man.value="-"+value;
	else if ( field == "lfacet") f.lfacet.value="-"+value;
	f.submit();
	
}
/*
* Submits the search form via a click on a facet heading
*
*/
function submitFacet(facet,field)
{
	var f=document.quickform;
	//if ( !f.qlookup.value )
	//	f.qlookup.value="*:*";
   if ( field == "fg" )f.fg.value=facet;
   else if ( field == "man" ) f.man.value=facet;
   else if ( field == "lfacet" ) f.lfacet.value=facet;
    f.submit();

}
// aganti
function updateNutrientsList(e, strdropdown)
{
	var selectedKey = "undefined";
	var json = eval("(" + e.responseText + ")");
	if ( strdropdown == 'nutrient2')
		updateNutrientsList("",'nutrient3');
	var rselect = document.getElementById(strdropdown);
	var len = rselect.length;
	//alert(strdropdown+" = "+len);
	while(len > 0)
	{
		len --;
		rselect.remove(len);
	}
	rselect.options.add(new Option ("Select nutrient",""))
	if ( json )
	{
		for (var i=0; i < json.length; i++) 
		{
			var sel   = json[i];
			rselect.options.add(new Option (sel.description,sel.id))
		}
		try {
			rselect.add(opt, sel.options[null]) ;// standards compliant; doesn't work in IE
		} 
		catch (ex) { 
			   rselect.add(opt,null) ;// IE only
		}
	}
}
function removeOpts(s)
{
	for(i=s.options.length-1;i>=0;i--)
    {
        s.remove(i);
    }
}
function setDefaultOpt(s,v)
{
	for(var i=0; i < s.options.length; i++)
	  {
		if(s.options[i].value === v) {
	      s.selectedIndex = i;
	      break;
	    }
	  }
}
//aganti
function updateSelectOptions(e, strdropdown)
{
	var json = eval("(" + e.responseText + ")");
	var rselect = document.getElementById(strdropdown);
	var v=rselect.value;
	var dopt=strdropdown == "fgcd"?"All food groups ...":"All manufacturers ...";
	removeOpts(rselect)
	rselect.options.add(new Option (dopt,""))
	if ( json )
	{
		for (var i=0; i < json.length; i++) 
		{
			var sel   = json[i];
			if ( sel )
				rselect.options.add(new Option (sel.description,sel.description))
		}
		setDefaultOpt(rselect,v);
	}
}
function showSpinner()
{
 $('#spinner').show();
		  
};
function hideSpinner()
{

$('#spinner').hide();
};
//aganti
function toggleTable(vname,img1,img2)
{

    var elements = document.getElementsByTagName('tr');
    var ele3 = document.getElementById(img1);
    var ele4 = document.getElementById(img2);

	  if(ele3.style.display == "block") {ele3.style.display = "none";}
	  else {ele3.style.display = "block";}
	  if(ele4.style.display == "block") {ele4.style.display = "none"; }
      else {ele4.style.display = "block";}
/*  var h=document.getElementById(vname+"head");
	  console.log(h.style.display);
	  if ( h && h.style.display=="none")
		  h.style.display='inline';
	  else if ( h )
		  h.style.display="none";
	  console.log(h);*/
     // var elements = document.getElementsByTagName('tr');
      for (var i=0; i<elements.length; i++) {
                var id=elements[i].getAttribute('id');
              //  alert("id"+id);
                if ( id && id.substring(0,vname.length)== vname )
                {
                     if ( elements[i].style.display =='none')
                        elements[i].style.display="";
                     else 
                        elements[i].style.display='none';
                }
      }

}
//aganti

function updateFat(v1,v2){

    var x = document.getElementById("calctype").selectedIndex;
    var y = document.getElementById("calctype").options;
    var indexSel = y[x].text;  
   // alert("Index: " + y[x].index + " is " + y[x].text);
  
    if ( indexSel == 'Analytical Fat' ) {
       document.getElementById(v1).style.display = 'block';
       document.getElementById(v2).style.display = 'none';
    }
    if (indexSel=='Labeled Fat' ) {
    	
    	document.getElementById(v1).style.display = 'none';
        document.getElementById(v2).style.display = 'block';
    	
    }
 }
// jQuery compatiblity
/*var matched, browser;

jQuery.uaMatch = function( ua ) {
    ua = ua.toLowerCase();

    var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
        /(webkit)[ \/]([\w.]+)/.exec( ua ) ||
        /(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
        /(msie) ([\w.]+)/.exec( ua ) ||
        ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
        [];

    return {
        browser: match[ 1 ] || "",
        version: match[ 2 ] || "0"
    };
};

matched = jQuery.uaMatch( navigator.userAgent );
browser = {};

if ( matched.browser ) {
    browser[ matched.browser ] = true;
    browser.version = matched.version;
}

// Chrome is Webkit, but Webkit is also Safari.
if ( browser.chrome ) {
    browser.webkit = true;
} else if ( browser.webkit ) {
    browser.safari = true;
}

jQuery.browser = browser;*/

/************************************************************************
*************************************************************************
@Name    :      jMenu - jQuery Plugin
@Revison :      2.0
@Date    :      08/2013
@Author  :      ALPIXEL - (www.myjqueryplugins.com - www.alpixel.fr)
@Support :      FF, IE7, IE8, MAC Firefox, MAC Safari
@License :      Open Source - MIT License : http://www.opensource.org/licenses/mit-license.php

**************************************************************************
*************************************************************************/
(function(e){e.jMenu={defaults:{ulWidth:"auto",absoluteTop:33,absoluteLeft:0,TimeBeforeOpening:100,TimeBeforeClosing:100,animatedText:true,paddingLeft:7,openClick:false,effects:{effectSpeedOpen:150,effectSpeedClose:150,effectTypeOpen:"slide",effectTypeClose:"slide",effectOpen:"swing",effectClose:"swing"}},init:function(t){opts=e.extend({},e.jMenu.defaults,t);if(opts.ulWidth=="auto")$width=e(".fNiv").outerWidth(false);else $width=opts.ulWidth;e(".jMenu li").each(function(){var t=e(this).find("a:first"),n=e(this).find("ul");if(e.jMenu._IsParent(t)){t.addClass("isParent");var r=t.next(),i=t.position();if(e(this).hasClass("jmenu-level-0"))r.css({top:i.top+opts.absoluteTop,left:i.left+opts.absoluteLeft,width:$width});else r.css({top:i.top,left:i.left+$width,width:$width});if(!opts.openClick)e(this).bind({mouseenter:function(){if(e(this).hasClass("jmenu-level-0")){i=e(this).position();r.css({left:i.left+opts.absoluteLeft,top:i.top+opts.absoluteTop})}e.jMenu._show(r)},mouseleave:function(){e.jMenu._closeList(r)}});else e(this).bind({click:function(t){t.preventDefault();e.jMenu._show(r)},mouseleave:function(){e.jMenu._closeList(r)}})}})},_show:function(e){switch(opts.effects.effectTypeOpen){case"slide":e.stop(true,true).delay(opts.TimeBeforeOpening).slideDown(opts.effects.effectSpeedOpen,opts.effects.effectOpen);break;case"fade":e.stop(true,true).delay(opts.TimeBeforeOpening).fadeIn(opts.effects.effectSpeedOpen,opts.effects.effectOpen);break;default:e.stop(true,true).delay(opts.TimeBeforeOpening).show()}},_closeList:function(e){switch(opts.effects.effectTypeClose){case"slide":e.stop(true,true).delay(opts.TimeBeforeClosing).slideUp(opts.effects.effectSpeedClose,opts.effects.effectClose);break;case"fade":e.stop(true,true).delay(opts.TimeBeforeClosing).fadeOut(opts.effects.effectSpeedClose,opts.effects.effectClose);break;default:e.delay(opts.TimeBeforeClosing).hide()}},_animateText:function(t){var n=parseInt(t.css("padding-left"));t.hover(function(){e(this).stop(true,false).animate({paddingLeft:n+opts.paddingLeft},100)},function(){e(this).stop(true,false).animate({paddingLeft:n},100)})},_IsParent:function(e){if(e.next().is("ul"))return true;else return false},_isReadable:function(){if(e(".jmenu-level-0").length>0)return true;else return false},_error:function(){alert("jMenu plugin can't be initialized. Please, check you have the '.jmenu-level-0' class on your first level <li> elements.")}};jQuery.fn.jMenu=function(t){e(this).addClass("jMenu");e(this).children("li").addClass("jmenu-level-0").children("a").addClass("fNiv");if(e.jMenu._isReadable()){e.jMenu.init(t)}else{e.jMenu._error()}}})(jQuery)


