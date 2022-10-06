import 'dart:convert';
import 'dart:io';

import 'package:contentstack_preset/contentstack_preset.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  final file = File('test_resources/asset.json');
  var asset = jsonDecode(await file.readAsString());

  test('Load asset file', () async {
    expect('asset_uid', asset['uid']);
    expect('crop_area.jpeg', asset['filename']);
  });

  test('call preset function', () {
    final preset = Preset();
    var url = preset.resolve(asset, 'blt777777777',
        presetUid: 'invalid', presetName: 'Local Preset');
    print('-=-=-=-=-=-=-=-=-=-=-=-=-=-= $url');
    expect(
        "http://image.contenstack.com/crop_area.jpeg?height=500&width=500&orient=2&image-type=jpeg&quality=100",
        url.toString());
  });
}
