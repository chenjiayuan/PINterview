$(document).ready(function(){$("#calendar").fullCalendar({header:{left:"prev,next today",center:"title",right:"month,agendaWeek,agendaDay"},editable:!0,eventLimit:!0,events:window.location.href+".json"})}),$(document).ready(function(){var t=function(t){t&&t.stopPropagation?t.stopPropagation():window.event.cancelBubble=!0;var e=t?t:window.event;e.preventDefault&&e.preventDefault()},e=function(t,e,n){t.addEventListener?t.addEventListener(e,n,!1):t.attachEvent&&t.attachEvent("on"+e,n)},n=function(t,e){var n=new RegExp("(^| )"+e+"( |$)");return n.test(t.className)?!0:!1},a=function(t,e,a){n(t,e)||(""==t.className?t.className=e:a?t.className=e+" "+t.className:t.className+=" "+e)},i=function(t,e){var n=new RegExp("(^| )"+e+"( |$)");t.className=t.className.replace(n,"$1"),t.className=t.className.replace(/ $/,"")},o=function(){var t=window.location.pathname;-1!=t.indexOf("/")&&(t=t.split("/"));var e=t[t.length-1]||"root";return-1!=e.indexOf(".")&&(e=e.substring(0,e.indexOf("."))),e>20&&(e=e.substring(e.length-19)),e},s="mi"+o(),r=function(t,e){this.g(t,e)};r.prototype={h:function(){var t=new RegExp(s+this.a+"=(\\d+)"),e=document.cookie.match(t);return e?e[1]:this.i()},i:function(){for(var t=0,e=this.b.length;e>t;t++)if(n(this.b[t].parentNode,"selected"))return t;return 0},j:function(t,e){var n=document.getElementById(t.TargetId);if(n){this.l(n);for(var o=0;o<this.b.length;o++)this.b[o]==t?(a(t.parentNode,"selected"),e&&this.d&&this.k(this.a,o)):i(this.b[o].parentNode,"selected")}},k:function(t,e){document.cookie=s+t+"="+e+"; path=/"},l:function(t){for(var e=0;e<this.c.length;e++)this.c[e].style.display=this.c[e].id==t.id?"block":"none"},m:function(){this.c=[];for(var n=this,a=0;a<this.b.length;a++){var i=document.getElementById(this.b[a].TargetId);i&&(this.c.push(i),e(this.b[a],"click",function(e){var a=this;return a===window&&(a=window.event.srcElement),n.j(a,1),t(e),!1}))}},g:function(t,e){this.a=e,this.b=[];for(var n,a,i=t.getElementsByTagName("a"),o=/#([^?]+)/,s=0;s<i.length;s++)if(a=i[s],n=a.getAttribute("href"),-1!=n.indexOf("#")){var r=n.match(o);r&&(n=r[1],a.TargetId=n,this.b.push(a))}var c=t.getAttribute("data-persist")||"";this.d="true"==c.toLowerCase()?1:0,this.m(),this.n()},n:function(){var t=this.d?parseInt(this.h()):this.i();t>=this.b.length&&(t=0),this.j(this.b[t],0)}};var c=[],d=function(t){function n(){i||(i=!0,setTimeout(t,4))}function a(){if(!i)try{document.documentElement.doScroll("left"),n()}catch(t){setTimeout(a,10)}}var i=!1;if(document.addEventListener)document.addEventListener("DOMContentLoaded",n,!1);else if(document.attachEvent){try{var o=null!=window.frameElement}catch(s){}document.documentElement.doScroll&&!o&&a(),document.attachEvent("onreadystatechange",function(){"complete"===document.readyState&&n()})}e(window,"load",n)},h=function(){for(var t=document.getElementsByTagName("ul"),e=0,a=t.length;a>e;e++)n(t[e],"tabs")&&c.push(new r(t[e],e))};return d(h),{}});