#include "include/rz_library_utilities/rz_library_utilities_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "rz_library_utilities_plugin.h"

void RzLibraryUtilitiesPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  rz_library_utilities::RzLibraryUtilitiesPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
