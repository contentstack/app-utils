package com.contentstack.utils.presets;

import org.apache.http.client.utils.URIBuilder;
import org.jetbrains.annotations.NotNull;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import static com.contentstack.utils.presets.Constant.*;

public class KeyNotFoundException extends Exception {
    public KeyNotFoundException(String str) {
        super(str);
    }
}

public class Preset {

    public String resolvePresetByPresetName(
            @NotNull JSONObject asset,
            @NotNull String extensionUid,
            @NotNull String presetName) {

        final JSONArray localExtensionUid = returnExtensionId(asset, extensionUid);
        if (presetName.isEmpty()) {
            throw new IllegalArgumentException("Please provide valid Preset Name");
        }
        List<JSONObject> presetOptionKEYS = extractMetadata(localExtensionUid, presetName, "name");
        String assetUrl = (String) asset.get(URL);
        try {
            assetUrl = findPresetOptions(presetOptionKEYS, assetUrl);
        }catch (MalformedURLException | URISyntaxException e) {
           throw new Exception(e.getLocalizedMessage());
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


public class Constant {

    private Constant() throws IllegalAccessException {
        throw new IllegalAccessException("Not allowed");
    }

    // constants
    static final String URL = "url";
    static final String QUALITY = "quality";
    static final String EFFECTS = "effects";
    static final String OPTIONS = "options";
    static final String HEIGHT = "height";
    static final String WIDTH = "width";
    static final String ORIENT = "orient";
    static final String BRIGHTNESS = "brightness";
    static final String CONTRAST = "contrast";
    static final String SHARPEN = "sharpen";
    static final String BLUR = "blur";
    static final String TRANSFORM = "transform";
    static final String FLIP_MODE = "flip-mode";
    static final String IMAGE_TYPE = "image-type";

    protected static void throwException(JSONObject jsonAsset, @NotNull String localisedMessage) {
        if (jsonAsset.isEmpty()) {
            try {
                throw new KeyNotFoundException(localisedMessage);
            } catch (KeyNotFoundException e) {
                e.printStackTrace();
            }
        }
    }

    protected static JSONObject validator(JSONObject asset) {
        throwException(asset, "asset file can not be empty");
        if (!asset.containsKey("_metadata")) {
            throwException(asset, "_metadata keys not found");
        }
        return (JSONObject) asset.get("_metadata");
    }

    protected static List<JSONObject> extractMetadata(
            JSONArray extensionArray, String presetName, String random) {

        List<JSONObject> localPresetList = Collections.emptyList();
        for (Object element : extensionArray) {
            JSONObject presetObj = (JSONObject) element;
            if (presetObj.containsKey("is_global")) {
                boolean isGlobal = (boolean) presetObj.get("is_global");
                if (!isGlobal)
                    localPresetList = returnPresetObject(presetObj, presetName, random);
                if (localPresetList.isEmpty())
                    localPresetList = returnPresetObject(presetObj, presetName, random);
            }
        }
        return localPresetList;
    }

    protected static List<JSONObject> returnPresetObject(
            @NotNull JSONObject metadata,
            @NotNull String presetName,
            String random) {
        JSONArray presetArray = (JSONArray) metadata.get("presets");
        return getByPresetName(presetArray, presetName, random);
    }

    protected static List<JSONObject> getByPresetName(
            JSONArray presetArray, String presetName, String random) {
        List<JSONObject> listPreset = new ArrayList<>();
        for(Object element: presetArray){
            JSONObject presetObj = (JSONObject) element;
            if (presetObj.containsKey(random)) {
                String localPresetName = (String) presetObj.get(random);
                if (localPresetName.equalsIgnoreCase(presetName)) {
                    listPreset.add(presetObj);
                }
            }
        }
        return listPreset;
    }
}
