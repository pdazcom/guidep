Router.route '/admin/deps', name: 'deps'
class @DepsController extends AdminPagebleRouteController
  template: 'deps'
  perPage: 20

  waitOn: ->
    console.info "waitOn: #{@url}"
    @subscribe 'adminDeps', @limit(), ()->
      console.warn "data loaded!"
#  subscriptions: ->
#    @subscribe 'adminDeps', @limit(), ()->
#      console.warn "data loaded!"

  data: ->
    deps: DepartmentsCollection.find()

  loaded: ->
    @limit() > DepartmentsCollection.find().count()

  action: ->
    document.title = i18n 'deps.title'
    super()

  onRun: ->
    @resetLimit()
    console.info "onRun(route): #{@.url}"
    @next()


  load: ->
    $('html, body').animate({ scrollTop: 0 }, 400)
    $('.content').hide().fadeIn(1000)