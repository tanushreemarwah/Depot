App.products = App.cable.subscriptions.create "ProductsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    document.getElementByTagName("main")[0].innerHTML = data.html
    # Called when there's incoming data on the websocket for this channel
