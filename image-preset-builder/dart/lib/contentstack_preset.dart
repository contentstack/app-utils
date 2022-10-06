library contentstack_preset;

/// Preset class for assets to get the url based on extension uid and preset name or preset id
class Preset {
  /// To resolve the asset object using preset
  /// @asset asset object<br>
  /// @extensionUid the extension uid from of the respected preset<br>
  /// @presetUid the preset uid<br>
  /// @presetName the preset name<br>
  /// return url of the preset<br>
  resolve(asset, String extensionUid,
      {String presetUid = '', String presetName = ''}) {
    if (presetUid.isEmpty && presetName.isEmpty) {
      throw ArgumentError(
          "Please provide valid Preset Name or Preset uid, One of both is necessary");
    }
    _validateExtUid(asset, extensionUid);
    var resultUrl = asset['url'];
    _validateExt(asset);
    var extensionList = asset['_metadata']['extensions'][extensionUid];
    extensionList.forEach((element) {
      if (element.containsKey("presets")) {
        element['presets'].forEach((item) {
          if (item['name'] == presetName || item['uid'] == presetUid) {
            var options = item['options']; // Get the option object here
            var params = _executeOptions(options);
            var url = asset['url'];
            resultUrl = _result(url, params);
            return resultUrl;
          }
        });
      }
    });

    return resultUrl;
  }

  _result(baseUrl, Map<String, dynamic> queryParams) {
    final String queryString = Uri(
        queryParameters:
            queryParams.map((key, value) => MapEntry(key, value))).query;
    return baseUrl + '?$queryString';
  }

  _executeOptions(options) {
    final params = <String, dynamic>{};
    if (options.containsKey('transform')) {
      _transformQuery(params, options['transform']);
    }
    if (options.containsKey('image-type')) {
      params['image-type'] = options['image-type'].toString();
    }
    if (options.containsKey('quality')) {
      params['quality'] = options['quality'].toString();
    }
    if (options.containsKey('effects')) {
      _effectQuery(params, options['effects']);
    }
    return params;
  }

  _transformQuery(Map<String, dynamic> params, transform) {
    if (transform.containsKey('height')) {
      params['height'] = transform['height'].toString();
    }
    if (transform.containsKey('width')) {
      params['width'] = transform['width'].toString();
    }
    if (transform.containsKey('flip-mode')) {
      String flipMode = transform['flip-mode'].toString();
      if (flipMode == "both") {
        params['orient'] = 3.toString();
      } else if (flipMode == "horiz") {
        params['orient'] = 2.toString();
      } else if (flipMode == "verti") {
        params['orient'] = 4.toString();
      }
    }
    return params;
  }

  _effectQuery(Map<String, dynamic> params, effects) {
    if (effects.containsKey('brightness')) {
      params['brightness'] = effects['brightness'].toString();
    } else if (effects.containsKey('contrast')) {
      params['contrast'] = effects['contrast'].toString();
    } else if (effects.containsKey('sharpen')) {
      params["saturation"] = effects["saturation"].toString();
    } else if (effects.containsKey('blur')) {
      params['blur'] = effects['blur'].toString();
    }
    return params;
  }

  void _validateExtUid(asset, String extensionUid) {
    _validator(asset);
    if (extensionUid.isEmpty) {
      throw ArgumentError("Please provide valid extension uid");
    }
  }

  void _validator(asset) {
    if (asset.isEmpty) {
      throw ArgumentError("asset file can not be empty");
    }
    if (!asset.containsKey("_metadata")) {
      throw ArgumentError("_metadata keys not found in the asset object");
    }
  }

  void _validateExt(asset) {
    if (!asset.containsKey("_metadata")) {
      throw ArgumentError("_metadata key not found in the asset object");
    }
    if (!asset['_metadata'].containsKey('extensions')) {
      throw ArgumentError("extension key not found in the asset object");
    }
  }
}
