---
---
$ ->
  $items = $('list-group-item')

  $.fn.hideItem = () ->
    this.each ->
      item = $(this)
      if item.is(':visible')
        if item.next('.sublist').is(':visible')
          item.toggleSublist()
        item.slideToggle()

  $.fn.showItem = () ->
    this.each ->
      item = $(this)
      if item.is(':hidden')
        item.slideToggle()

  $.fn.toggleSublist = () ->
    this.next('.sublist').slideToggle()
    $('.expand', this).toggleClass('flipped')
    return this

  filterItems = ->
    textFilter = $('#text-filter').val().toLowerCase()
    typeFilters = []
    dlcFilters = []
    $('.type-filter').each ->
      if this.checked
        typeFilters.push(this.name)
    $('.dlc-filter').each ->
      if this.checked
        dlcFilters.push(this.name)
    show = items.filter ->
      if this.getAttribute('data-name').indexOf(textFilter) is -1
        return false
      else if this.getAttribute('data-type') not in typeFilters
        return false
      else
        dlc = this.getAttribute('data-dlc')
        if not dlc
          return true
        else if dlc not in dlcFilters
          return false
        else
          return true
    hide = items.not show
    show.showItem()
    hide.hideItem()

  $('.type-filter').change filterItems
  $('#text-filter').on 'input', filterItems



  # saveFilters = ->
  #   cookieval = {}
  #   $('.filter').each ->
  #     cookieval[this.id] = this.checked
  #     return true
  #   Cookies.set('filters', cookieval)

  # loadFilters = ->
  #   filters = Cookies.getJSON('filters')
  #   for id, val of filters
  #     filter = $('#' + id)
  #     curstate = filter.prop('checked')
  #     if curstate != val
  #       filter.click()

  $('.sublist').prev('.list-group-item').click ->
    $(this).toggleSublist()

  # $('.filter').change ->
  #   items = $(this)
  #     .closest('.item-list')
  #     .find('.' + this.name)
  #   if this.checked then items.showItem() else items.hideItem()

  #loadFilters()

  # $('.filter').change ->
  #   saveFilters()


