// https://gist.github.com/nulltask/7412711#file-index-js
var leak = (function() {

  var leak = [];
  var iframe = document.createElement('iframe');

  iframe.style = 'display: none;';
  document.body.appendChild(iframe);

  var window = iframe.contentWindow;

  for (var p in this) {
    if (void 0 === window[p]) leak.push(p);
  }

  document.body.removeChild(iframe);

  return leak;

}).call(this);alert(leak);
