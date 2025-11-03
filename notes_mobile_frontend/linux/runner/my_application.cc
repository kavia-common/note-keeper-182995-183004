#include "my_application.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

struct _MyApplication {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

static void my_application_activate(GApplication* application) {
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));
  gtk_window_set_title(window, "notes_mobile_frontend");
  gtk_window_set_default_size(window, 800, 600);

  // Create a Flutter project and view.
  FlDartProject* project = fl_dart_project_new();
  FlView* view = fl_view_new(project);
  gtk_window_set_child(window, GTK_WIDGET(view));

  gtk_window_present(window);
}

static void my_application_class_init(MyApplicationClass* klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
}

static void my_application_init(MyApplication* self) {}

MyApplication* my_application_new() {
  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id",
                                     "com.example.notes_mobile_frontend",
                                     "flags", G_APPLICATION_FLAGS_NONE, nullptr));
}
