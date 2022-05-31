<?php
namespace Contentstack\ImagePresetBuilder;

final class ImageTransform {
    public static function resolvePreset(string $url, array $assetMetadata, string $extensionUid, string $presetName): string
    {
        if ($url)
        {
            $preset = ImageTransform::getPreset($assetMetadata, $extensionUid, $presetName);
            if ($preset && array_key_exists('options', $preset))
            {
                return ImageTransform::transformUrl($url, $preset['options']);
            }
        }
        return $url;
    }

    public static function resolvePresetByUid(string $url, array $assetMetadata, string $extensionUid, string $presetUid): string
    {
        if ($url)
        {
            $preset = ImageTransform::getPreset($assetMetadata, $extensionUid, null, $presetUid);
            if ($preset && array_key_exists('options', $preset))
            {
                return ImageTransform::transformUrl($url, $preset['options']);
            }
        }
        return $url;
    }

    protected static function parseQueryString(mixed $url_components): array {
        if (array_key_exists('query', $url_components))
        {
            parse_str($url_components['query'], $params);
            return $params;
        }
        return array();
    }

    protected static function transformUrl(string $url, array $options): string
    {
        $url_components = parse_url($url);
        $params = ImageTransform::parseQueryString($url_components);
        if(array_key_exists('transform', $options))
        {
            ImageTransform::addTransform($params, $options['transform']);
        }

        if(array_key_exists('image-type', $options))
        {
            $params['format'] = $options['image-type'];
        }

        if(array_key_exists('quality', $options))
        {
            $params['quality'] = $options['quality'];
        }

        if(array_key_exists('effects', $options))
        {
            ImageTransform::addEffects($params, $options['effects']);
        }

        $url_components['query'] = http_build_query($params);
        return http_build_url($url_components);
    }

    protected static function addEffects(array &$params, array $effects)
    {
        if (array_key_exists('brightness', $effects))
        {
            $params['brightness'] = $effects['brightness'];
        }
        if (array_key_exists('contrast', $effects))
        {
            $params['contrast'] = $effects['contrast'];
        }
        if (array_key_exists('saturate', $effects))
        {
            $params['saturation'] = $effects['saturate'];
        }
        if (array_key_exists('blur', $effects))
        {
            $params['blur'] = $effects['blur'];
        }
        if (array_key_exists('sharpen', $effects))
        {
            $sharpen = $effects['sharpen'];
            $amount = $sharpen['amount'] ?? 0;
            $radius = $sharpen['radius'] ?? 1;
            $threshold = $sharpen['threshold'] ?? 0;
            $params['sharpen'] = 'a'.$amount.',r'.$radius.',t'.$threshold;
        }
    }
    protected static function addTransform(array &$params, array $transform)
    {
        if(array_key_exists('height', $transform))
        {
            $params['height'] = strval($transform['height']);
        }
        if(array_key_exists('width', $transform))
        {
            $params['width'] = strval($transform['width']);
        }
        if(array_key_exists('flip-mode', $transform))
        {
            $flip_mode = $transform['flip-mode'];
            if ($flip_mode == 'both')
            {
                $params['orient'] = '3';
            }
            if ($flip_mode == 'horiz')
            {
                $params['orient'] = '2';
            }
            if ($flip_mode == 'verti')
            {
                $params['orient'] = '4';
            }
        }
    }

    protected static function getPreset(array $metadata, string $extensionUid, string $presetName = null, string $presetUid = null): ?array 
    {
        $preset = null;
        if (array_key_exists('extensions', $metadata) 
            && array_key_exists($extensionUid, $metadata['extensions']) 
            && !empty($metadata['extensions'][$extensionUid]))
        {
            foreach($metadata['extensions'][$extensionUid] as $extension)
            {
                if (array_key_exists('presets', $extension))
                {
                    $presetArray = array_filter($extension['presets'], 
                        function (array $preset) use ($presetUid, $presetName)
                        {
                            return (($presetUid && $preset['uid'] == $presetUid) || ($presetName && $preset['name'] == $presetName));
                        }
                    );
                    $presetArray = array_values($presetArray);
                    if (!empty($presetArray)) 
                    {
                        $preset = $presetArray[0];
                        break;
                    }
                }
            }
        }
        return $preset;
    }
}