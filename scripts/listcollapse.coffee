---
---
$ ->
  toggleSublist = (element) ->
    item = $(element)
    item.next().slideToggle()
    $('.expand', item).toggleClass('flipped')

  $('.sublist').prev().click ->
    toggleSublist(this)

  $('.toggle-filter').click ->
    $(this).siblings('.filters').slideToggle()

  $('.filter').change ->
    items = $(this)
      .closest('.filters')
      .siblings('ul')
      .find('.' + this.name)
    items.next('.sublist:visible').prev().each ->
      toggleSublist(this)
    items.slideToggle()
