@UpdateCounter = -> 
  textArea = document.getElementById('micropost_content')
  counter = document.getElementById('countdown_value')
  if (textArea && counter)
    counter.innerText = 140 - textArea.value.length
