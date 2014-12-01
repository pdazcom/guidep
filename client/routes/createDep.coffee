Router.route '/deps/create', name: 'crateDep'
class @HomeController extends RouteController

  template: 'depForm'

  action: ->
    document.title = i18n 'deps.createDep'
    super()