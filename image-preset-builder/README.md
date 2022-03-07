# How to render an image with selected preset

### Fetch the entry containing preset details

First, you need to fetch the image that contains a preset. For this, you need to retrieve the entry where you have used a specific preset version of an image.

### Get the schema for asset

You can add a preset version of an image in two locations:

-   Custom fields
-   JSON Rich Text Editor Plugins

You can retrieve the **preset** and **asset data** from the resulting schema for the above locations.

#### Custom field

Let's consider that an entry has a Custom field with the name custom-image-field.

When you fetch an entry, its schema will look as follows:

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

In the above schema, the preset data and extension_uid are specified under the metadata section, and the asset data is returned at the root level of the Custom field schema.

#### JSON Rich Text Editor Plugin

Let's consider that an entry has a JSON Rich Text Editor field with the name json-rte. This field contains a plugin of type "reference."

When you fetch an entry, its schema will look as follows:

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

In the above schema, the JSON RTE plugin is of reference type. The preset data and extension_uid are found under the attrs section of the JSON RTE schema. You can find the asset under the \_embedded_items section located at the root level of the entry schema. Learn more about [Embedded Items](https://www.contentstack.com/docs/developers/json-rich-text-editor#embed-entries-or-assets-within-json-rte)[ within JSON RTE](https://www.contentstack.com/docs/developers/json-rich-text-editor#embed-entries-or-assets-within-json-rte).

### Get ImageTransformation Utilities from the app-utils Repository

To add the image transformation functions that help apply image style and formatting to your project, perform the following steps:

1. Go to [image-preset-builder](https://github.com/contentstack/app-utils/tree/main/image-preset-builder) inside the [@contentstack/app-utils](https://github.com/contentstack/app-utils/) repository in GitHub. Here, you will find utility functions that will help you render your image as per your preset.
1. Open the folder that contains functions suitable to your project's programming language. Inside this folder, you will find a file that contains the formatting functions, e.g., ImageTransformation.js in JavaScript.
1. Copy the file into your project. This file will contain all the functions you need to render your image.

### Generate Styles and URLs for Images

Image Preset Builder allows you to build a preset consisting of different styles offered by either Contentstack or other CSS building sources. The server may not generate styles for special scenarios such as image focal point definitions and image rotation axis points. Hence, some transformation projects need you to define CSS styles locally or use third-party packages.

To apply appropriate style and formatting to your image presets while rendering them on the frontend, perform the following steps:

1. **Generate Image URL**

    From the ImageTransformation file, you can use the resolvePresetByPresetUID() function to generate a URL for the image that will contain the preset information.

    This function will take one object as an argument, and this object will require asset, presetUID, and extension_uid. You can extract these values from the Custom field or JSON RTE schemas defined in the previous section.

    For example, you can extract assets from custom-image-field.asset, presetUID from custom-image-field.metadata.preset.uid and extension_uid from custom-image-field.metadata.extension_uid.

    This function will return a **new asset object containing the new image URL**. Now, get the URL from the new asset and pass it against the <img/> tag’s src attribute.

2. **Generate CSS Styles for Image Presets**

    Next, to generate the CSS styles from the preset, you can use the resolvePresetStylesByPresetUID() function.

    This function accepts one object as an argument, and this object will require asset, presetUID, and extension_uid. You can extract these values from the Custom field or JSON RTE schemas defined in the previous section.

    The resolvePresetStylesByPresetUID() function will return inline styles for the image. These styles could be added to the <img/> tag.

3. **Handle Focal Image Points**

    Finally, you need to handle focal points (if applicable to your image preset). To retrieve the coordinates of the focal point, you can use the fetchPresetByPresetUID() function.

    This function accepts one object as an argument, and this object will require asset, presetUID, and extension_uid. You can extract these values from the Custom field or JSON RTE schemas defined in the previous section. The fetchPresetByPresetUID() function will return a preset object.

    Here is an example of the schema for the returned preset object:

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

    You can retrieve the focal point coordinates from the focal-point object. You need to use some third-party packages that will accept these coordinates and display the image accordingly on the frontend.

    For example, you can use the [image-focus](https://www.npmjs.com/package/image-focus) library for JavaScript.
