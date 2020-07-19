
public class Doc : Gtk.Box {
    public string data = "";
    public string save_data;
    public string stylesheet = "";
    public WebKit.WebView view {get; construct;}

    public Doc () {
        Object(
            //user_content_manager: new WebKit.UserContentManager(),
            view: new WebKit.WebView()
            );

        view.visible = true;
        view.vexpand = true;
        view.hexpand = true;
        view.margin = 0;

        add(view);

        var settingsweb = view.get_settings ();
        settingsweb.enable_page_cache = false;
        settingsweb.javascript_can_open_windows_automatically = false;
        settingsweb.javascript_can_access_clipboard = true;
        settingsweb.enable_javascript = true;
        settingsweb.enable_write_console_messages_to_stdout = true;


        //load();
        update_html_view ();
    }

    public void load(File file){
        // A reference to our file
        //var file = File.new_for_path ("../css/data.xml");

        if (!file.query_exists ()) {
            stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
        }

        try {
            // Open file for reading and wrap returned FileInputStream into a
            // DataInputStream, so we can read line by line
            var dis = new DataInputStream (file.read ());
            string line;
            // Read lines until end of file (null) is reached
            while ((line = dis.read_line (null)) != null) {
                //stdout.printf ("%s\n", line);
                data += line;
            }
        } catch (Error e) {
            error ("%s", e.message);
        }
        update_html_view ();
    }

    public async void save_doc_wip(){
        stdout.printf("start");
        //save(WebKit.SaveMode.MHTML);
        view.save(WebKit.SaveMode.MHTML);

        var task = new GLib.Task (this, null, (obj, result) => {
            try {
                var ret = result.propagate_boolean ();
            } catch (Error err) {
             // handler err...
            }
            });

//task.return_boolean (true);
        view.save.end(task);


        stdout.printf("end");
    }

    public void save_doc(){

        try {
        // an output file in the current working directory
        var file = File.new_for_path ("../css/out.mhtml");

        // delete if file already exists
        if (file.query_exists ()) {
            file.delete ();
        }
        view.save_to_file (file, WebKit.SaveMode.MHTML);

        } catch (Error e) {
            stderr.printf ("%s\n", e.message);
            //return 1;
        }
    }

    public void update_html_view () {
        var h = new HTML();
        var html = h.html;
        //stdout.printf(html.printf(data));

        view.load_html (html.printf(data), "file:///");
        //view.run_javascript("save()");



    }

    public void run_javascript(string s){
        view.run_javascript(s);
    }

    }

