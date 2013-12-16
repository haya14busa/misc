javascript:(function() {
    L=document.location.href;
    T=document.title;
    QText="> "+encodeURIComponent(document.getSelection());
    QLink="> -- <cite>["+T+"]"+"("+L+")";
    Ptext=QText+"\r\r"+QLink;
    TextUrl="data:text/html;charset=UTF-8,
    <textarea onclick='this.select();'>"+ Ptext +"</textarea>";
    window.open(TextUrl,"_blank");void(0);
}
)()
