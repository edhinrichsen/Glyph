public class Header : Gtk.HeaderBar {
    public MainWindow main_window {get; construct;}

    public Header (MainWindow w){
        Object (
            main_window: w
        );
    }
    construct {
        title = "Untitled Document";
        subtitle = "Saved";
        show_close_button = true;

        var new_button = new Gtk.Button.from_icon_name("open-menu-symbolic", Gtk.IconSize.BUTTON);
        new_button.valign = Gtk.Align.CENTER;
        pack_end (new_button);

        var open = new HeaderbarButton("document-new", "Open/New Document...");
        var save = new HeaderbarButton("document-export", "Export As..."); //document-save-as

        open.clicked.connect (()=> {Notebook.get_book().new_welcome_page();});
        save.clicked.connect (()=> {Notebook.get_book().show_tabs = false;});


        var open_save_grid = new Gtk.Grid ();
        open_save_grid.get_style_context ().add_class ("linked");
        open_save_grid.valign = Gtk.Align.CENTER;

        open_save_grid.add (open);
        open_save_grid.add (save);
        pack_start (open_save_grid);


        var undo = new HeaderbarButton("edit-undo", "Undo");
        var redo = new HeaderbarButton("edit-redo", "Redo");

        undo.clicked.connect (()=> {main_window.format("undo");});
        redo.clicked.connect (()=> {main_window.format("redo");});

        var undo_redo_grid = new Gtk.Grid ();
        undo_redo_grid.get_style_context ().add_class ("linked");
        undo_redo_grid.valign = Gtk.Align.CENTER;

        undo_redo_grid.add (undo);
        undo_redo_grid.add (redo);
        pack_start (undo_redo_grid);



        var text = new HeaderbarToggleButton("applications-graphics", "Text...");
        //var insert = new HeaderbarToggleButton("emblem-photos", "Image...");
        //var page = new HeaderbarToggleButton("text-x-generic", "Page..."); //emblem-documents

        text.toggled.connect (()=> {
            main_window.side_bar();
            //insert.set_active(false);
            //page.set_active(false);
        });


        var controls_grid = new Gtk.Grid ();
        controls_grid.get_style_context ().add_class ("linked");
        controls_grid.valign = Gtk.Align.CENTER;

        controls_grid.add (text);
        //controls_grid.add (insert);
        //controls_grid.add (page);
        pack_end (controls_grid);


        var style = new HeaderbarButton("font-x-generic", "Style...");
        var more = new HeaderbarButton("view-more-horizontal", "More...");




        var style_menu = new StyleMenu(style);

        var more_menu = new MoreMenu(main_window,more);



        //more_menu.show_all();


        style.clicked.connect (()=> {
            style_menu.popup();
            style_menu.show_all();
        });
        more.clicked.connect (()=> {
            more_menu.popup();
            more_menu.show_all();
        });


        var format_text_grid = new Gtk.Grid ();
        format_text_grid.get_style_context ().add_class ("linked");
        format_text_grid.valign = Gtk.Align.CENTER;

        format_text_grid.add (style);
        format_text_grid.add (more);


        pack_end (format_text_grid);
    }
}




protected class HeaderbarButton : Gtk.Button {

    public HeaderbarButton (string icon_name, string description) {
        can_focus = false;

        Gtk.Image image = new Gtk.Image.from_icon_name (icon_name+"-symbolic", Gtk.IconSize.BUTTON);
        //Gtk.Image image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
        image.margin = 2;

        //get_style_context ().add_class ("spice");
        set_tooltip_markup (description);
        this.add (image);
    }

}

protected class HeaderbarToggleButton : Gtk.ToggleButton {

    public HeaderbarToggleButton (string icon_name, string description) {
        can_focus = false;

        Gtk.Image image = new Gtk.Image.from_icon_name (icon_name+"-symbolic", Gtk.IconSize.BUTTON);
        //Gtk.Image image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
        image.margin = 2;

        //get_style_context ().add_class ("spice");
        set_tooltip_markup (description);
        this.add (image);
    }

}

protected class StyleMenu : Gtk.Popover {

    public StyleMenu (Gtk.Widget r){
        Object (
            relative_to: r
        );
    }

