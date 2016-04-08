---
---
$ ->
  toggleSublist = (element) ->
    item = $(element)
    item.next().slideToggle()
    $('.expand', item).toggleClass('flipped')

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
      if curstate ^ val
        filter.click()

  $('.sublist').prev().click ->
    toggleSublist(this)

  $('.toggle-filter').click ->
    $(this).siblings('.filters').slideToggle()

  $('.filter').change ->
    items = $(this)
      .closest('.item-list')
      .find('.' + this.name)
    items.next('.sublist:visible').prev().each ->
      toggleSublist(this)
    items.slideToggle()

  loadFilters()

  $('.filter').change ->
    saveFilters()