---
---
$ ->
  $('.sublist').prev().click ->
    list = $(this)
    list.next().slideToggle()
    $('.expand', list).toggleClass('flipped')