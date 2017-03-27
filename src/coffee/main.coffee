document.addEventListener 'DOMContentLoaded', ->

  $ ->
    'use strict'
    #Activate tooltips
    $('[data-toggle=\'tooltip\']').tooltip()
    $('[data-toggle=\'utility-menu\']').click ->
      $(this).next().slideToggle 300
      $(this).toggleClass 'open'
      false
    # Login Page Flipbox control
    $('#toFlip').click ->
      loginFlip()
      false
    $('#noFlip').click ->
      loginFlip()
      false
    # Navbar height : Using slimscroll for sidebar
    # if $('body').hasClass('fixed') or $('body').hasClass('only-sidebar')
    #   $('.sidebar').slimScroll
    #     height: $(window).height() - $('.main-header').height() + 'px'
    #     color: 'rgba(0,0,0,0.8)'
    #     size: '3px'
    # else
    #   docHeight = $(document).height()
    #   $('.main-sidebar').height docHeight
    # return

  # Sidenav prototypes
  $.pushMenu = activate: (toggleBtn) ->
    #Enable sidebar toggle
    $(toggleBtn).on 'click', (e) ->
      e.preventDefault()
      #Enable sidebar push menu
      if $(window).width() > 767
        if $('body').hasClass('sidebar-collapse')
          $('body').removeClass('sidebar-collapse').trigger 'expanded.pushMenu'
        else
          $('body').addClass('sidebar-collapse').trigger 'collapsed.pushMenu'
      else
        if $('body').hasClass('sidebar-open')
          $('body').removeClass('sidebar-open').removeClass('sidebar-collapse').trigger 'collapsed.pushMenu'
        else
          $('body').addClass('sidebar-open').trigger 'expanded.pushMenu'
      if $('body').hasClass('fixed') and $('body').hasClass('sidebar-mini') and $('body').hasClass('sidebar-collapse')
        $('.sidebar').css 'overflow', 'visible'
        $('.main-sidebar').find('.slimScrollDiv').css 'overflow', 'visible'
      if $('body').hasClass('only-sidebar')
        $('.sidebar').css 'overflow', 'visible'
        $('.main-sidebar').find('.slimScrollDiv').css 'overflow', 'visible'
      return
    $('.content-wrapper').click ->
      #Enable hide menu when clicking on the content-wrapper on small screens
      if $(window).width() <= 767 and $('body').hasClass('sidebar-open')
        $('body').removeClass 'sidebar-open'
      return
    return

  $.tree = (menu) ->
    _this = this
    animationSpeed = 200
    $(document).on 'click', menu + ' li a', (e) ->
      # Get the clicked link and the next element
      $this = $(this)
      checkElement = $this.next()
      # Check if the next element is a menu and is visible
      if checkElement.is('.treeview-menu') and checkElement.is(':visible')
        # Close the menu
        checkElement.slideUp animationSpeed, ->
          checkElement.removeClass 'menu-open'
          # Fix the layout in case the sidebar stretches over the height of the window
          # _this.layout.fix();
          return
        checkElement.parent('li').removeClass 'active'
      else if checkElement.is('.treeview-menu') and !checkElement.is(':visible')
        # Get the parent menu
        parent = $this.parents('ul').first()
        # Close all open menus within the parent
        ul = parent.find('ul:visible').slideUp(animationSpeed)
        # Remove the menu-open class from the parent
        ul.removeClass 'menu-open'
        # Get the parent li
        parent_li = $this.parent('li')
        # Open the target menu and add the menu-open class
        checkElement.slideDown animationSpeed, ->
          # Add the class active to the parent li
          checkElement.addClass 'menu-open'
          parent.find('li.active').removeClass 'active'
          parent_li.addClass 'active'
          return
      # if this isn't a link, prevent the page from being redirected
      if checkElement.is('.treeview-menu')
        e.preventDefault()
      return
    return

  # Activate sidenav treemenu
  $.tree '.sidebar'
  $.pushMenu.activate '[data-toggle="offcanvas"]'

  # ---
