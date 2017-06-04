// for phoenix_html support, including form and button helpers
// copy the following scripts into your javascript bundle:
// * https://raw.githubusercontent.com/phoenixframework/phoenix_html/v2.3.0/priv/static/phoenix_html.js

var socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
var channel = socket.channel("item:*", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

let itemsTable = document.querySelector('.table-items')

itemsTable.addEventListener('click', event => {
  let id = parseInt(event.target.getAttribute('data-id'))
  if (isNaN(id)) return

  channel
    .push('toggle_favorite', {id: id})
    .receive('ok', item => {
      newRow = createRow(item)
      event.target.parentNode.replaceWith(newRow)
    })
})

function createRow({id, value, favorited}) {
  tdValue = document.createElement('td')
  tdValue.textContent = value

  tdFavorited = document.createElement('td')
  tdFavorited.textContent = favorited
  tdFavorited.setAttribute('data-id', id)

  tr = document.createElement('tr')
  tr.appendChild(tdValue)
  tr.appendChild(tdFavorited)
  return tr
}
