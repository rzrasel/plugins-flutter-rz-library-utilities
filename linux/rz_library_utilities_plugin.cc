#include "include/rz_library_utilities/rz_library_utilities_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#include "rz_library_utilities_plugin_private.h"

#define RZ_LIBRARY_UTILITIES_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), rz_library_utilities_plugin_get_type(), \
                              RzLibraryUtilitiesPlugin))

struct _RzLibraryUtilitiesPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(RzLibraryUtilitiesPlugin, rz_library_utilities_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void rz_library_utilities_plugin_handle_method_call(
    RzLibraryUtilitiesPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0) {
    response = get_platform_version();
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

FlMethodResponse* get_platform_version() {
  struct utsname uname_data = {};
  uname(&uname_data);
  g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
  g_autoptr(FlValue) result = fl_value_new_string(version);
  return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}

static void rz_library_utilities_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(rz_library_utilities_plugin_parent_class)->dispose(object);
}

static void rz_library_utilities_plugin_class_init(RzLibraryUtilitiesPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = rz_library_utilities_plugin_dispose;
}

static void rz_library_utilities_plugin_init(RzLibraryUtilitiesPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  RzLibraryUtilitiesPlugin* plugin = RZ_LIBRARY_UTILITIES_PLUGIN(user_data);
  rz_library_utilities_plugin_handle_method_call(plugin, method_call);
}

void rz_library_utilities_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  RzLibraryUtilitiesPlugin* plugin = RZ_LIBRARY_UTILITIES_PLUGIN(
      g_object_new(rz_library_utilities_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "rz_library_utilities",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
