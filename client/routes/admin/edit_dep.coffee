Router.route '/admin/deps/:id', name: 'editDep'
class @EditDepController extends AdminRouteController
  template: 'depForm'

  waitOn: ->
    @subscribe 'adminDeps', 1, @currentDepId()

  currentDepId: ->
    @params.id

  data: ->
    dep: DepartmentsCollection.findOne _id: @currentDepId()
    editDep: true

  action: ->
    document.title = i18n 'deps.editDep'
    super()

  onBeforeAction: ->
    if @data()
      return @next()
    Router.go pathFor 'deps'