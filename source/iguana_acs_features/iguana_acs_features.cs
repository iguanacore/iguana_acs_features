using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FairyGUI;
using ModLoaderLite.Config;
using ModLoaderLite;

namespace iguana_acs_features
{
    public class iguana_acs_features
    {
        public static bool configLoaded = false;
        public static Dictionary<string, bool> config = new Dictionary<string, bool>()
            {
                { "Qi Overlay rework", LingTexRework.enabled},
                { "Custom Titles", TitleCreator.enabled }

            };
        static void OnLoadInit(string funcName)
        {
            Dictionary<string, bool> loadConfig = MLLMain.GetSaveOrDefault<Dictionary<string, bool>>("iguana_acs_features_config");
            if (loadConfig != null)
            {
                // We don't directly overwrite as we must handle loaded configs from previous versions of the mod
                foreach (KeyValuePair<string, bool> kvp in loadConfig)
                {
                    config[kvp.Key] = kvp.Value;
                };
            }
            if (!Configuration.ListItems.ContainsKey("iguana_acs_features"))
            {
                foreach (KeyValuePair<string, bool> kvp in config)
                {
                    Configuration.AddCheckBox("iguana_acs_features", kvp.Key, kvp.Key, kvp.Value);
                }
                Configuration.Subscribe(new EventCallback0(HandleConfig));
            }
            HandleConfig(); // Needed or the loaded config isn't applied immediately
            configLoaded = true;
        }

        public static void OnInit()
        {
            OnLoadInit("OnInit");
        }
        public static void OnLoad()
        {
            OnLoadInit("OnLoad");
        }
        public static void OnSave()
        {
            MLLMain.AddOrOverWriteSave("iguana_acs_features_config", config);

        }

        private static void HandleConfig()
        {
            LingTexRework.enabled = Configuration.GetCheckBox("iguana_acs_features", "Qi Overlay Rework");
            TitleCreator.enabled = Configuration.GetCheckBox("iguana_acs_features", "Custom Title");

            Dictionary<string, bool> newConfig = new Dictionary<string, bool>();
            foreach (KeyValuePair<string, bool> kvp in config)
            {
                bool newValue = Configuration.GetCheckBox("iguana_acs_features", kvp.Key);
                if (kvp.Value != newValue)
                {
                    newConfig[kvp.Key] = newValue;
                }
            }
            foreach (KeyValuePair<string, bool> kvp in newConfig)
            {
                config[kvp.Key] = kvp.Value;
            }
        }
    }
}
