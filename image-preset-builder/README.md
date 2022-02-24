# How to render an image with selected preset

### Fetch the entry containing preset details

First, we need to get the image with preset. For this, we need to fetch the entry where you have used the image with preset

### Get the schema for asset

You could pick the image with preset by either using the custom field or using the RTE plugin. The resulting schema will need **preset data** and **asset data.**

#### Custom field

The fetched entry will have similar structure. In this case we have the custom field under the name custom-image-field.

```js
{

  "title": "Preset Picker Demo",

  "custom-image-field": {

    "uid": "sample-uid",

    "metadata": {

      "preset": {

        "uid": "sample-preset-uid",

        ...

      },

      "extension_uid": "sample-extension-uid"

    },

    "asset": {

        "url":"https://example.com/image.jpg",

        ...

    }

  }

}
```

Here, we have the preset data and extension_uid inside the metadata, and the asset is at the root of the custom field.

#### RTE plugin

This is what an RTE schema will look like. Here, we have the JSON RTE under the name json_rte.

```js
{
  "title": "Preset Picker Demo",
  "json_rte": {
    "uid": "v4-uid",
    "children": [
      {
        "uid": "v4-uid",
        "type": "reference",
        "attrs": {
          "asset-uid": "sample-asset-uid",
          "extension_uid": "sample-extension-uid",
          "preset": {
            "uid": "sample-preset-uid"
          },
          ...
        },
        "children": [{ "text": "" }]
      }
    ],
    "type": "doc"
  },
  "_embedded_items": {
    "json_rte": [
      {
        "uid": "sample-asset-uid",
        "url": "https://example.com/image.jpeg",
        ...
      }
    ]
  },
  ...
}
```

Here, the plugin will have a type of reference. The preset data and extension_uid could be found under the attrs of the plugin. The asset could be found under the \_embedded_items which are stored at the root of the entry schema. Learn more about the embedded_items.

### Get ImageTransformation utilities from app-utils repository

Go to [image-preset-builder](https://github.com/contentstack/app-utils/tree/main/image-preset-builder) inside the [@contentstack/app-utils](https://github.com/contentstack/app-utils/) in GitHub. Here you will find utility functions that will help you to render your image as per your preset. Find the language in which you are working and go to that folder. Inside this folder, you will find a file named **ImageTransformation**. Copy this file into your project. This file will contain all the functions you’ll need for rendering your image.

### Generate styles and URL for image

1. From the **ImageTransformation** file, we will use resolvePresetByPresetUID() function to generate an URL for the image that will contain the preset information. This function will take one object as an argument and this object will require asset, presetUID, extension_uid. These values could be extracted from the above schema.

    For e.g., here we extract asset from custom-image-field.asset, presetUID from custom-image-field.metadata.preset.uid and extension_uid from custom-image-field.metadata.extension_uid.

    This function will return a **new asset object containing the new image URL.** Now, get the URL from the new asset and pass it to the <img/> tag’s src attribute. This will resolve most of your image transformation. But, there is some transformation that needs to have CSS styles defined locally in the project. We also need to take care of the focal point feature, locally.

1. So, the next step will be to generate the CSS styles from the preset. For this, we are going to use resolvePresetStylesByPresetUID() function. This function accepts one object as an argument and this object will require asset, presetUID, extension_uid. These values could be extracted from the above schema.
   This function will return inline styles for the image. These styles could be added to the image.
1. Finally, we will need to handle the focal point (if applicable). First, we need to get the co-ordinates of the focal point. For this, we will use fetchPresetByPresetUID(). this object will require asset, presetUID, extension_uid. These values could be extracted from the above schema. This function will return a preset object.
   For e.g., this is how the return preset object will look like.

```js
{
    "uid": "sample-uid",
    "name": "Focal Point",
    "options": {
        "transform": {
            "width": 864,
            "height": 712
        },
        "quality": "100",
        "image-type": "jpeg",
        "focal-point": {
            "x": -0.5701133487044711,
            "y": 0.030206030249075533
        }
    }
}
```

We can retrieve the focal point from the focal-point object inside the preset object. This focal point object will contain x and y co-ordinates. Now, for displaying the focal point, we need to use some 3rd party packages that will accept these co-ordinates and display the image accordingly. For javascript, [image-focus](https://www.npmjs.com/package/image-focus) library.
