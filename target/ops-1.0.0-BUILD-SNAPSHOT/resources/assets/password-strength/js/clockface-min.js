(function(a){var b=function(d,c){this.$element=a(d);this.options=a.extend({},a.fn.clockface.defaults,c,this.$element.data());this.init()};b.prototype={constructor:b,init:function(){this.$clockface=a(a.fn.clockface.template);this.$clockface.find(".l1 .cell, .left.cell").html('<div class="outer"></div><div class="inner"></div>');this.$clockface.find(".l5 .cell, .right.cell").html('<div class="inner"></div><div class="outer"></div>');this.$clockface.hide();this.$outer=this.$clockface.find(".outer");this.$inner=this.$clockface.find(".inner");this.$ampm=this.$clockface.find(".ampm");this.ampm=null;this.hour=null;this.minute=null;this.$ampm.click(a.proxy(this.clickAmPm,this));this.$clockface.on("click",".cell",a.proxy(this.click,this));this.parseFormat();this.prepareRegexp();this.ampmtext=this.is24?{am:"12-23",pm:"0-11"}:{am:"AM",pm:"PM"};this.isInline=this.$element.is("div");if(this.isInline){this.$clockface.addClass("clockface-inline").appendTo(this.$element)}else{this.$clockface.addClass("dropdown-menu").appendTo("body");if(this.options.trigger==="focus"){this.$element.on("focus.clockface",a.proxy(function(c){this.show()},this))}a(document).off("click.clockface").on("click.clockface",a.proxy(function(d){var c=a(d.target);if(c.closest(".clockface").length){return}a(".clockface-open").each(function(){if(this===d.target){return}a(this).clockface("hide")})},this))}this.fill("minute")},show:function(c){if(this.$clockface.is(":visible")){return}if(!this.isInline){if(c===undefined){c=this.$element.val()}this.$element.addClass("clockface-open");this.$element.on("keydown.clockface",a.proxy(this.keydown,this));this.place();a(window).on("resize.clockface",a.proxy(this.place,this))}this.$clockface.show();this.setTime(c);this.$element.triggerHandler("shown.clockface",this.getTime(true))},hide:function(){this.$clockface.hide();if(!this.isInline){this.$element.removeClass("clockface-open");this.$element.off("keydown.clockface");a(window).off("resize.clockface")}this.$element.triggerHandler("hidden.clockface",this.getTime(true))},toggle:function(c){if(this.$clockface.is(":visible")){this.hide()}else{this.show(c)}},setTime:function(f){var e,c,g,d="am";if(f===undefined){if(this.ampm===null){this.setAmPm("am")}return}if(f instanceof Date){c=f.getHours();g=f.getMinutes()}if(typeof f==="string"&&f.length){e=this.parseTime(f);if(e.hour===24){e.hour=0}c=e.hour;g=e.minute;d=e.ampm}if(c>11&&c<24){d="pm";if(!this.is24&&c>12){c-=12}}else{if(c>=0&&c<11){if(this.is24||c===0){d="am"}}}this.setAmPm(d);this.setHour(c);this.setMinute(g)},setAmPm:function(c){if(c===this.ampm){return}else{this.ampm=c==="am"?"am":"pm"}this.$ampm.text(this.ampmtext[this.ampm]);this.fill("hour");this.highlight("hour")},setHour:function(c){c=parseInt(c,10);c=isNaN(c)?null:c;if(c<0||c>23){c=null}if(c===this.hour){return}else{this.hour=c}this.highlight("hour")},setMinute:function(c){c=parseInt(c,10);c=isNaN(c)?null:c;if(c<0||c>59){c=null}if(c===this.minute){return}else{this.minute=c}this.highlight("minute")},highlight:function(g){var e,d=this.getValues(g),f=g==="minute"?this.minute:this.hour,c=g==="minute"?this.$outer:this.$inner;c.removeClass("active");e=a.inArray(f,d);if(e>=0){c.eq(e).addClass("active")}},fill:function(f){var d=this.getValues(f),c=f==="minute"?this.$outer:this.$inner,e=f==="minute";c.each(function(h){var g=d[h];if(e&&g<10){g="0"+g}a(this).text(g)})},getValues:function(e){var d=[11,0,1,10,2,9,3,8,4,7,6,5],c=[];if(e==="minute"){a.each(d,function(g,f){c[g]=f*5})}else{if(this.ampm==="pm"){if(this.is24){a.each(d,function(g,f){c[g]=f+12})}else{c=d.slice();c[1]=12}}else{c=d.slice()}}return c},click:function(f){var c=a(f.target),d=c.hasClass("active")?null:c.text();if(c.hasClass("inner")){this.setHour(d)}else{this.setMinute(d)}if(!this.isInline){this.$element.val(this.getTime())}this.$element.triggerHandler("pick.clockface",this.getTime(true))},clickAmPm:function(c){c.preventDefault();this.setAmPm(this.ampm==="am"?"pm":"am");if(!this.isInline&&!this.is24){this.$element.val(this.getTime())}this.$element.triggerHandler("pick.clockface",this.getTime(true))},place:function(){var d=parseInt(this.$element.parents().filter(function(){return a(this).css("z-index")!="auto"}).first().css("z-index"),10)+10,c=this.$element.offset();this.$clockface.css({top:c.top+this.$element.outerHeight(),left:c.left,zIndex:d})},keydown:function(c){if(/^(9|27|13)$/.test(c.which)){this.hide();return}clearTimeout(this.timer);this.timer=setTimeout(a.proxy(function(){this.setTime(this.$element.val())},this),500)},parseFormat:function(){var e=this.options.format,c="HH",d="mm";a.each(["HH","hh","H","h"],function(g,h){if(e.indexOf(h)!==-1){c=h;return false}});a.each(["mm","m"],function(g,h){if(e.indexOf(h)!==-1){d=h;return false}});this.is24=c.indexOf("H")!==-1;this.hFormat=c;this.mFormat=d},parseTime:function(f){var c=null,h=null,d="am",g=[],e;f=a.trim(f);if(this.regexpSep){g=f.match(this.regexpSep)}if(g&&g.length){c=g[1]?parseInt(g[1],10):null;h=g[2]?parseInt(g[2],10):null;d=(!g[3]||g[3].toLowerCase()==="a")?"am":"pm"}else{f=f.split("").reverse().join("").replace(/\s/g,"");g=f.match(this.regexpNoSep);if(g&&g.length){d=(!g[1]||g[1].toLowerCase()==="a")?"am":"pm";e=g[2].split("").reverse().join("");switch(e.length){case 1:c=parseInt(e,10);break;case 2:c=parseInt(e,10);if(c>24){c=parseInt(e[0],10);h=parseInt(e[1],10)}break;case 3:c=parseInt(e[0],10);h=parseInt(e[1]+e[2],10);if(h>59){c=parseInt(e[0]+e[1],10);h=parseInt(e[2],10);if(c>24){c=null;h=null}}break;case 4:c=parseInt(e[0]+e[1],10);h=parseInt(e[2]+e[3],10);if(c>24){c=null}if(h>59){h=null}}}}return{hour:c,minute:h,ampm:d}},prepareRegexp:function(){var c=this.options.format.match(/h\s*([^hm]?)\s*m/i);if(c&&c.length){c=c[1]}this.separator=c;this.regexpSep=(this.separator&&this.separator.length)?new RegExp("(\\d\\d?)\\s*\\"+this.separator+"\\s*(\\d?\\d?)\\s*(a|p)?","i"):null;this.regexpNoSep=new RegExp("(a|p)?\\s*(\\d{1,4})","i")},getTime:function(e){if(e===true){return{hour:this.hour,minute:this.minute,ampm:this.ampm}}var d=this.hour!==null?this.hour+"":"",f=this.minute!==null?this.minute+"":"",c=this.options.format;if(!d.length&&!f.length){return""}if(this.hFormat.length>1&&d.length===1){d="0"+d}if(this.mFormat.length>1&&f.length===1){f="0"+f}if(!f.length&&this.separator){c=c.replace(this.separator,"")}c=c.replace(this.hFormat,d).replace(this.mFormat,f);if(!this.is24){if(c.indexOf("A")!==-1){c=c.replace("A",this.ampm.toUpperCase())}else{c=c.replace("a",this.ampm)}}return c},destroy:function(){this.hide();this.$clockface.remove();if(!this.isInline&&this.options.trigger==="focus"){this.$element.off("focus.clockface")}}};a.fn.clockface=function(e){var f,c=Array.apply(null,arguments);c.shift();if(e==="getTime"&&this.length&&(f=this.eq(0).data("clockface"))){return f.getTime.apply(f,c)}return this.each(function(){var h=a(this),g=h.data("clockface"),d=typeof e=="object"&&e;if(!g){h.data("clockface",(g=new b(this,d)))}if(typeof e=="string"&&typeof g[e]=="function"){g[e].apply(g,c)}})};a.fn.clockface.defaults={format:"H:mm",trigger:"focus"};a.fn.clockface.template='<div class="clockface"><div class="l1"><div class="cell"></div><div class="cell"></div><div class="cell"></div></div><div class="l2"><div class="cell left"></div><div class="cell right"></div></div><div class="l3"><div class="cell left"></div><div class="cell right"></div><div class="center"><a href="#" class="ampm"></a></div></div><div class="l4"><div class="cell left"></div><div class="cell right"></div></div><div class="l5"><div class="cell"></div><div class="cell"></div><div class="cell"></div></div></div>'}(window.jQuery));