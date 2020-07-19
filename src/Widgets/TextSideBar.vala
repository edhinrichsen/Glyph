public class TextSideBar : Gtk.Grid {

    public MainWindow main_window {get; construct;}

    public TextSideBar (MainWindow w){
        Object (
            main_window: w
        );
    }

    construct {
        var styles_manager = new StylesManager(main_window);
        styles_manager.switch_style(1);
        hexpand = false;
        margin = 14;
        var stack = new Gtk.Stack();
        stack.expand = true;

        var format = new Gtk.Grid();
        //format.margin_top = 8;
        format.attach(new TitleSpacer("Type"),0,0);
        var font = new Gtk.ComboBoxText ();
        font.can_focus = false;
        font.append_text ("Typeface") ;
        font.append_text ("San Serif");
        font.append_text ("Serif") ;
        format.attach(font,0,1);

        var bold = new SideButton("format-text-bold", "Bold");
        var italic = new SideButton("format-text-italic", "Italic");
        var underline = new SideButton("format-text-underline", "Underline");
        var strikethrough = new SideButton("format-text-strikethrough", "Strikethrough");

        bold.clicked.connect (()=> {main_window.format("bold");styles_manager.switch_style(0);});
        italic.clicked.connect (()=> {main_window.format("italic");styles_manager.switch_style(1);});
        underline.clicked.connect (()=> {main_window.format("underline");});
        strikethrough.clicked.connect (()=> {main_window.format("strikethrough");});

        var format_text_grid = new Gtk.Grid ();
        format_text_grid.get_style_context ().add_class ("linked");
        format_text_grid.valign = Gtk.Align.CENTER;
        format_text_grid.margin_top = 8;

        format_text_grid.add (bold);
        format_text_grid.add (italic);
        format_text_grid.add (underline);
        format_text_grid.add (strikethrough);

        format.attach(format_text_grid,0,2);

        format.attach(new TitleSpacer("Set"),0,3);

        var left = new SideButton("format-justify-left", "Justify Left");
        var center = new SideButton("format-justify-center", "Justify Center");
        var fill = new SideButton("format-justify-fill", "Justify Fill");
        var right = new SideButton("format-justify-right", "Justify Right");

        left.clicked.connect (()=> {main_window.format("justifyleft");});
        center.clicked.connect (()=> {main_window.format("justifycenter");});
        fill.clicked.connect (()=> {main_window.format("justifyFull");});
        right.clicked.connect (()=> {main_window.format("justifyright");});

        var justify_grid = new Gtk.Grid ();
        justify_grid.get_style_context ().add_class ("linked");
        justify_grid.valign = Gtk.Align.CENTER;
        //justify_grid.margin_top = 8;

        justify_grid.add (left);
        justify_grid.add (center);
        justify_grid.add (fill);
        justify_grid.add (right);

        format.attach(justify_grid,0,4);


        var style = new Gtk.Grid();
        //style.margin_top = 8;
        style.attach(new TitleSpacer("Theme"),0,0);

        var theme_grid = new Gtk.Grid ();
        theme_grid.get_style_context ().add_class ("linked");
        theme_grid.valign = Gtk.Align.CENTER;


        var box = new Gtk.ComboBoxText ();
        box.append_text ("Default") ;
        box.append_text ("San Serif");
        box.append_text ("Serif") ;
        box.hexpand = true;

        theme_grid.add(box);

        var edit_theme = new SideButton ("list-add", "Edit Theme");
        theme_grid.add(edit_theme);

        style.attach(theme_grid,0,1);

        style.attach(new TitleSpacer("Styles"),0,2);

        stack.add_titled(style, "text", "Text");
        stack.add_titled(format, "image", "Image");
        stack.add_titled(new Gtk.Grid(), "page", "Page");


        style.attach(new StyleButton(main_window,"Paragraph","Paragraph","p"),0,3);
        style.attach(new StyleButton(main_window,"Heading 1","Heading 1","h1"),0,4);
        style.attach(new StyleButton(main_window,"Heading 2","Heading 2","h2"),0,5);
        style.attach(new StyleButton(main_window,"Heading 3","Heading 3","h3"),0,6);
        style.attach(new StyleButton(main_window,"Heading 4","Heading 4","h4"),0,7);
        style.attach(new StyleButton(main_window,"Heading 5","Heading 5","h5"),0,8);
        style.attach(new StyleButton(main_window,"Subtitle","Subtitle","h6"),0,9);

        var stack_switcher = new Gtk.StackSwitcher();
        stack_switcher.set_homogeneous(true);
        stack_switcher.stack = stack;
        attach(stack_switcher,0,0);
        attach(stack,0,1);
        //add(stack);
        //hide = true;
    }
}

protected class TitleSpacer : Gtk.Grid {

    public TitleSpacer (string text) {
        margin_top = 16;
        margin_bottom = 8;
        var label = new Gtk.Label(text);
        hexpand = true;

        attach(label,0,0);
        var separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        separator.hexpand = true;
        separator.margin = 8;

        attach(separator,1,0);
    }
}

protected class SideButton : Gtk.Button {

