---
---
$ ->

  $.fn.hideItem = () ->
    if this.is(':visible')
      if this.next('.sublist').is(':visible')
        this.toggleSublist()
      this.slideToggle()
    return this

  $.fn.showItem = () ->
    if this.is(':hidden')
      this.slideToggle()
    return this

  $.fn.toggleSublist = () ->
    this.next('.sublist').slideToggle()
    $('.expand', this).toggleClass('flipped')
    return this

  saveFilters = ->
    cookieval = {}
    $('.filter').each ->
      cookieval[this.id] = this.checked
      return true
    Cookies.set('filters', cookieval)

  loadFilters = ->
    filters = Cookies.getJSON('filters')
    for id, val of filters
      filter = $('#' + id)
      curstate = filter.prop('checked')
      if curstate != val
        filter.click()

  $('.sublist').prev('.list-group-item').click ->
    $(this).toggleSublist()

  $('.toggle-filter').click ->
    $(this).siblings('.filters').slideToggle()

  $('.filter').change ->
    items = $(this)
      .closest('.item-list')
      .find('.' + this.name)
    if this.checked then items.showItem() else items.hideItem()

  loadFilters()

  $('.filter').change ->
    saveFilters()