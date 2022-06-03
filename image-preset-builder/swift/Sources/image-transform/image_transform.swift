import Foundation

public final class AssetModel: Decodable {
    public var title: String

    public var uid: String
    public var url: String

    public var metadata: AssetMetadata?
    
    public enum FieldKeys: String, CodingKey {
        case title, uid, url
        case metadata = "_metadata"
        
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        title = try container.decode(String.self, forKey: .title)
        uid = try container.decode(String.self, forKey: .uid)
        url = try container.decode(String.self, forKey: .url)
        metadata = try container.decodeIfPresent(AssetMetadata.self, forKey: .metadata)
    }
}

public class AssetMetadata: Decodable {
    public var extensions: [String: [ExtensionMetadata]]
    
    public enum FieldKeys: String, CodingKey {
        case extensions
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        extensions = try container.decodeIfPresent(Dictionary<String, [ExtensionMetadata]>.self, forKey: .extensions) ?? [:]
    }
}

public class ExtensionMetadata: Decodable {
    public var presets: [Preset]
    public var properties: [String: Any]
    public enum FieldKeys: String, CodingKey {
        case presets, properties
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        presets = try container.decodeIfPresent([Preset].self, forKey: .presets) ?? []
        properties = try container.decodeIfPresent(Dictionary<String, Any>.self, forKey: .properties) ?? [:]
    }
}

public class Preset: Decodable {
    public var uid: String
    public var name: String
    public var options: [String: Any]
    public enum FieldKeys: String, CodingKey {
        case uid, name, options
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        name = try container.decode(String.self, forKey: .name)
        options = try container.decodeIfPresent(Dictionary<String, Any>.self, forKey: .options) ?? [:]
    }
}


public class ImageTransform {
    public static func resolvePreset(_ url: String, assetMetadata: AssetMetadata, extensionUid: String, presetName: String? = nil, presetUid: String? = nil) -> String {
        
        if let preset = ImageTransform.getPreset(metadata: assetMetadata, extensionUid: extensionUid, presetName: presetName, presetUid: presetUid),
           preset.options.count > 0 {
            return ImageTransform.transformUrl(url, options: preset.options)
        }
        return url
    }
    
    static func getPreset(metadata: AssetMetadata, extensionUid: String, presetName: String? = nil, presetUid: String? = nil) -> Preset? {
        
        if metadata.extensions.keys.contains(extensionUid),
           let ext = metadata.extensions[extensionUid] {
            
            let presets = ext.compactMap { extensionMetadata in
                return extensionMetadata.presets.first { preset in
                    return preset.uid == presetUid || preset.name == presetName
                }
            }
            if let preset = presets.first {
                return preset
            }
        }
        return nil
    }
    
    static func transformUrl(_ url: String, options: [String: Any]) -> String {
        var urlComponent = URLComponents(string: url)
        if urlComponent?.queryItems == nil {
            urlComponent?.queryItems = []
        }
        if let transform = options["transform"] as? [String: Any] {
            ImageTransform.addTransform(urlComponent: &urlComponent!, transform: transform)
        }

        if let imageType = options["image-type"] as? String {
            urlComponent?.queryItems?.append(URLQueryItem(name: "format", value: imageType))
        }

        if let quality = options["quality"] as? String {
            urlComponent?.queryItems?.append(URLQueryItem(name: "quality", value: quality))
        }

        if let effects = options["effects"] as? [String: Any] {
            ImageTransform.addEffects(urlComponent: &urlComponent!, effects: effects)
        }
        
        
        return urlComponent?.string ?? url
    }
    
    
    static func addEffects(urlComponent: inout URLComponents, effects: [String: Any]) {
        if let brightness = effects["brightness"] as? NSNumber {
            urlComponent.queryItems?.append(URLQueryItem(name: "brightness", value: brightness.stringValue))
        }
        if let contrast = effects["contrast"] as? NSNumber {
            urlComponent.queryItems?.append(URLQueryItem(name: "contrast", value: contrast.stringValue))
        }
        if let saturate = effects["saturate"] as? NSNumber {
            urlComponent.queryItems?.append(URLQueryItem(name: "saturation", value: saturate.stringValue))
        }
        if let blur = effects["blur"] as? NSNumber {
            urlComponent.queryItems?.append(URLQueryItem(name: "blur", value: blur.stringValue))
        }
        if let sharpen = effects["sharpen"] as? [String: AnyObject] {
            var sharpenVal = ""
            if let amount = sharpen["amount"] as? NSNumber {
                sharpenVal.append("a\(amount)")
            } else {
                sharpenVal.append("a\(0)")
            }
            if let radius = sharpen["radius"] as? NSNumber {
                sharpenVal.append(",r\(radius),")
            } else {
                sharpenVal.append(",r\(1),")
            }
            if let threshold = sharpen["threshold"] as? NSNumber {
                sharpenVal.append("t\(threshold)")
            } else {
                sharpenVal.append("t\(0)")
            }
            urlComponent.queryItems?.append(URLQueryItem(name: "sharpen", value: sharpenVal))

        }
    }
    static func addTransform(urlComponent: inout URLComponents, transform: [String: Any])
    {
        if let height = transform["height"]
        {
            urlComponent.queryItems?.append(URLQueryItem(name: "height", value: "\(height)"))
        }
        if let width = transform["width"]
        {
            urlComponent.queryItems?.append(URLQueryItem(name: "width", value: "\(width)"))
        }
        if let flipMode = transform["flip-mode"]
        {
            if flipMode as! String == "both"
            {
                urlComponent.queryItems?.append(URLQueryItem(name: "orient", value: "3"))
            }
            if flipMode as! String == "horiz"
            {
                urlComponent.queryItems?.append(URLQueryItem(name: "orient", value: "2"))
            }
            if flipMode as! String == "verti"
            {
                urlComponent.queryItems?.append(URLQueryItem(name: "orient", value: "4"))
            }
        }
    }
}
