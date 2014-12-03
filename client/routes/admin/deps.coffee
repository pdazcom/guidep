Router.route '/admin/deps', name: 'deps'
class @DepsController extends AdminPagableRouteController
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

  load: ->
    $('html, body').animate({ scrollTop: 0 }, 400)
    $('.content').hide().fadeIn(1000)