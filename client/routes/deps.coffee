Router.route '/deps', name: 'deps'
class @DepsController extends RouteController
  template: 'deps'

  action: ->
    document.title = i18n 'deps.title'
    super()
