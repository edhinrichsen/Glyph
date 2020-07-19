
public class App : Gtk.Application {

    public App () {

        Object (
            application_id: "com.github.edhinrichsen.glyph",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new MainWindow(this);

    }

}
