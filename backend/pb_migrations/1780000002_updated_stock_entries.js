/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_stock_entries")


  collection.fields.addAt(5, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_108570809",
    "hidden": false,
    "id": "relation_stock_customer",
    "maxSelect": 1,
    "minSelect": 0,
    "name": "customer_id",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  collection.fields.addAt(6, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3355664324",
    "hidden": false,
    "id": "relation_stock_supplier",
    "maxSelect": 1,
    "minSelect": 0,
    "name": "supplier_id",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_stock_entries")

  collection.fields.removeById("relation_stock_customer")


  collection.fields.removeById("relation_stock_supplier")

  return app.save(collection)
})
