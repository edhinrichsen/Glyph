public class Notebook : Granite.Widgets.DynamicNotebook {

    public List<Gtk.Box> open_docs = new List<Gtk.Box>();
    private static Notebook notebook {get; set;}

    public static Notebook get_book(){
        if (notebook == null){
            notebook = new Notebook();
        }
        return notebook;
    }

    public void format_open_doc(string arg1, string? arg2 = null) {
        if (arg2 == null){
            ((Doc)current.page).run_javascript("formatDoc('"+arg1+"')");
        } else {
            ((Doc)current.page).run_javascript("formatDoc('"+arg1+"','"+arg2+"')");
        }
    }

    public void format_box(string? styleClass = null, string? displayClass = null){
        //  ((Doc)current.page).run_javascript("formatBox('"+arg1+"','"+arg2+"')");
        if (styleClass != null){
            ((Doc)current.page).run_javascript("setStyle('"+styleClass+"')");
        }

        if (displayClass != null) {
            ((Doc)current.page).run_javascript("setDisplay('"+displayClass+"')");
        }
        
        //  stdout.printf ("formatBox('"+style+"')");
    }

    public void format_line(string style){
        ((Doc)current.page).run_javascript("formatBox('"+style+"')");
    }

    public void new_welcome_page(){
        notebook.insert_tab(new Granite.Widgets.Tab("Glyph", null, new Welcome()),0);
        current = get_tab_by_index(0);
    }

    public void new_page(File? file = null){
        //notebook.open_docs.append(new Doc(this));
        var d = new Doc();
        if (file != null){
            d.load(file);
        }
        current.label = "New Document";
        current.page = d;
        //notebook.insert_tab(new Granite.Widgets.Tab("New Doc", null, d),0);
    }

    public Notebook (){

    }

    construct {
        //open_docs.append(new Doc(main_window));
        //open_docs.append(new Doc(main_window));
        insert_tab(new Granite.Widgets.Tab("Glyph", null, new Welcome()),0);
        //show_tabs = false;
        //show_border = false;
        //append_page (open_docs.nth_data(0), new Gtk.Label("New Document")) ;

        // switch_page.connect (page => {
        //     //main_window.header.title = get_tab_label_text(page);
        // });
        //show_tabs = false;
        tab_added.connect (() => {
        stdout.printf("%d",n_tabs);
            if (n_tabs > 1){
                show_tabs = false;
            }
        });

        tab_removed.connect (() => {
            if (n_tabs < 1){
                new_welcome_page();
                show_tabs = false;
            }
        });

        new_tab_requested.connect (new_welcome_page);


        show_all ();
    }



}
