/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // add field
  collection.fields.addAt(2, new Field({
    "help": "",
    "hidden": false,
    "id": "number1114912523",
    "max": null,
    "min": null,
    "name": "quantidade",
    "onlyInt": false,
    "presentable": false,
    "required": true,
    "system": false,
    "type": "number"
  }))

  // add field
  collection.fields.addAt(3, new Field({
    "help": "",
    "hidden": false,
    "id": "number587674275",
    "max": null,
    "min": null,
    "name": "preco",
    "onlyInt": false,
    "presentable": false,
    "required": true,
    "system": false,
    "type": "number"
  }))

  // add field
  collection.fields.addAt(4, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3355664324",
    "help": "",
    "hidden": false,
    "id": "relation3741688275",
    "maxSelect": 0,
    "minSelect": 0,
    "name": "supplierId",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_4092854851")

  // remove field
  collection.fields.removeById("number1114912523")

  // remove field
  collection.fields.removeById("number587674275")

  // remove field
  collection.fields.removeById("relation3741688275")

  return app.save(collection)
})
