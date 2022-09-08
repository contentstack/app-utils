def resolve(asset, extension_uid, preset_uid=None, preset_name=None):
    extensions = valid(asset)
    if isinstance(extensions, dict):
        if extension_uid in extensions:
            ext_uid_list = extensions[extension_uid]
        else:
            raise Exception("extension_uid not found in the extensions")
        for preset in ext_uid_list:
            items = preset['presets']
            for item in items:
                options = valid_preset_cred(item, preset_name, preset_uid)
                if options is not None:
                    return _executeOptions(options, asset['url'])


def result(params):
    from urllib.parse import urlencode
    return urlencode(params)


def _executeOptions(options, url):
    params = {}
    if 'transform' in options:
        params = _transformQuery(params, options['transform'])
    if 'image-type' in options:
        params['image-type'] = options['image-type']
    if 'quality' in options:
        params['quality'] = options['quality']
    if 'effects' in options:
        _effectQuery(params, options['effects'])
    return url + '?' + result(params)


def _transformQuery(params, transform):
    if 'height' in transform:
        params['height'] = transform['height']
    if 'width' in transform:
        params['width'] = transform['width']
    if 'flip-mode' in transform:
        flip_mode = transform['flip-mode']
        if flip_mode == "both":
            params['orient'] = '3'
        elif flip_mode == "horiz":
            params['orient'] = '2'
        elif flip_mode == "verti":
            params['orient'] = '4'
    return params


def _effectQuery(params, effects):
    if 'brightness' in effects:
        params['brightness'] = effects['brightness']
    elif 'contrast' in effects:
        params['contrast'] = effects['contrast']
    elif 'sharpen' in effects:
        params["saturation"] = effects["saturation"]
    elif 'blur' in effects:
        params['blur'] = effects['blur']
    return params


def valid(asset):
    if isinstance(asset, dict) and '_metadata' in asset:
        return asset['_metadata']['extensions']
    else:
        raise Exception("Invalid Asset, _metadata and _extensions not found")


def valid_ext(ext_uid):
    if isinstance(ext_uid, str) and ext_uid is not '':
        return ext_uid
    else:
        raise Exception("Please provide a valid extensions uid")


def valid_preset_cred(presets, preset_name, preset_uid):
    if preset_name is not None and not '' and preset_name == presets['name']:
        if not presets['options']:
            raise Exception("options not fount in preset object")
        return presets['options']
    elif preset_uid is not None and not '' and preset_uid == presets['uid']:
        if not presets['options']:
            raise Exception("options not fount in preset object")
        return presets['options']
    else:
        return None
