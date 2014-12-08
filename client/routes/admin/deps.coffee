Router.route '/admin/deps', name: 'deps'
class @DepsController extends AdminPagebleRouteController
  template: 'deps'
  perPage: 20

  waitOn: ->
    @subscribe 'adminDeps', @limit()

  data: ->
    deps: DepartmentsCollection.find()

  loaded: ->
    @limit() > DepartmentsCollection.find().count()

  action: ->
    document.title = i18n 'deps.title'
    super()

  onRun: ->
    console.log "onRun: #{this.url}"
    @resetLimit()
    @next()

  load: ->
    $('html, body').animate({ scrollTop: 0 }, 400)
    $('.content').hide().fadeIn(1000)