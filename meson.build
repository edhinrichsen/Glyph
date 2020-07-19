# project name and programming language
project('com.github.edhinrichsen.glyph', 'vala', 'c')
# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Application.vala',
    'src/Widgets/Window.vala',
    'src/Widgets/Header.vala',
    'src/Widgets/Preview.vala',
    'src/Widgets/Notebook.vala',
    'src/Widgets/TextSideBar.vala',
    'src/Widgets/Welcome.vala',
    'src/Document/Doc.vala',
    'src/Document/HTML.vala',
    'src/Document/FileManager.vala',
    'src/Main.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('webkit2gtk-4.0'),
        dependency('granite')
    ],
    install: true
)

# Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications')
)

# Install our .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', meson.project_name() + '.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

install_data(
    'data/Gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas'),
    rename: meson.project_name() + '.gschema.xml'
)

meson.add_install_script('post_install.py')
