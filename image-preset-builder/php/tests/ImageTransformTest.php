<?php
declare(strict_types=1);
namespace Contentstack\ImagePresetBuilder\Tests;

require_once __DIR__.'/Helper/Constant.php';

use Contentstack\ImagePresetBuilder\ImageTransform;

use PHPUnit\Framework\TestCase;
class ImageTransformTest extends TestCase
{
    public function testResolvePreset_With_Blank(): void
    {
        $asset = json_decode(Asset, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePresetByUid_With_Blank(): void
    {
        $asset = json_decode(Asset, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePreset_With_BlankExtension(): void
    {
        $asset = json_decode(AssetBlankExtension, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePresetByUid_With_BlankExtension(): void
    {
        $asset = json_decode(AssetBlankExtension, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePreset_With_BlankPreset(): void
    {
        $asset = json_decode(AssetPresets, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, LOCAL_PRESET_NAME);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePresetByUid_With_BlankPreset(): void
    {
        $asset = json_decode(AssetPresets, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, LOCAL_PRESET_UID);
        $this->assertEquals($asset['url'], $data);
    }

    public function testResolvePreset_with_GlobalPreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME);
        $this->assertEquals(AssetMetaGlobalPreset, $data);
    }

    public function testResolvePresetByUid_with_GlobalPreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID);
        $this->assertEquals(AssetMetaGlobalPreset, $data);
    }

    public function testResolvePreset_with_CropPreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, CROP_PRESET_NAME);
        $this->assertEquals(AssetMetaWithCropPreset, $data);
    }
    public function testResolvePresetByUid_with_CropPreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, CROP_PRESET_UID);
        $this->assertEquals(AssetMetaWithCropPreset, $data);
    }

    public function testResolvePreset_with_GlobalPreset_With_QueryParam(): void
    {
        $asset = json_decode(AssetMetaURLQuery, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_NAME);
        $this->assertEquals(AssetMetaQueryParam, $data);
    }

    public function testResolvePresetByUid_with_GlobalPreset_With_QueryParam(): void
    {
        $asset = json_decode(AssetMetaURLQuery, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, GLOBAL_PRESET_UID);
        $this->assertEquals(AssetMetaQueryParam, $data);
    }

    public function testResolvePreset_with_FilterPreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, FILTER_PRESET_NAME);
        $this->assertEquals(AssetMetaFilterPreset, $data);
    }

    public function testResolvePresetByUid_with_FilterPreset_With_QueryParam(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, FILTER_PRESET_UID);
        $this->assertEquals(AssetMetaFilterPreset, $data);
    }

    public function testResolvePreset_With_LocalePreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePreset($asset['url'], $asset[METADATA], EXTENSION_UID, LOCAL_PRESET_NAME);
        $this->assertEquals(AssetMetaLocalPreset, $data);
    }

    public function testResolvePresetByUid_With_LocalePreset(): void
    {
        $asset = json_decode(AssetMeta, true);
        $data = ImageTransform::resolvePresetByUid($asset['url'], $asset[METADATA], EXTENSION_UID, LOCAL_PRESET_UID);
        $this->assertEquals(AssetMetaLocalPreset, $data);
    }
}