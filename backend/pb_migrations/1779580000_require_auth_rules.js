/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const rule = '@request.auth.id != ""'
  const collectionIds = [
    'pbc_4092854851',
    'pbc_3355664324',
    'pbc_108570809',
    'pbc_2697449135',
  ]

  for (const id of collectionIds) {
    const collection = app.findCollectionByNameOrId(id)
    unmarshal({
      createRule: rule,
      deleteRule: rule,
      listRule: rule,
      updateRule: rule,
      viewRule: rule,
    }, collection)
    app.save(collection)
  }
}, (app) => {
  const collectionIds = [
    'pbc_4092854851',
    'pbc_3355664324',
    'pbc_108570809',
    'pbc_2697449135',
  ]

  for (const id of collectionIds) {
    const collection = app.findCollectionByNameOrId(id)
    unmarshal({
      createRule: '',
      deleteRule: '',
      listRule: '',
      updateRule: '',
      viewRule: '',
    }, collection)
    app.save(collection)
  }
})
