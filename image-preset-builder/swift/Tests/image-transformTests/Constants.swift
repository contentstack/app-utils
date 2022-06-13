//
//  Constant.swift
//  
//
//  Created by Uttam Ukkoji on 01/06/22.
//

import Foundation

let AssetUrl = "http://image.contenstack.com/crop_area.jpeg"
let Asset = "{\"uid\":\"asset_uid\",\"created_by\":\"create_by\",\"updated_by\":\"update_by\",\"content_type\":\"image/jpeg\",\"file_size\":\"62181\",\"tags\":[],\"filename\":\"crop_area.jpeg\",\"url\":\"http://image.contenstack.com/crop_area.jpeg\",\"is_dir\":false,\"parent_uid\":null,\"path\":[],\"_version\":1,\"title\":\"crop_area.jpeg\",\"dimension\":{\"height\":712,\"width\":864},\"_metadata\":{}}"
let AssetMeta = "{\"uid\":\"asset_uid\",\"created_by\":\"create_by\",\"updated_by\":\"update_by\",\"content_type\":\"image/jpeg\",\"file_size\":\"62181\",\"tags\":[],\"filename\":\"crop_area.jpeg\",\"url\":\"http://image.contenstack.com/crop_area.jpeg\",\"is_dir\":false,\"parent_uid\":null,\"path\":[],\"_version\":1,\"title\":\"crop_area.jpeg\",\"dimension\":{\"height\":712,\"width\":864},\"_metadata\":{\"extensions\":{\"extension_uid\":[{\"local_data\":\"main\",\"presets\":[{\"uid\":\"preset_01\",\"name\":\"Local Preset\",\"options\":{\"transform\":{\"height\":500,\"width\":500,\"flip-mode\":\"horiz\",\"rotate\":40},\"focal-point\":{\"x\":-0.668935003427432,\"y\":-0.9220385351936531},\"quality\":\"100\",\"image-type\":\"jpeg\"}},{\"uid\":\"preset_02\",\"name\":\"WithCrop\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":\"569.6\",\"width\":\"569.6\",\"flip-mode\":\"both\"},\"image-type\":\"jpeg\",\"crop\":{\"height\":\"569.6\",\"width\":\"569.6\",\"x\":\"147.2\",\"y\":\"71.2\"}}},{\"uid\":\"preset_03\",\"name\":\"Filter\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":712,\"width\":864},\"image-type\":\"jpeg\",\"effects\":{\"brightness\":52,\"contrast\":15,\"saturate\":-30,\"blur\":16,\"sharpen\":{\"amount\":9,\"radius\":669,\"threshold\":207}}}}]},{\"presets\":[{\"uid\":\"preset_04\",\"name\":\"Global Preset\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":\"712\",\"width\":\"864\",\"flip-mode\":\"verti\"},\"image-type\":\"jpeg\"}}]}]}}}"
let AssetBlankExtension = "{\"uid\":\"asset_uid\",\"created_by\":\"create_by\",\"updated_by\":\"update_by\",\"content_type\":\"image/jpeg\",\"file_size\":\"62181\",\"tags\":[],\"filename\":\"crop_area.jpeg\",\"url\":\"http://image.contenstack.com/crop_area.jpeg\",\"is_dir\":false,\"parent_uid\":null,\"path\":[],\"_version\":1,\"title\":\"crop_area.jpeg\",\"dimension\":{\"height\":712,\"width\":864},\"_metadata\":{\"extensions\":{\"extension_uid\":[]}}}"
let AssetPresets = "{\"uid\":\"asset_uid\",\"created_by\":\"create_by\",\"updated_by\":\"update_by\",\"content_type\":\"image/jpeg\",\"file_size\":\"62181\",\"tags\":[],\"filename\":\"crop_area.jpeg\",\"url\":\"http://image.contenstack.com/crop_area.jpeg\",\"is_dir\":false,\"parent_uid\":null,\"path\":[],\"_version\":1,\"title\":\"crop_area.jpeg\",\"dimension\":{\"height\":712,\"width\":864},\"_metadata\":{\"extensions\":{\"extension_uid\":[{\"local_data\":\"main\",\"presets\":[{\"uid\":\"preset_01\",\"name\":\"Local Preset\",\"options\":{}},{\"uid\":\"preset_02\",\"name\":\"WithCrop\",\"options\":{\"quality\":\"100\",\"transform\":{},\"image-type\":\"jpeg\",\"crop\":{}}},{\"uid\":\"preset_03\",\"name\":\"Filter\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":712,\"width\":864},\"image-type\":\"jpeg\",\"effects\":{}}}]},{\"presets\":[{\"uid\":\"preset_04\",\"name\":\"Global Preset\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":\"712\",\"width\":\"864\",\"flip-mode\":\"verti\"},\"image-type\":\"jpeg\"}}]}]}}}"
let AssetMetaURLQuery = "{\"uid\":\"asset_uid\",\"created_by\":\"create_by\",\"updated_by\":\"update_by\",\"content_type\":\"image/jpeg\",\"file_size\":\"62181\",\"tags\":[],\"filename\":\"crop_area.jpeg\",\"url\":\"http://image.contenstack.com/crop_area.jpeg?render=full&noval\",\"is_dir\":false,\"parent_uid\":null,\"path\":[],\"_version\":1,\"title\":\"crop_area.jpeg\",\"dimension\":{\"height\":712,\"width\":864},\"_metadata\":{\"extensions\":{\"extension_uid\":[{\"local_data\":\"main\",\"presets\":[{\"uid\":\"preset_01\",\"name\":\"Local Preset\",\"options\":{\"transform\":{\"height\":500,\"width\":500,\"flip-mode\":\"horiz\",\"rotate\":40},\"focal-point\":{\"x\":-0.668935003427432,\"y\":-0.9220385351936531},\"quality\":\"100\",\"image-type\":\"jpeg\"}},{\"uid\":\"preset_02\",\"name\":\"WithCrop\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":\"569.6\",\"width\":\"569.6\",\"flip-mode\":\"both\"},\"image-type\":\"jpeg\",\"crop\":{\"height\":\"569.6\",\"width\":\"569.6\",\"x\":\"147.2\",\"y\":\"71.2\"}}},{\"uid\":\"preset_03\",\"name\":\"Filter\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":712,\"width\":864},\"image-type\":\"jpeg\",\"effects\":{\"brightness\":52,\"contrast\":15,\"saturate\":-30,\"blur\":16,\"sharpen\":{\"amount\":9,\"radius\":669,\"threshold\":207}}}}]},{\"presets\":[{\"uid\":\"preset_04\",\"name\":\"Global Preset\",\"options\":{\"quality\":\"100\",\"transform\":{\"height\":\"712\",\"width\":\"864\",\"flip-mode\":\"verti\"},\"image-type\":\"jpeg\"}}]}]}}}"

