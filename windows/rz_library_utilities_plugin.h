#ifndef FLUTTER_PLUGIN_RZ_LIBRARY_UTILITIES_PLUGIN_H_
#define FLUTTER_PLUGIN_RZ_LIBRARY_UTILITIES_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace rz_library_utilities {

class RzLibraryUtilitiesPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  RzLibraryUtilitiesPlugin();

  virtual ~RzLibraryUtilitiesPlugin();

  // Disallow copy and assign.
  RzLibraryUtilitiesPlugin(const RzLibraryUtilitiesPlugin&) = delete;
  RzLibraryUtilitiesPlugin& operator=(const RzLibraryUtilitiesPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace rz_library_utilities

#endif  // FLUTTER_PLUGIN_RZ_LIBRARY_UTILITIES_PLUGIN_H_
