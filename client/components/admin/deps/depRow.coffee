Template.depRow.helpers
  getMainDep: (depId)->
    console.log depId
    dep = DepartmentsCollection.findOne _id: depId
    return dep.title.en_US || depId