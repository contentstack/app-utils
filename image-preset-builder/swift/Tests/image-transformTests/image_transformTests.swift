import XCTest
@testable import image_transform

final class image_transformTests: XCTestCase {
    
    func testResolvePreset_With_Blank() {
        let asset = JSONParser.parse(from: Asset);
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: GLOBAL_PRESET_NAME);
        XCTAssertEqual(asset.url, result)
    }
    
    func testResolvePresetByUid_With_Blank() {
        let asset = JSONParser.parse(from: Asset);
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: GLOBAL_PRESET_UID);
        XCTAssertEqual(asset.url, result)
    }
    
    func testResolvePreset_With_BlankExtension() {
       let asset = JSONParser.parse(from: AssetBlankExtension)
       let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: GLOBAL_PRESET_NAME);
       XCTAssertEqual(asset.url, result)
    }
    
    
    func testResolvePresetByUid_With_BlankExtension() {
        let asset = JSONParser.parse(from: AssetBlankExtension)
        
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: GLOBAL_PRESET_UID);
        XCTAssertEqual(asset.url, result)
    }

    func testResolvePreset_With_BlankPreset() {
        let asset = JSONParser.parse(from: AssetPresets)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: LOCAL_PRESET_NAME);
        XCTAssertEqual(asset.url, result)
    }

    func testResolvePresetByUid_With_BlankPreset() {
        let asset = JSONParser.parse(from: AssetPresets)
        
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: LOCAL_PRESET_UID)
        XCTAssertEqual(asset.url, result)
    }

    func testResolvePreset_with_GlobalPreset() {
        let asset = JSONParser.parse(from: AssetMeta)
        
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: GLOBAL_PRESET_NAME)
        XCTAssertEqual(AssetMetaGlobalPreset, result)
    }

    func testResolvePresetByUid_with_GlobalPreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: GLOBAL_PRESET_UID)
        XCTAssertEqual(AssetMetaGlobalPreset, result)
    }

    func testResolvePreset_with_CropPreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: CROP_PRESET_NAME)
        XCTAssertEqual(AssetMetaWithCropPreset, result)
    }
    func testResolvePresetByUid_with_CropPreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: CROP_PRESET_UID)
        XCTAssertEqual(AssetMetaWithCropPreset, result)
    }

    func testResolvePreset_with_GlobalPreset_With_QueryParam()
    {
        let asset = JSONParser.parse(from: AssetMetaURLQuery)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: GLOBAL_PRESET_NAME)
        XCTAssertEqual(AssetMetaQueryParam, result)
    }

    func testResolvePresetByUid_with_GlobalPreset_With_QueryParam()
    {
        let asset = JSONParser.parse(from: AssetMetaURLQuery)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: GLOBAL_PRESET_UID)
        XCTAssertEqual(AssetMetaQueryParam, result)
    }

    func testResolvePreset_with_FilterPreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: FILTER_PRESET_NAME)
        XCTAssertEqual(AssetMetaFilterPreset, result)
    }

    func testResolvePresetByUid_with_FilterPreset_With_QueryParam()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: FILTER_PRESET_UID);
        XCTAssertEqual(AssetMetaFilterPreset, result)
    }

    func testResolvePreset_With_LocalePreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetName: LOCAL_PRESET_NAME);
        XCTAssertEqual(AssetMetaLocalPreset, result)
    }

    func testResolvePresetByUid_With_LocalePreset()
    {
        let asset = JSONParser.parse(from: AssetMeta)
        let result = ImageTransform.resolvePreset(asset.url, assetMetadata: asset.metadata!, extensionUid: EXTENSION_UID, presetUid: LOCAL_PRESET_UID);
        XCTAssertEqual(AssetMetaLocalPreset, result)
    }
}
