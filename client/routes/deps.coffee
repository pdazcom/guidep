Router.route '/deps', name: 'deps'
class @DepsController extends PagableRouteController
  template: 'deps'
  perPage: 20

  subscriptions: ->
    @subscribe 'adminDeps', @limit()

  data: ->
    deps: DepartmentsCollection.find()

  loaded: ->
    @limit() > DepartmentsCollection.find().count()

  action: ->
    document.title = i18n 'deps.title'
    super()

  onRun: ->
    @resetLimit()
    @next()