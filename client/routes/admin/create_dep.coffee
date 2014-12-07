Router.route '/admin/deps/create', name: 'createDep'
class @CreateDepController extends AdminRouteController
  template: 'depForm'

  data: ->
    dep: {}
    editDep: false

  action: ->
    document.title = i18n 'deps.createDep'
    super()