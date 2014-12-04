Template.depRow.helpers
  getMainDep: (depId)->
    if !depId.length
      return false
    dep = DepartmentsCollection.findOne _id: depId
    return dep.title[i18n.getLanguage()] || depId

  getTitle: (title)->
    return title[i18n.getLanguage()]