// https://gist.github.com/nulltask/7412711#file-index-js
javascript:(function() {

  var leak = [];
  var iframe = document.createElement('iframe');

  iframe.style = 'display: none;';
  document.body.appendChild(iframe);

  var window = iframe.contentWindow;

  for (var p in this) {
    if (void 0 === window[p]) leak.push(p);
  }

  document.body.removeChild(iframe);

  alert(leak);

}).call(this);