    construct {

        var grid = new Gtk.Grid();

        grid.attach(new StyleButtonHeader("Paragraph","Paragraph","p"),0,3);
        grid.attach(new StyleButtonHeader("Heading 1","Heading 1","h1"),0,4);
        grid.attach(new StyleButtonHeader("Heading 2","Heading 2","h2"),0,5);
        grid.attach(new StyleButtonHeader("Heading 3","Heading 3","h3"),0,6);
        grid.attach(new StyleButtonHeader("Heading 4","Heading 4","h4"),0,7);
        grid.attach(new StyleButtonHeader("Heading 5","Heading 5","h5"),0,8);
        grid.attach(new StyleButtonHeader("Subtitle","Subtitle","h6"),0,9);
        grid.attach(new StyleButtonHeader("Heading 7","Heading 7","header"),0,10);

        var setings = new Gtk.Button.from_icon_name("edit-symbolic", Gtk.IconSize.BUTTON);

        setings.clicked.connect (()=> {
            popdown();
        });


        grid.attach(setings,0,10);

        grid.margin = 4;

        add(grid);

    }

}

protected class StyleButtonHeader : Gtk.Grid {

    public StyleButtonHeader (string name, string description, string tag) {
        Object ();

        can_focus = false;

        var buffer = new Gtk.TextBuffer(new Gtk.TextTagTable ());
        buffer.text = name;

        var label = new Gtk.TextView.with_buffer(buffer);
        label.get_style_context ().add_class(tag+"-glyph");
        label.editable = false;
        label.cursor_visible = false;


        label.height_request = 40;
        margin_bottom = 8;
        label.hexpand = true;

        set_tooltip_markup (description);

        var label_button = new Gtk.Button();
        label_button.add(label);
        label_button.can_focus = false;

        attach (label_button,0,0);

        label_button.clicked.connect (()=> {Notebook.get_book().format_box("glyph-"+tag, null);});
    }

}

protected class MoreMenu : Gtk.Popover {

    public MainWindow main_window {get; construct;}

    public MoreMenu (MainWindow w, Gtk.Widget r){
        Object (
            main_window: w,
            relative_to: r
        );
    }

    construct {

        var grid = new Gtk.Grid();

        var setings = new Gtk.Button.from_icon_name("edit-symbolic", Gtk.IconSize.BUTTON);

        var decoration = new text_decoration(main_window);

        grid.attach(decoration,0,0);
        grid.attach(new text_lines(main_window),1,0);
        grid.attach(new dot_points(main_window),2,0);
        grid.attach(new insert(main_window),3,0);
        grid.attach(new color_picker(main_window),4,0);

        grid.attach(setings,5,0);

        setings.clicked.connect (()=> {decoration.edit_mode_header();});

        grid.margin = 4;

        add(grid);

    }

}

protected class text_decoration : Gtk.Grid{

    public MainWindow main_window {get; construct;}

    public text_decoration (MainWindow w){
        Object (
            main_window: w
        );
    }
    //private Gtk.Grid grid = new Gtk.Grid();
    private Gtk.Revealer add_to_header = new Gtk.Revealer();
    private Gtk.Revealer remove_from_header = new Gtk.Revealer();

    construct {

        var inner_grid = new Gtk.Grid();
        var outer_grid = new Gtk.Grid();


        var bold = new HeaderbarButton("format-text-bold", "Bold");
        var italic = new HeaderbarButton("format-text-italic", "Italic");

        //add_to_header.add(new HeaderbarButton("go-up", "Add To Quick Access"));
        add_to_header.add(new Gtk.Button.from_icon_name("go-up-symbolic", Gtk.IconSize.BUTTON));
        add_to_header.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT ;

        remove_from_header.add(new Gtk.Button.from_icon_name("go-down-symbolic", Gtk.IconSize.BUTTON));
        remove_from_header.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT ;


        bold.hexpand = true;
        italic.hexpand = true;
        add_to_header.hexpand = false;

        inner_grid.attach(bold,0,0);
        inner_grid.attach(italic,1,0);
        outer_grid.attach(inner_grid,0,0);
        outer_grid.attach(add_to_header,1,0);
        outer_grid.attach(remove_from_header,1,0);
        //add_to_header.set_reveal_child(true);

        //popdown();
        bold.clicked.connect (()=> {Notebook.get_book().format_open_doc("bold"); });
        italic.clicked.connect (()=> {Notebook.get_book().format_open_doc("italic");});

        inner_grid.get_style_context ().add_class ("linked");
        inner_grid.margin = 4;

        add(outer_grid);
    }

