window.attachPickers = () ->
  baseOptions =
    useSeconds: false
    format: 'YYYY-MM-DD'
    minDate: '1900-01-01'
    icons:
      time: 'fa fa-clock-o'
      date: 'fa fa-calendar'
      up:   'fa fa-arrow-up'
      down: 'fa fa-arrow-down'
  $('.has-datepicker').each( () ->
    console.log "hooking datepicker onto:"
    console.log @
    $(@).datetimepicker( $.extend({}, baseOptions, { pickTime: false }) )
  )
  $('.has-timepicker').each( () ->
    console.log "hooking timepicker onto:"
    console.log @
    $(@).datetimepicker( $.extend({}, baseOptions, { pickDate: false }) )
  )
  $('.has-datetimepicker').each( () ->
    console.log "hooking datetimepicker onto:"
    console.log @
    $(@).datetimepicker( $.extend({}, baseOptions, { sideBySide: true }) )
  )

$(document).ready( () ->
  window.attachPickers()
)
