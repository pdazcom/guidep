Template.depForm.helpers
  settings: ->
    position: "top"
    limit: 5
    rules: [
      token: '!'
      collection: Dataset
      field: "_id"
      options: ''
      matchAll: true
      filter:
        type: "autocomplete"
      template: Template.dataPiece
    ]