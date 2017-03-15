document.addEventListener 'DOMContentLoaded', ->

  
  # the left side is the module ID,
  # the right side is the path to
  # the javascript file, relative to baseUrl.
  # Also, the path should NOT include
  # the '.js' file extension.
  requirejs.config
    baseUrl: 'assets/js/lib'
    paths: jquery: 'jquery.min'

  init = ->
    define 'jQuery', [ 'jquery' ], ->
    require [ 'jQuery' ], ->
      if window.jQuery != 'undefined'
        console.log 'is jQuery'
      return
    return


  init()
  return
