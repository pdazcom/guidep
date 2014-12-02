Router.route '/deps/create', name: 'createDep'
class @CreateDepController extends RouteController
  template: 'depForm'
  action: ->
    document.title = i18n 'deps.createDep'
    super()