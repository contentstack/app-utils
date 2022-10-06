import json
import os
import unittest

from preset import preset

asset = os.path.join(os.path.dirname(__file__), 'asset.json')
jsonfile = open(asset)
_json_asset = json.load(jsonfile)


class TestPreset(unittest.TestCase):

    def setUp(self):
        if isinstance(asset, dict):
            self.assertTrue(isinstance(asset, str))
        print(asset)

    def test_asset_uid(self):
        if isinstance(asset, dict) and 'uid' in asset:
            uid = asset['uid']
            print(uid)
            self.assertEqual('asset_uid', uid)

    def test_instance_url(self):
        if isinstance(asset, dict) and 'url' in asset:
            url = asset['url']
            print(url)
            self.assertEqual('http://image.contenstack.com/crop_area.jpeg', url)

    def test_resolve_preset_name(self):
        url = preset.resolve(_json_asset, 'blt777777777', preset_name='Local Preset')
        print(url)
        self.assertEqual(
            'http://image.contenstack.com/crop_area.jpeg?height=500&width=500&orient=2&image-type=jpeg&quality=100',
            url)

    def test_resolve_preset_uid(self):
        url = preset.resolve(_json_asset, 'blt777777777', preset_uid='preset_01')
        self.assertEqual(
            'http://image.contenstack.com/crop_area.jpeg?height=500&width=500&orient=2&image-type=jpeg&quality=100',
            url)
