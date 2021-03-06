var socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

var channel = socket.channel("item:*", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

document.querySelector('.table-items').addEventListener('click', event => {
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