let AssetMetaGlobalPreset = "http://image.contenstack.com/crop_area.jpeg?height=712&width=864&orient=4&format=jpeg&quality=100"
let AssetMetaFilterPreset = "http://image.contenstack.com/crop_area.jpeg?height=712&width=864&format=jpeg&quality=100&brightness=52&contrast=15&saturation=-30&blur=16&sharpen=a9,r669,t207"
let AssetMetaLocalPreset = "http://image.contenstack.com/crop_area.jpeg?height=500&width=500&orient=2&format=jpeg&quality=100"
let AssetMetaWithCropPreset = "http://image.contenstack.com/crop_area.jpeg?height=569.6&width=569.6&orient=3&format=jpeg&quality=100"
let AssetMetaQueryParam = "http://image.contenstack.com/crop_area.jpeg?render=full&noval&height=712&width=864&orient=4&format=jpeg&quality=100"

let METADATA = "_metadata"
let GLOBAL_PRESET_NAME = "Global Preset"
let GLOBAL_PRESET_UID = "preset_04"
let LOCAL_PRESET_NAME = "Local Preset"
let LOCAL_PRESET_UID = "preset_01"
let CROP_PRESET_NAME = "WithCrop"
let CROP_PRESET_UID = "preset_02"
let FILTER_PRESET_NAME = "Filter"
let FILTER_PRESET_UID = "preset_03"
let EXTENSION_UID = "extension_uid"
