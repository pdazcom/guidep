Router.route '/admin', name: 'admin'
class @AdminController extends AdminRouteController
  template: 'adminHome'
  action: ->
    document.title = i18n 'admin.title'
    super()
