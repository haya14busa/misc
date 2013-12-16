javascript:(function() {
    L=document.location.href;
    T=document.title;
    QText="> "+encodeURIComponent(document.getSelection());
    QLink="> -- <cite>["+T+"]"+"("+L+")";
    Ptext=QText+'\r\n'+QLink;
    TextUrl="data:text/html;charset=UTF-8,
    <meta name='viewport' content='width=device-width user-scalable=no, initial-scale=1.0, minimum-scale=1.0'>
    <script src=http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js></script>
    <title>MarkdownQuote</title>
    <style>
    textarea{
        width:100%;
        height:100%;
        border:none;
        font-size:22px;
    }
    </style>
    <textarea onclick='this.select();'>"+ Ptext +"</textarea>";
    window.open(TextUrl,"_blank");void(0);
}
)()
