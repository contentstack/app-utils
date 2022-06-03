# frozen_string_literal: true

require_relative "image_extension/version"
require 'uri'
require 'cgi'
module Contentstack
  class ImageExtension
    def self.resolvePreset(url, assetMetadata, extensionUid, presetName)
      if url != nil
        preset = getPreset(assetMetadata, extensionUid, presetName, nil)
        if preset != nil && (preset.has_key? 'options')
          return transformUrl(url, preset['options'])
        end
      end
      url
    end

    def self.resolvePresetByUid(url, assetMetadata, extensionUid, presetUid)
      if url != nil
        preset = getPreset(assetMetadata, extensionUid, nil, presetUid)
        if preset != nil && (preset.has_key? 'options')
          return transformUrl(url, preset['options'])
        end
      end
      url
    end

    private_class_method def self.transformUrl(url, options)
      uri = URI.parse(url)
      params = uri.query != nil ? URI.decode_www_form(uri.query).to_h : {}
      if options.has_key? 'transform'
        addTransformer(params, options['transform'])
      end
      if options.has_key? 'image-type'
        params['format'] = options['image-type']
      end
      if options.has_key? 'quality'
        params['quality'] = options['quality']
      end
      if options.has_key? 'effects'
        addEffects(params, options['effects'])
      end
      if params.length > 0
        uri.query = URI.encode_www_form(params)
      end
      return uri.to_s
    end

    private_class_method def self.addEffects(params, effects)
        if effects.has_key? 'brightness'
        
            params['brightness'] = effects['brightness']
        end
        if effects.has_key? 'contrast'
        
            params['contrast'] = effects['contrast']
        end
        if effects.has_key? 'saturate'
        
            params['saturation'] = effects['saturate']
        end
        if effects.has_key? 'blur'
        
            params['blur'] = effects['blur']
        end
        if effects.has_key? 'sharpen'
            sharpen = effects['sharpen']
            amount = sharpen['amount'] || 0
            radius = sharpen['radius'] || 1
            threshold = sharpen['threshold'] || 0
            params['sharpen'] = "a#{amount},r#{radius},t#{threshold}"
        end
    end

    private_class_method def self.addTransformer(params, transform)
      if transform.has_key? 'height'
        params['height'] = transform['height']
      end
      if transform.has_key? 'width'
        params['width'] = transform['width']
      end
      if transform.has_key? 'flip-mode'
        flip_mode = transform['flip-mode'];
        if flip_mode == 'both'
            params['orient'] = '3';
        elsif flip_mode == 'horiz'
            params['orient'] = '2';
        elsif flip_mode == 'verti'
            params['orient'] = '4';
        end
      end
    end

    private_class_method def self.getPreset(assetMetadata, extensionUid, presetName, presetUid)
      preset = nil
      if ((assetMetadata.has_key? 'extensions') && (assetMetadata['extensions'].instance_of? Hash) && (assetMetadata['extensions'].has_key? extensionUid))
        for extension in assetMetadata['extensions'][extensionUid]
          if (extension.has_key? 'presets') && (extension['presets'].instance_of? Array)
            presetArray = extension['presets'].select{ |obj| obj['uid'] == presetUid || obj['name'] == presetName}
            if presetArray != nil && presetArray.length > 0
              preset = presetArray[0]
              break
            end
          end
        end
      end
      preset
    end
  end
end
