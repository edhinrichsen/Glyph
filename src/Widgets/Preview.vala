
    public class Preview : WebKit.WebView {
        public string html2;
        public string save_data;
        public string stylesheet = "";

        public MainWindow main_window {get; construct;}

        //public Gtk.SourceBuffer buf;


        public Preview (MainWindow w) {
            Object(
                user_content_manager: new WebKit.UserContentManager(),
                main_window: w
                );
            name = "name";
            visible = true;
            vexpand = true;
            hexpand = true;
            margin = 0;
            //this.buf = buf;
            var settingsweb = get_settings ();
            settingsweb.enable_page_cache = false;
            settingsweb.javascript_can_open_windows_automatically = false;

            update_html_view ();
            //connect_signals ();
        }


        public void save_doc(){
            run_javascript("save();");
            var t = get_title ();
            try {
                // an output file in the current working directory
                var file = File.new_for_path ("~/out.txt");

                // delete if file already exists
                if (file.query_exists ()) {
                    file.delete ();
                }

                // creating a file and a DataOutputStream to the file
                /*
                    Use BufferedOutputStream to increase write speed:
                    var dos = new DataOutputStream (new BufferedOutputStream.sized (file.create (FileCreateFlags.REPLACE_DESTINATION), 65536));
                */
                var dos = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));

                // writing a short string to the stream
                dos.put_string (t);

                // For long string writes, a loop should be used, because sometimes not all data can be written in one run
                // 'written' is used to check how much of the string has already been written
                //uint8[] data = text.data;
                //long written = 0;
                //while (written < data.length) {
                    // sum of the bytes of 'text' that already have been written to the stream
                    //written += dos.write (data[written:data.length]);
                //}
            } catch (Error e) {
                stderr.printf ("%s\n", e.message);

            }
        }

        public void update_html_view () {

                html2 = """
                                        <html>
                                        <head>
                                        <title>Iliad Pad</title>

                                        <script type="text/javascript">
                                        //var page;
                                        //function initDoc() {page = document.getElementById("textBox");}
                                        var selected;
                                        document.execCommand("defaultParagraphSeparator", false, "p");
                                        onmousemove = function(e){
                                            //var target = document.elementFromPoint(e.clientX, e.clientY);
                                            //console.log(target);



                                            //console.log(document.getSelection().focusNode.parentElement);
                                            //selImg(document.getSelection().focusNode.parentElement);
                                        }

                                        document.addEventListener("click", function(e){
                                            sel(document.getSelection().focusNode.parentElement);
                                            //var target = document.elementFromPoint(e.clientX, e.clientY);


                                           // var target = e.target || e.srcElement;
                                           // console.log(target.tagName);
                                            //if (target.tagName == "IMG"){
                                                //selImg(target);
                                            //} else if (selectedImg != null) {
                                            //    deselImg();
                                            //}
                                        });

                                        document.addEventListener("keydown", function(e){
                                            //console.log("target.tagName");
                                            sel(document.getSelection().focusNode.parentElement);

                                        });

                                        document.addEventListener("keyup", function(e){
                                            //console.log("target.tagName");
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

                                            //console.log(len);

                                            var i;
                                            for (i = 0; i < len; i++){
                                                toRemove[i].classList.remove("sel");
                                                //console.log(i);
                                            }

                                            //if (document.getElementsByClassName("sel") != null){

                                                //document.getElementsByClassName("sel").forEach(function() {this.classList.remove("sel");}, this);
                                                //selected.classList.remove("sel");
                                                //selected.blur();
                                                //selected = null;
                                            //}

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

                                        }


                                        <!--function selectText(node) {-->
                                        <!--   node = document.getElementById(node);-->

                                        <!--   if (document.body.createTextRange) {-->-->
                                        <!--       const range = document.body.createTextRange();-->
                                        <!--       range.moveToElementText(node);-->
                                        <!--       range.select();-->
                                        <!--   } else if (window.getSelection) {-->
                                        <!--       const selection = window.getSelection();-->
                                        <!--       const range = document.createRange();-->
                                        <!--       range.selectNodeContents(node);-->
                                        <!--       selection.removeAllRanges();-->
                                        <!--       selection.addRange(range);-->
                                        <!--   } else {-->
                                        <!--       console.warn("Could not select text in node: Unsupported browser.");-->
                                        <!--   }-->
                                        <!--}-->



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

                                            /*outline: 2px solid #3689e6;*/
                                            outline: 15px solid rgba(255,255,255,0.7);
                                            outline-left: 150px;
                                            background-color: rgba(255,255,255,0.7);
                                            box-shadow: 0px 0px 0px #ccc;
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
                                           transition: box-shadow 0.2s, outline 0.2s;
                                           background-size: 40%;
                                           text-shadow: 0px 3px 1px #ffffff, 0px -1px 1px #dddddd;


                                        }

                                        h1,h2,h3,h4,h5,h6,p,img,div {
                                             transition: box-shadow 0.3s, background-color 0.3s, outline 0.3s, font-size 0.3s, font-weight 0.1s, font-style 0.1s;
                                             outline: 0px solid rgba(255,255,255,0);
                                             background-color: rgba(255,255,255,0);

                                        }


                                        %s

                                        </style>



                                        </head>
                                        <body>

                                        <div class="page" >
                                          <div id="data" class="editSpace" contenteditable="true">
                                              <h1>Supervised vs. Unsupervised Learning</h1>
                                              <h6>Understanding the differences between the two main types of machine learning methods</h6>
                                              <p class="drop-caps">Within the field of machine learning, there are two main types of tasks: supervised, and unsupervised. The main difference between the two types is that supervised learning is done using a ground truth, or in other words, we have prior knowledge of what the output values for our samples should be. Therefore, the goal of supervised learning is to learn a function that, given a sample of data and desired outputs, best approximates the relationship between input and output observable in the data. Unsupervised learning, on the other hand, does not have labeled outputs, so its goal is to infer the natural structure present within a set of data points.</p>


                                            <img width="100%" src="https://miro.medium.com/max/1400/1*halC1X4ydv_3yHYxKqvrwg.gif"></img>
                                           <h2>Supervised learning</h2>
                                            <p>Supervised learning is typically done in the context of classification, when we want to map input to output labels, or regression, when we want to map input to a continuous output. Common algorithms in supervised learning include logistic regression, naive bayes, support vector machines, artificial neural networks, and random forests. In both regression and classification, the goal is to find specific relationships or structure in the input data that allow us to effectively produce correct output data. Note that “correct” output is determined entirely from the training data, so while we do have a ground truth that our model will assume is true, it is not to say that data labels are always correct in real-world situations. Noisy, or incorrect, data labels will clearly reduce the effectiveness of your model.</p>

                                            <h2>Unsupervised Learning</h2>
                                            <p>The most common tasks within unsupervised learning are clustering, representation learning, and density estimation. In all of these cases, we wish to learn the inherent structure of our data without using explicitly-provided labels.</p>
                                            </div>
                                        </div>
                                        <img class="intLink" title="Bold" onclick="formatDoc('bold');">
                                        <img class="intLink" title="Italic" onclick="formatDoc('italic');">


                                        </body>
                                        </html>
                """;
                // save_data = "";
                // // A reference to our html_file
                // var html_file = File.new_for_path ("../src/html.html");

                // if (!html_file.query_exists ()) {
                //     stderr.printf ("File '%s' doesn't exist.\n", html_file.get_path ());
                // }

                // try {
                //     // Open file for reading and wrap returned FileInputStream into a
                //     // DataInputStream, so we can read line by line
                //     var dis = new DataInputStream (html_file.read ());
                //     string line;
                //     // Read lines until end of file (null) is reached
                //     while ((line = dis.read_line (null)) != null) {
                //         html +=line;
                //         //stdout.printf ("%s\n", line);
                //     }
                // } catch (Error e) {
                //     error ("%s", e.message);
                // }

                // var save_file = File.new_for_path ("../src/save.mdf");

                // if (!save_file.query_exists ()) {
                //     //stderr.printf ("File '%s' doesn't exist.\n", save_file.get_path ());
                // }

                // try {
                //     // Open file for reading and wrap returned FileInputStream into a
                //     // DataInputStream, so we can read line by line
                //     var dis = new DataInputStream (save_file.read ());
                //     string line;
                //     // Read lines until end of file (null) is reached
                //     while ((line = dis.read_line (null)) != null) {
                //         save_data +=line;
                //         //stdout.printf ("%s\n", line);
                //     }
                // } catch (Error e) {
                //     error ("%s", e.message);
                // }

            //this.load_html (html.printf(save_data), "file:///");
            //html.printf(stylesheet
            this.load_html (html2.printf(stylesheet), "file:///");
            //stdout.printf(html2.printf(stylesheet));


        }

    }

