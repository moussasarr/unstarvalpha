window.client = new Faye.Client('/faye')

client.addExtension {
  outgoing: (message, callback) ->
    message.ext = message.ext || {}
    message.ext.csrfToken = $('meta[name=csrf-token]').attr('content')
    callback(message)
}

jQuery ->
  $('#new_group_groupchatcomment').submit ->
    $(this).find("input[type='submit']").val('Sending...').prop('disabled', true)

  try
    client.unsubscribe '/groupchatcomments'
  catch
    console?.log "Can't unsubscribe."

  client.subscribe '/groupchatcomments', (payload) ->
    $('#groupchatcomments').find('.media-list').prepend(payload.message) if payload.message