public class Welcome : Gtk.Box {


   private Granite.Widgets.Welcome welcome;
       //private Spice.Widgets.Library.Library? library = null;
       //private Spice.Widgets.Library.Library? templates = null;
       private Gtk.Separator separator;
       private Gtk.Stack welcome_stack;

   public Welcome () {

       }

    construct {
        welcome = new Granite.Widgets.Welcome ("Glyph", "Make Beautiful Documents");
        welcome.hexpand = true;

        welcome.append ("document-new-symbolic", "New Document", "Create a new document");
        welcome.append ("folder-open-symbolic", "Open File", "Open a saved document");

        separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);

        welcome_stack = new Gtk.Stack ();
        welcome_stack.add_named (welcome, "welcome");
        welcome_stack.set_visible_child (welcome);

        add (welcome_stack);
        add (separator);

        welcome.activated.connect ((index) => {
        switch (index) {
            case 0:
                Notebook.get_book().new_page();
                break;
            case 1:

            Notebook.get_book().new_page(FileManager.open_presentation());

                //var file = Spice.Services.FileManager.open_presentation ();
                //if (file != null) open_file (file);
                break;
            }
        });

    }

}
