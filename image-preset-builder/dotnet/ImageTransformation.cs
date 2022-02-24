using System.Collections.Generic;
using System;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Contentstack.Image
{
    [JsonConverter(typeof(AssetMetadataConverter))]
    public class AssetMetadata
    {
        public List<AssetExtension> Extensions;
    }

    public class AssetExtension
    {
        public string Uid { get; set; }
        public List<ExtensionMetadata> ExtensionMetadata;

    }

    [JsonConverter(typeof(ExtensionMetadataConverter))]
    public class ExtensionMetadata
    {
        public List<Preset> Presets { get; set; }
        public Dictionary<string, object> Properties { get; set; }
    }

    public class Preset
    {
        public string Uid { get; set; }
        public string Name { get; set; }
        public Dictionary<string, object> Options { get; set; }
    }

    public class Transformation
    {
        public static string ResolvePreset(string url, AssetMetadata assetMetadata, string extenionUid, string presetName)
        {
            Preset preset = getPreset(assetMetadata, extenionUid, presetName: presetName);
            if (preset != null)
            {
                return getImageUrl(url, preset);
            }
            return url;

        }
        public static string ResolvePresetbyUid(string url, AssetMetadata assetMetadata, string extenionUid, string presetUid)
        {
            Preset preset = getPreset(assetMetadata, extenionUid, presetUid: presetUid);
            if (preset != null)
            {
                return getImageUrl(url, preset);
            }
            return url;
        }
        public static NameValueCollection ParseQueryString(string s)
        {
            NameValueCollection nvc = new NameValueCollection();

            if (s.Contains("?"))
            {
                s = s.Substring(s.IndexOf('?') + 1);
                foreach (string vp in Regex.Split(s, "&"))
                {
                    string[] singlePair = Regex.Split(vp, "=");
                    if (singlePair.Length == 2)
                    {
                        nvc.Add(singlePair[0], singlePair[1]);
                    }
                    else
                    {
                        // only one key with no value specified in query string
                        nvc.Add(singlePair[0], string.Empty);
                    }
                }
            }
            return nvc;
        }

        public static string ConstructQueryString(NameValueCollection parameters)
        {
            List<string> items = new List<string>();

            foreach (string name in parameters)
                items.Add(string.Concat(name, "=", parameters[name]));

            return string.Join("&", items.ToArray());
        }

        private static string getImageUrl(string url, Preset preset)
        {
            if (preset.Options != null)
            {
                Uri uri = new Uri(url);
                NameValueCollection queryString = ParseQueryString(url);
                if (preset.Options.ContainsKey("transform"))
                {
                    addTransform(ref queryString, (JObject)preset.Options["transform"]);
                }
                if (preset.Options.ContainsKey("image-type"))
                {
                    queryString.Add("format", (string)preset.Options["image-type"]);
                }
                if (preset.Options.ContainsKey("quality"))
                {
                    queryString.Add("quality", (string)preset.Options["quality"]);
                }
                if (preset.Options.ContainsKey("effects"))
                {
                    addEffects(ref queryString, (JObject)preset.Options["effects"]);
                }
                var queryParams = ConstructQueryString(queryString);
                if (queryParams.Length > 0)
                {
                    return $"{String.Format("{0}{1}{2}{3}", uri.Scheme, Uri.SchemeDelimiter, uri.Authority, uri.AbsolutePath)}?{ConstructQueryString(queryString)}";
                }
            }
            return url;
        }

        private static void addEffects(ref NameValueCollection queryString, JObject effects)
        {
            if (effects.ContainsKey("brightness"))
            {
                queryString.Add("brightness", (string)effects["brightness"]);
            }
            if (effects.ContainsKey("contrast"))
            {
                queryString.Add("contrast", (string)effects["contrast"]);
            }
            if (effects.ContainsKey("saturate"))
            {
                queryString.Add("saturation", (string)effects["saturate"]);
            }
            if (effects.ContainsKey("blur"))
            {
                queryString.Add("blur", (string)effects["blur"]);
            }
            if (effects.ContainsKey("sharpen") && effects["sharpen"].GetType() == typeof(JObject))
            {
                JObject sharpen = (JObject)effects["sharpen"];
                var amount = sharpen["amount"] ?? 0;
                var radius = sharpen["radius"] ?? 1;
                var threshold = sharpen["threshold"] ?? 0;
                queryString.Add("sharpen", $"a{amount},r{radius},t{threshold}");
            }
        }

        private static void addTransform(ref NameValueCollection queryString, JObject transform)
        {
            if (transform.ContainsKey("height"))
            {
                queryString.Add("height", (string)transform["height"]);
            }
            if (transform.ContainsKey("width"))
            {
                queryString.Add("width", (string)transform["width"]);
            }
            if (transform.ContainsKey("flip-mode"))
            {
                string flipMode = (string)transform["flip-mode"];
                if (flipMode == "both")
                {
                    queryString.Add("orient", "3");
                }
                else
                if (flipMode == "horiz")
                {
                    queryString.Add("orient", "2");
                }
                else
                if (flipMode == "verti")
                {
                    queryString.Add("orient", "4");
                }
            }
        }

        private static Preset getPreset(AssetMetadata assetMetadata, string extenionUid, string presetName = null, string presetUid = null)
        {
            Preset preset = null;
            if (assetMetadata.Extensions != null)
            {
                AssetExtension assetExtension = assetMetadata.Extensions.Find(extention =>
                {
                    return extention.Uid == extenionUid;
                });
                if (assetExtension != null)
                {
                    foreach (ExtensionMetadata extensionMetadata in assetExtension.ExtensionMetadata)
                    {
                        preset = extensionMetadata.Presets.Find(item =>
                        {
                            return item.Uid == presetUid || item.Name == presetName;
                        });
                        if (preset != null)
                        {
                            break;
                        }
                    }

                }
            }

            return preset;
        }
    }

    public class AssetMetadataConverter : JsonConverter<AssetMetadata>
    {
        public override AssetMetadata ReadJson(JsonReader reader, Type objectType, AssetMetadata existingValue, bool hasExistingValue, JsonSerializer serializer)
        {
            AssetMetadata metadata = new AssetMetadata();
            metadata.Extensions = new List<AssetExtension>();
            JObject jObject = JObject.Load(reader);
            if (jObject.GetValue("extensions") != null && jObject.GetValue("extensions").GetType() == typeof(JObject))
            {
                foreach (JProperty jProperty in (jObject.GetValue("extensions") as JObject).Properties())
                {
                    AssetExtension extension = new AssetExtension();
                    extension.Uid = jProperty.Name;
                    extension.ExtensionMetadata = new List<ExtensionMetadata>();
                    serializer.Populate(jProperty.Value.CreateReader(), extension.ExtensionMetadata);
                    metadata.Extensions.Add(extension);
                }
            }

            return metadata;
        }

        public override void WriteJson(JsonWriter writer, AssetMetadata value, JsonSerializer serializer)
        {

        }
    }

    public class ExtensionMetadataConverter : JsonConverter<ExtensionMetadata>
    {
        public override ExtensionMetadata ReadJson(JsonReader reader, Type objectType, ExtensionMetadata existingValue, bool hasExistingValue, JsonSerializer serializer)
        {
            ExtensionMetadata metadata = new ExtensionMetadata();

            JObject jObject = JObject.Load(reader);
            serializer.Populate(jObject.CreateReader(), metadata);
            metadata.Properties = jObject.ToObject<Dictionary<string, object>>();

            return metadata;
        }

        public override void WriteJson(JsonWriter writer, ExtensionMetadata value, JsonSerializer serializer)
        {

        }
    }
}