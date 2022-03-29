package com.contentstack.utils.presets;

import org.jetbrains.annotations.NotNull;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Constant {


    private Constant() throws IllegalAccessException {
        throw new IllegalAccessException("Private=Constructor not allowed");
    }

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
    public static final String EMBEDDED_ITEMS = "_embedded_items";

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
            localPresetList = returnPresetObject(presetObj, presetName, random);
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
            JSONArray presetArray,
            String presetName, String random) {
        List<JSONObject> listPreset = new ArrayList<>();
        for (Object element : presetArray) {
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
