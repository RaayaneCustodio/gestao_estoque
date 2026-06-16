/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // add
  collection.fields.addAt(4, new Field({
    "hidden": false,
    "id": "file_image_product",
    "maxSelect": 1,
    "maxSize": 5242880, 
    "mimeTypes": [
      "image/jpeg",
      "image/png",
      "image/svg+xml",
      "image/gif",
      "image/webp"
    ],
    "name": "imagemProduto",
    "presentable": false,
    "protected": false,
    "required": false,
    "system": false,
    "thumbs": [],
    "type": "file"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // remove
  collection.fields.removeById("file_image_product")

  return app.save(collection)
})
