Router.route '/', name: 'home'
class @HomeController extends RouteController

  action: ->
    document.title = i18n 'homepage.title'
    super()
