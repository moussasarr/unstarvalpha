window.Grouppoller = {
  poll: (timeout) ->
    if timeout is 0
      Grouppoller.request()
    else
      this.pollTimeout = setTimeout ->
        Grouppoller.request()
      , timeout || 5000
  clear: -> clearTimeout(this.pollTimeout)
  request: ->
    first_id = $('.groupchatcomment').first().data('id')
    $.get('/groupchatcomments', after_id: first_id)
}

jQuery ->
  Grouppoller.poll() if $('#groupchatcomments').size() > 0
  return



