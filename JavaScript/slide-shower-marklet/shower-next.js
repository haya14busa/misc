javascript:(function(){
    alert(1);
    URL = document.location.href;
    if URL.match(/\?full#Cover/){
        URL.replace('#Cover','#1');
    } else {
        //URL.replace('#\d', inc(n))
    }
    alert(1);
    window.open(URL);
    // Helper
    var inc = function(str){
        return str.replace(/\d+/,function(n){return ++n;})
})();
javascript:alert('aiueo'[this.length -1]);
javascript:alert('aiueo'.slice(-1));
