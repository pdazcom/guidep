Router.route '/admin/deps/create', name: 'createDep'
class @CreateDepController extends AdminRouteController
  template: 'depForm'

  action: ->
    document.title = i18n 'deps.createDep'
    super()