import {
  reactive,
  watch
} from "./chunk-VBA7UMUT.js";

// ../../../node_modules/vitepress-plugin-tabs/src/client/index.ts
import PluginTabs from "/Users/lalonso/node_modules/vitepress-plugin-tabs/src/client/PluginTabs.vue";
import PluginTabsTab from "/Users/lalonso/node_modules/vitepress-plugin-tabs/src/client/PluginTabsTab.vue";

// ../../../node_modules/vitepress-plugin-tabs/src/client/useTabsSelectedState.ts
var injectionKey = "vitepress:tabSharedState";
var ls = typeof localStorage !== "undefined" ? localStorage : null;
var localStorageKey = "vitepress:tabsSharedState";
var getLocalStorageValue = () => {
  const rawValue = ls == null ? void 0 : ls.getItem(localStorageKey);
  if (rawValue) {
    try {
      return JSON.parse(rawValue);
    } catch {
    }
  }
  return {};
};
var setLocalStorageValue = (v) => {
  if (!ls)
    return;
  ls.setItem(localStorageKey, JSON.stringify(v));
};
var provideTabsSharedState = (app) => {
  const state = reactive(getLocalStorageValue());
  watch(state, (newState) => {
    setLocalStorageValue(newState);
  });
  app.provide(injectionKey, state);
};

// ../../../node_modules/vitepress-plugin-tabs/src/client/index.ts
var enhanceAppWithTabs = (app) => {
  provideTabsSharedState(app);
  app.component("PluginTabs", PluginTabs);
  app.component("PluginTabsTab", PluginTabsTab);
};
export {
  enhanceAppWithTabs
};
//# sourceMappingURL=vitepress-plugin-tabs_client.js.map
