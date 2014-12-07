Template.app.events
  'click .check-all': (e)->
    $('input.groupcheck').prop 'checked', e.target.checked