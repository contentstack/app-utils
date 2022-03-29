package com.contentstack.utils.presets;

import org.apache.http.client.utils.URIBuilder;
import org.jetbrains.annotations.NotNull;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import static com.contentstack.utils.presets.Constant.*;

public class Preset {

    public String resolvePresetByPresetName(
            @NotNull JSONObject asset,
            @NotNull String extensionUid,
            @NotNull String presetName) throws InvalidUrlException {

        final JSONArray localExtensionUid = returnExtensionId(asset, extensionUid);
        if (presetName.isEmpty()) {
            throw new IllegalArgumentException("Please provide valid Preset Name");
        }
        List<JSONObject> presetOptionKEYS = extractMetadata(localExtensionUid, presetName, "name");
        String assetUrl = (String) asset.get(URL);
        try {
            assetUrl = findPresetOptions(presetOptionKEYS, assetUrl);
        }catch (MalformedURLException | URISyntaxException e) {
            throw new InvalidUrlException(e.getLocalizedMessage());
        }
        return assetUrl;
    }

    String findPresetOptions(List<JSONObject> presetOptionKEYS, String assetUrl)
            throws MalformedURLException, URISyntaxException {
        AtomicReference<JSONObject> optionsJson = new AtomicReference<>();
        if (!presetOptionKEYS.isEmpty()) {
            presetOptionKEYS.forEach(options -> {
                if (options.containsKey(Constant.OPTIONS)) {
                    optionsJson.set((JSONObject) options.get(Constant.OPTIONS));
                }
            });
        }
        return getImageURL(assetUrl, optionsJson.get());
    }

    public String resolvePresetByPresetUID(
            @NotNull JSONObject asset,
            @NotNull String extensionUid,
            @NotNull String presetUid) {

        final JSONArray localExtensionUid = returnExtensionId(asset, extensionUid);
        List<JSONObject> presetOptionKEYS = extractMetadata(localExtensionUid, presetUid, "uid");
        String assetUrl = (String) asset.get(URL);
        try {
            assetUrl = findPresetOptions(presetOptionKEYS, assetUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return assetUrl;
    }

    private String getImageURL(String assetUrl, JSONObject optionKEYS)
            throws URISyntaxException, MalformedURLException {
        URIBuilder uriBuilder = new URIBuilder(assetUrl);
        if (optionKEYS.containsKey(TRANSFORM)) {
            JSONObject transform = (JSONObject) optionKEYS.get(Constant.TRANSFORM);
            getTransformParam(uriBuilder, transform);
        }
        if (optionKEYS.containsKey(IMAGE_TYPE)) {
            String imageType = (String) optionKEYS.get(Constant.IMAGE_TYPE);
            uriBuilder.addParameter("format", imageType);
        }
        if (optionKEYS.containsKey(QUALITY)) {
            String quality = (String) optionKEYS.get(Constant.QUALITY);
            uriBuilder.addParameter(Constant.QUALITY, quality);
        }
        if (optionKEYS.containsKey(EFFECTS)) {
            JSONObject effects = (JSONObject) optionKEYS.get(Constant.EFFECTS);
            getEffectsParams(uriBuilder, effects);
        }
        return uriBuilder.build().toURL().toString();
    }

    private void getTransformParam(URIBuilder uriBuilder, JSONObject transform) {
        if (transform.containsKey(HEIGHT)) {
            Object height = transform.get(Constant.HEIGHT);
            uriBuilder.addParameter(Constant.HEIGHT, height.toString());
        }
        if (transform.containsKey(WIDTH)) {
            Object width = transform.get(Constant.WIDTH);
            uriBuilder.addParameter(Constant.WIDTH, width.toString());
        }
        if (transform.containsKey(FLIP_MODE)) {
            String flipMode = (String) transform.get(Constant.FLIP_MODE);
            if (flipMode.equalsIgnoreCase("both")) {
                uriBuilder.addParameter(ORIENT, "3");
            }
            if (flipMode.equalsIgnoreCase("horiz")) {
                uriBuilder.addParameter(ORIENT, "2");
            }
            if (flipMode.equalsIgnoreCase("verti")) {
                uriBuilder.addParameter(ORIENT, "4");
            }
        }
    }

    private void getEffectsParams(URIBuilder uriBuilder, JSONObject effects) {
        if (effects.containsKey(BRIGHTNESS)) {
            uriBuilder.addParameter(BRIGHTNESS, effects.get(Constant.BRIGHTNESS).toString());
        }
        if (effects.containsKey(CONTRAST)) {
            uriBuilder.addParameter(CONTRAST, effects.get(Constant.CONTRAST).toString());
        }
        if (effects.containsKey(SHARPEN)) {
            uriBuilder.addParameter("saturation", effects.get("saturation").toString());
        }
        if (effects.containsKey(BLUR)) {
            uriBuilder.addParameter(BLUR, effects.get(Constant.BLUR).toString());
        }
    }

    private JSONArray returnExtensionId(JSONObject asset, String extensionUid) {
        JSONObject localMetadata = validator(asset);
        if (extensionUid.isEmpty()) {
            throw new IllegalArgumentException("Please provide valid extension uid");
        }
        JSONObject localExtensions = (JSONObject) localMetadata.get("extensions");
        return (JSONArray) localExtensions.get(extensionUid);
    }

}
