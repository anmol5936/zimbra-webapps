if (AjxPackage.define("Clipboard")) {
/*
 * ***** BEGIN LICENSE BLOCK *****
 * Zimbra Collaboration Suite Web Client
 * Copyright (C) 2006, 2007, 2008, 2009, 2010, 2011, 2013, 2014, 2015, 2016, 2017, 2018 Synacor, Inc.
 *
 * The contents of this file are subject to the Common Public Attribution License Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at: https://www.zimbra.com/license
 * The License is based on the Mozilla Public License Version 1.1 but Sections 14 and 15
 * have been added to cover use of software over a computer network and provide for limited attribution
 * for the Original Developer. In addition, Exhibit A has been modified to be consistent with Exhibit B.
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and limitations under the License.
 * The Original Code is Zimbra Open Source Web Client.
 * The Initial Developer of the Original Code is Zimbra, Inc.  All rights to the Original Code were
 * transferred by Zimbra, Inc. to Synacor, Inc. on September 14, 2015.
 *
 * All portions of the code are Copyright (C) 2006, 2007, 2008, 2009, 2010, 2011, 2013, 2014, 2015, 2016, 2017, 2018 Synacor, Inc. All Rights Reserved.
 * ***** END LICENSE BLOCK *****
 */
// by default all 3rd party libraries will be shipped in minified version only as there will not be many instances where we will need to debug 3rd party code
if (AjxPackage.define("ajax.3rdparty.clipboard_min")) {
(function(f,c){"undefined"!==typeof module?module.exports=c():"function"===typeof define&&"object"===typeof define.amd?define(c):this[f]=c()})("clipboard",function(){if(!document.addEventListener)return null;var f={};f.copy=function(){var c=!1,d=null;document.addEventListener("copy",function(b){if(c){for(var e in d)b.clipboardData.setData(e,d[e]);b.preventDefault()}});return function(b){return new Promise(function(e,h){c=!0;d="string"===typeof b?{"text/plain":b}:b instanceof Node?{"text/html":(new XMLSerializer).serializeToString(b)}:
b;try{if(document.execCommand("copy"))c=!1,d=null,e();else throw Error("Unable to copy. Perhaps it's not available in your browser?");}catch(g){c=!1,d=null,h(g)}})}}();f.paste=function(){var c=!1,d,b;document.addEventListener("paste",function(e){if(c){c=!1;e.preventDefault();var h=d;d=null;h(e.clipboardData.getData(b))}});return function(e){return new Promise(function(h,g){c=!0;d=h;b=e||"text/plain";try{document.execCommand("paste")||(c=!1,g(Error("Unable to paste. Pasting only works in Internet Explorer at the moment.")))}catch(f){c=
!1,g(Error(f))}})}}();"undefined"===typeof ClipboardEvent&&("undefined"!==typeof window.clipboardData&&"undefined"!==typeof window.clipboardData.setData)&&(function(c){function d(a,b){return function(){a.apply(b,arguments)}}function b(a){if("object"!=typeof this)throw new TypeError("Promises must be constructed via new");if("function"!=typeof a)throw new TypeError("not a function");this._value=this._state=null;this._deferreds=[];l(a,d(f,this),d(g,this))}function e(a){var b=this;return null===this._state?
void this._deferreds.push(a):void n(function(){var c=b._state?a.onFulfilled:a.onRejected;if(null===c)return void(b._state?a.resolve:a.reject)(b._value);var m;try{m=c(b._value)}catch(d){return void a.reject(d)}a.resolve(m)})}function f(a){try{if(a===this)throw new TypeError("A promise cannot be resolved with itself.");if(a&&("object"==typeof a||"function"==typeof a)){var b=a.then;if("function"==typeof b)return void l(d(b,a),d(f,this),d(g,this))}this._state=!0;this._value=a;k.call(this)}catch(c){g.call(this,
c)}}function g(a){this._state=!1;this._value=a;k.call(this)}function k(){for(var a=0,b=this._deferreds.length;b>a;a++)e.call(this,this._deferreds[a]);this._deferreds=null}function p(a,b,c,d){this.onFulfilled="function"==typeof a?a:null;this.onRejected="function"==typeof b?b:null;this.resolve=c;this.reject=d}function l(a,b,c){var d=!1;try{a(function(a){d||(d=!0,b(a))},function(a){d||(d=!0,c(a))})}catch(f){d||(d=!0,c(f))}}var n=b.immediateFn||"function"==typeof setImmediate&&setImmediate||function(a){setTimeout(a,
1)},q=Array.isArray||function(a){return"[object Array]"===Object.prototype.toString.call(a)};b.prototype["catch"]=function(a){return this.then(null,a)};b.prototype.then=function(a,c){var d=this;return new b(function(b,f){e.call(d,new p(a,c,b,f))})};b.all=function(){var a=Array.prototype.slice.call(1===arguments.length&&q(arguments[0])?arguments[0]:arguments);return new b(function(b,c){function d(e,g){try{if(g&&("object"==typeof g||"function"==typeof g)){var h=g.then;if("function"==typeof h)return void h.call(g,
function(a){d(e,a)},c)}a[e]=g;0===--f&&b(a)}catch(k){c(k)}}if(0===a.length)return b([]);for(var f=a.length,e=0;e<a.length;e++)d(e,a[e])})};b.resolve=function(a){return a&&"object"==typeof a&&a.constructor===b?a:new b(function(b){b(a)})};b.reject=function(a){return new b(function(b,c){c(a)})};b.race=function(a){return new b(function(b,c){for(var d=0,e=a.length;e>d;d++)a[d].then(b,c)})};"undefined"!=typeof module&&module.exports?module.exports=b:c.Promise||(c.Promise=b)}(this),f.copy=function(c){return new Promise(function(d,
b){if("string"!==typeof c&&!("text/plain"in c))throw Error("You must provide a text/plain type.");window.clipboardData.setData("Text","string"===typeof c?c:c["text/plain"])?d():b(Error("Copying was rejected."))})},f.paste=function(){return new Promise(function(c,d){var b=window.clipboardData.getData("Text");b?c(b):d(Error("Pasting was rejected."))})});return f});
}
}
