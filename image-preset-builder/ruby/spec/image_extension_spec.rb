require 'spec_helper'
describe Contentstack::ImageExtension do
    it "ResolvePreset With Blank" do
        asset = getJson(Asset)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME)).to eql(asset['url'])
    end

    it "ResolvePreset by UID With Blank" do
        asset = getJson(Asset)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID)).to eql(asset['url'])
    end

    it "ResolvePreset With Blank Extension" do
        asset = getJson(AssetBlankExtension)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME)).to eql(asset['url'])
    end

    it "ResolvePreset by UID With Blank Extension" do
        asset = getJson(AssetBlankExtension)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID)).to eql(asset['url'])
    end

    it "ResolvePreset With Blank Preset" do
        asset = getJson(AssetPresets)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, LOCAL_PRESET_NAME)).to eql(asset['url'])
    end

    it "ResolvePreset by UID With Blank Preset" do
        asset = getJson(AssetPresets)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, LOCAL_PRESET_UID)).to eql(asset['url'])
    end

    it "ResolvePreset With Global Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME)).to eql(AssetMetaGlobalPreset)
    end

    it "ResolvePreset by UID With Global Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID)).to eql(AssetMetaGlobalPreset)
    end

    it "ResolvePreset With Crop Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, CROP_PRESET_NAME)).to eql(AssetMetaWithCropPreset)
    end

    it "ResolvePreset by UID With Crop Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, CROP_PRESET_UID)).to eql(AssetMetaWithCropPreset)
    end

    it "ResolvePreset With Global Preset with Query Parameter" do
        asset = getJson(AssetMetaURLQuery)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME)).to eql(AssetMetaQueryParam)
    end

    it "ResolvePreset by UID With Global Preset with Query Parameter" do
        asset = getJson(AssetMetaURLQuery)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID)).to eql(AssetMetaQueryParam)
    end

    it "ResolvePreset With Filter Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, FILTER_PRESET_NAME)).to eql(AssetMetaFilterPreset)
    end

    it "ResolvePreset by UID With Filter Preset with Query Parameter" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, FILTER_PRESET_UID)).to eql(AssetMetaFilterPreset)
    end

    it "ResolvePreset With Local Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePreset(asset['url'], asset[METADATA], EXTENSION_UID, LOCAL_PRESET_NAME)).to eql(AssetMetaLocalPreset)
    end

    it "ResolvePreset by UID With Local Preset" do
        asset = getJson(AssetMeta)
        expect(Contentstack::ImageExtension.resolvePresetByUid(asset['url'], asset[METADATA], EXTENSION_UID, LOCAL_PRESET_UID)).to eql(AssetMetaLocalPreset)
    end
end