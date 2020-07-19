
public class FileManager {

    public static File? open_presentation () {
        File? result = null;

        List<Gtk.FileFilter> filters = new List<Gtk.FileFilter> ();
        Gtk.FileFilter filter = new Gtk.FileFilter ();
        filter.set_filter_name ("Document");
        filter.add_mime_type ("text/xml");

        filters.append (filter);

        result = get_file_from_user ("Open file", "Open", Gtk.FileChooserAction.OPEN, filters);

        return result;
    }

    private static File get_file_from_user (string title, string accept_button_label, Gtk.FileChooserAction chooser_action, List<Gtk.FileFilter> filters) {
        File? result = null;

        var dialog = new Gtk.FileChooserDialog (
        title,
        null,
        chooser_action,
        "Cancel", Gtk.ResponseType.CANCEL,
        accept_button_label, Gtk.ResponseType.ACCEPT);

        var all_filter = new Gtk.FileFilter ();
        all_filter.set_filter_name ("All Files");
        all_filter.add_pattern ("*");

        filters.append (all_filter);

        filters.@foreach ((filter) => {
        dialog.add_filter (filter);
        });

        if (dialog.run () == Gtk.ResponseType.ACCEPT) {
        result = dialog.get_file ();
        }

        dialog.close ();

        return result;
    }

    }

