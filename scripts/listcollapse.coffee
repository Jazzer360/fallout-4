---
---
$ ->
  $items = $('.list-group-item')

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
    show = $items.filter ->
      if this.getAttribute('data-type') not in typeFilters
        return false
      dlc = this.getAttribute('data-dlc')
      if dlc and dlc not in dlcFilters
        return false
      name = this.getAttribute('data-name')
      if textFilter and name.indexOf(textFilter) is -1
        return false
      return true
    hide = $items.not show
    show.show()
    show.each ->
      if $('.expand', this).hasClass('flipped')
        $(this).next('.sublist').show()
    hide.hide()
    hide.next('.sublist').hide()

  $('.type-filter').change filterItems
  $('#text-filter').on 'input', filterItems

  $('.sublist').prev('.list-group-item').click ->
    $(this).toggleSublist()