    public SideButton (string icon_name, string description) {
        can_focus = false;

        Gtk.Image image = new Gtk.Image.from_icon_name (icon_name+"-symbolic", Gtk.IconSize.BUTTON);
        //Gtk.Image image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
        image.margin = 2;

        //get_style_context ().add_class ("spice");
        set_tooltip_markup (description);
        this.add (image);
    }

}

protected class StyleButton : Gtk.Grid {

public MainWindow main_window {get; construct;}


    public StyleButton (MainWindow w, string name, string description, string tag) {
    Object (
        main_window: w
    );


        can_focus = false;

        var buffer = new Gtk.TextBuffer(new Gtk.TextTagTable ());
        buffer.text = name;

        //buffer.get_start_iter(s);
        //buffer.get_end_iter(e);
        //e.forward_to_end ();
        //buffer. apply_tag_by_name("tag",s,e);
        var label = new Gtk.TextView.with_buffer  (buffer);
        label.get_style_context ().add_class(tag);
        label.editable = false;
        label.cursor_visible = false;

        //Gtk.Image image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.BUTTON);
        //label.margin = 2;
        //label.editable= true;

        label.height_request = 40;
        margin_bottom = 8;
        label.hexpand = true;

        //label.set_markup ("""<span style='color:red;'>Title</span>""");
        //get_style_context ().add_class ("spice");
        set_tooltip_markup (description);
        //attach (label,0,0);
        var label_button = new Gtk.Button();
        label_button.add(label);
        label_button.can_focus = false;

        var edit = new SideButton("edit","Edit Style...");
        edit.can_focus = false;

        get_style_context ().add_class ("linked");
        attach (label_button,0,0);
        attach (edit,1,0);

        label_button.clicked.connect (()=> {main_window.format_header("formatblock",tag);});
    }

}

protected class StylesManager : GLib.Object {

    public MainWindow main_window {get; construct;}

    private Gtk.CssProvider css_provider = new Gtk.CssProvider();

    public List<Style> styles = new List<Style> ();

    public StylesManager (MainWindow w){
        Object (
            main_window: w
        );
            var style0 = """
                .p, p, body {
                    font-family: "Source Sans Pro";
                    font-size: 10.5pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;
                }

                .h1, h1 {
                    font-family: "Source Serif Pro";
                    font-size: 24pt;
                    font-weight: bold;
                    font-style: normal;
                    opacity: 1;
                }

                .h2, h2 {
                    font-family: "Source Serif Pro";
                    font-size: 20pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;
                }

                .h3, h3 {
                    font-family: "Source Serif Pro";
                    font-size: 14pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;
                }

                .h4, h4 {
                    font-family: "Source Sans Pro";
                    font-size: 12pt;
                    font-weight: bold;
                    font-style: normal;
                    opacity: 1;
                }

                .h5, h5 {
                    font-family: "Source Sans Pro";
                    font-size: 12pt;
                    font-weight: normal;
                    font-style: italic;
                    opacity: 1;
                }

                .h6, h6 {
                    font-family: "Source Sans Pro";
                    font-size: 12pt;
                    font-weight: normal;
                    font-style: italic;
                    opacity: 0.5;
                }


            """;

            var style1 = """


                .p-glyph, p, body {
                    font-family: "Raleway";
                    font-size: 10pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;

                }

                .h2 {
                    font-family: "Raleway";
                    font-size: 16pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 0.6;

                }

                .h3 {
                    font-family: "Raleway";
                    font-size: 11pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;

                }

                .dim-lable{
                    font-family: "Raleway";
                    font-size: 11pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;
                }

                .h1-glyph, .h1, h1 {
                    font-family: "Playfair Display";
                    font-size: 24pt;
                    font-weight: bold;
                    font-style: normal;
                    opacity: 1;

                }

                .h2-glyph, h2 {
                    font-family: "Playfair Display";
                    font-size: 20pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;

                }

                .h3-glyph, h3 {
                    font-family: "Playfair Display";
                    font-size: 14pt;
                    font-weight: normal;
                    font-style: normal;
                    opacity: 1;

                }

                .h4-glyph, h4 {
                    font-family: "Raleway";
                    font-size: 11pt;
                    font-weight: bold;
                    font-style: normal;
                    opacity: 1;

                }

                .h5-glyph, h5 {
                    font-family: "Raleway";
                    font-size: 11pt;
                    font-weight: normal;
                    font-style: italic;
                    opacity: 1;

                }

                .h6-glyph, h6 {
                    font-family: "Raleway";
                    font-size: 11pt;
                    font-weight: normal;
                    font-style: italic;
                    opacity: 0.5;

                }


            """;
        styles.append(new Style("one", style0));
        styles.append(new Style("two", style1));
    }

    public void switch_style(int i){

        try {
            css_provider.load_from_data(styles.nth_data(i).style, -1);
        } catch (GLib.Error e) {
            warning ("Failed to parse css style : %s", e.message);
        }

        Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        //main_window.switch_style(styles.nth_data(i).style);

       //main_window.get_active_doc().stylesheet = styles.nth_data(i).style;
       //main_window.get_active_doc().update_html_view();
    }
}

protected class Style : GLib.Object {

    public string name {get; set;}
    public string style {get; set;}


    public Style (string n, string s){
        Object (
            name: n,
            style: s
        );

    }

}
