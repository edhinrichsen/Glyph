public class MainWindow : Gtk.ApplicationWindow {

    private GLib.Settings settings;

    public Notebook notebook;
    public Header header;


    public Gtk.Revealer r;

    public MainWindow(Gtk.Application app){
        Object (
            application: app
        );
    }

    construct {

        default_height = 300;
        default_width = 300;

        settings = new GLib.Settings ("com.github.edhinrichsen.glyph");
        move(settings.get_int("x-pos"), settings.get_int("y-pos"));
        resize(settings.get_int("window-width"), settings.get_int("window-height"));

        delete_event.connect (e => {
            return before_destroy();
        });

        notebook = Notebook.get_book();

        var g = new Gtk.Grid();
        //g.row_homogeneous = true;
        r = new Gtk.Revealer();
        r.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT ;
        r.add(new TextSideBar(this));
        //r.add(new Gtk.Label("hi there!!!!!!!"));

        //g.attach(r,0,0);
        r.set_reveal_child(false);
        g.attach(notebook,0,0);
        //g.attach_next_to (r, notebook, Gtk.PositionType.RIGHT);
        //g.attach(,100,0);
        g.attach(r,1,0);

        add(g);
        //add(notebook);

        header = new Header(this);
        set_titlebar(header);

        show_all ();
    }

    public bool before_destroy() {
        int x, y, width, height;
        get_size(out width, out height);
        get_position(out x, out y);

        settings.set_int("x-pos", x);
        settings.set_int("y-pos", y);

        settings.set_int("window-width", width);
        settings.set_int("window-height", height);
        return false;
    }

    public void format(string f){
        //((Doc)notebook.open_docs.nth_data(notebook.get_current_page())).run_javascript("formatDoc('"+f+"');");
    }

    public void switch_style(string f){
        //((Doc)notebook.open_docs.nth_data(notebook.get_current_page())).run_javascript("swapStyleSheet('"+f+"');");
        stdout.printf("swapStyleSheet('"+f+"');\n\n");
    }

    public Doc get_active_doc(){
        return new Doc();
        //return (Doc)notebook.open_docs.nth_data(notebook.get_current_page());
    }

    public void format_header(string f, string a){
        //stdout.printf("formatDoc('"+f+"','"+a+"');\n\n");
        //((Doc)notebook.open_docs.nth_data(notebook.get_current_page())).run_javascript("formatDoc('"+f+"','"+a+"');");
    }


    public void side_bar(){
        r.set_reveal_child(!r. get_child_revealed () );
    }


}
