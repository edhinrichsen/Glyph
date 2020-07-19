public class HTML : GLib.Object{
     public string html =

     """
     <html lang="en-US">
     <head>
     <title>hi   </title>
     <script type="text/javascript">
     var selected;
     document.execCommand("defaultParagraphSeparator", false, "p");

     document.addEventListener("click", function(e){
         sel(document.getSelection().focusNode.parentElement);
     });

     document.addEventListener("keydown", function(e){
         sel(document.getSelection().focusNode.parentElement);
     });

     document.addEventListener("keyup", function(e){
         sel(document.getSelection().focusNode.parentElement);

     });

     function formatDoc(sCmd, sValue) {
           document.execCommand(sCmd, false, sValue);
           //page.focus();
     }

     function swapStyleSheet(sheet) {
         document.getElementById("pagestyle").setAttribute("href", "file:///home/edward/Documents/SandBox/gtk-hello/css/"+sheet);
         //document.getElementById("pagestyle").innerHTML = sheet;
     }

     function sel(e) {
         if (e != selected && validType(e)){

             desel();
             selected = e;
             e.classList.add("sel");
             e.focus();


             var new_text = selected.innerHTML.replace(/<span.*?>/, " ");

             if (selected.innerHTML != new_text){
                 selected.innerHTML = new_text
                 selected.innerHTML = selected.innerHTML.replace(/<\/span>/, "");
             }
         }
     }

     function desel() {

         var toRemove = document.getElementsByClassName("sel");
         var len = toRemove.length;

         var i;
         for (i = 0; i < len; i++){
             toRemove[i].classList.remove("sel");
             //console.log(i);
         }
     }

     function validType(e) {
         if (
             e.nodeName == "H1" ||
             e.nodeName == "H2" ||
             e.nodeName == "H3" ||
             e.nodeName == "H4" ||
             e.nodeName == "H5" ||
             e.nodeName == "H6" ||
             e.nodeName == "P"
         ) {
             return true;
         } else {
             return false;
         }
     }

     function save() {
         document.title = document.getElementById('data').innerHTML;
         //console.log(document.getElementById('data').innerHTML);

     }
     </script>
     <link rel="stylesheet" id="pagestyle" type="text/css" href="file:///home/edward/Documents/SandBox/gtk-hello/css/two.css">
     <style type="text/css">

     .page {
       //background-color: #fff;
       box-shadow: 0px 0px 0px #ccc;

       margin-left: auto;
       margin-right: auto;
       margin-top: -15mm;

       width: 210mm;
       height: 297mm;
     }

     img{
         transition: box-shadow 0.2s, outline 0.1s;
         cursor:default;
     }
     .sel {
         box-shadow: 0px 0px 0px #ccc;
         outline: 15px solid rgba(255,255,255,0.7);
         background-color: rgba(255,255,255,0.7);
         text-align: left;

     }

     .editSpace {

       height: auto;
       width: auto;
       padding-left: 1in;
       padding-right: 1in;
       padding-top: 1in;
       padding-bottom: 1in;
       outline: 0px solid transparent;

     }

     body {
       background-color: #F5F5F5;
       background-image: url(file:///data/Documents/SandBox/gtk-hello/css/bg.jpg);

        background-size: 40%;
        text-shadow: 0px -1px 1px #ddd, 0px 3px 1px #fff;


     }

     h1,h2,h3,h4,h5,h6,p,img,div {
         transition-property: all;
         transition-duration: 0.3s;
          outline: 0px solid rgba(255,255,255,0);
          background-color: rgba(255,255,255,0);

     }

     </style>
     </head>
     <body>

     <div class="page">
         <div id="data" class="editSpace" contenteditable="true">
             %s
         </div>
     </div>
     </body>
     </html>

     """;


}
