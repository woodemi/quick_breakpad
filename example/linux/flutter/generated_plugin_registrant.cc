//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <quick_breakpad/quick_breakpad_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) quick_breakpad_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "QuickBreakpadPlugin");
  quick_breakpad_plugin_register_with_registrar(quick_breakpad_registrar);
}