    public void edit_mode_popover(){
        //var add =
        add_to_header.set_reveal_child(!add_to_header.get_reveal_child());
    }
    public void edit_mode_header(){
        remove_from_header.set_reveal_child(!remove_from_header.get_reveal_child());
    }


}

protected class text_lines : Gtk.Grid{

    public MainWindow main_window {get; construct;}

    public text_lines (MainWindow w){
        Object (
            main_window: w
        );
    }
    construct{

        var grid = new Gtk.Grid();

        var underline = new HeaderbarButton("format-text-underline", "Underline");
        var strikethrough = new SideButton("format-text-strikethrough", "Strikethrough");
        underline.hexpand = true;
        strikethrough.hexpand = true;

        grid.attach(underline,2,0);
        grid.attach(strikethrough,3,0);

        underline.clicked.connect (()=> {Notebook.get_book().format_open_doc("underline"); });
        strikethrough.clicked.connect (()=> {Notebook.get_book().format_open_doc("strikethrough"); });

        grid.get_style_context ().add_class ("linked");
        grid.margin = 4;

        this.add(grid);
    }
}

protected class dot_points : Gtk.Grid{

    public MainWindow main_window {get; construct;}

    public dot_points (MainWindow w){
        Object (
            main_window: w
        );
    }

    construct {

        var grid = new Gtk.Grid();

        var numbered = new HeaderbarButton("format-justify-fill", "Numbered List");
        var bulleted = new HeaderbarButton("format-justify-fill", "Bulleted List");

        numbered.hexpand = true;
        bulleted.hexpand = true;

        grid.attach(numbered,0,0);
        grid.attach(bulleted,1,0);

        numbered.clicked.connect (()=> {Notebook.get_book().format_box(null, "glyph-ul"); });
        bulleted.clicked.connect (()=> {Notebook.get_book().format_box(null, "glyph-block"); });

        grid.get_style_context ().add_class ("linked");
        grid.margin = 4;

        add(grid);
    }

}

protected class insert : Gtk.Grid{

    public MainWindow main_window {get; construct;}

    public insert (MainWindow w){
        Object (
            main_window: w
        );
    }

    construct{

        var grid = new Gtk.Grid();

        var image = new HeaderbarButton("insert-image", "Numbered List");
        var link = new HeaderbarButton("insert-link", "Bulleted List");

        image.hexpand = true;
        link.hexpand = true;

        grid.attach(image,0,0);
        grid.attach(link,1,0);

        image.clicked.connect (()=> {Notebook.get_book().format_open_doc("insertunorderedlist"); });
        link.clicked.connect (()=> {Notebook.get_book().format_open_doc("insertorderedlist"); });

        grid.get_style_context ().add_class ("linked");
        grid.margin = 4;

        add(grid);
    }

}

protected class color_picker : Gtk.Grid{

    public MainWindow main_window {get; construct;}

    public color_picker (MainWindow w){
        Object (
            main_window: w
        );
    }

    construct{
        var grid = new Gtk.Grid();

        var col = Gdk.RGBA();
        col.alpha = 1;
        col.red = 0.98;
        col.green = 0.77;
        col.blue = 0.25;


        var text = new HeaderbarButton("insert-text", "Numbered List");
        var color = new Gtk.ColorButton.with_rgba(col);

        text.hexpand = true;
        color.hexpand = true;

        grid.attach(text,0,0);
        grid.attach(color,1,0);

        text.clicked.connect (()=> {
            var red = color.get_rgba().red * 255;
            var green = color.get_rgba().green * 255;
            var blue = color.get_rgba().blue * 255;
            Notebook.get_book().format_open_doc("backcolor","rgb(%f,%f,%f)".printf(red,green,blue));
            //popdown();
            //stdout.printf("red: %f green %f, blue %f", link.get_rgba().red, link.get_rgba().green, link.get_rgba().blue);
        });
        //link.clicked.connect (()=> {main_window.format("insertorderedlist");});

        grid.get_style_context ().add_class ("linked");
        grid.margin = 4;

        add(grid);
    }


}


