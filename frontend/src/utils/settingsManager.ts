// settingsManager.ts
import { Setting } from "../types";

let memorySettings: Setting | null = null;

export const settingsManager = {
  set: (settings: Setting) => {
    memorySettings = settings;
    localStorage.setItem("app_settings", JSON.stringify(settings));
  },

  get: (): Setting | null => {
    if (memorySettings) {
      return memorySettings;
    }
    const saved = localStorage.getItem("app_settings");
    if (saved) {
      try {
        memorySettings = JSON.parse(saved);
        return memorySettings;
      } catch (e) {
        console.error("Failed to parse app_settings from localStorage", e);
        return null;
      }
    }
    return null;
  },

  clear: () => {
    memorySettings = null;
    localStorage.removeItem("app_settings");
  },
};
