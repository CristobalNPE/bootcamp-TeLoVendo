function checkIfEmpty() {
  let elements = document.querySelectorAll("input, textarea");

  for (let i = 0; i < elements.length; i++) {
    let currentElement = elements[i];

    if (currentElement.value.trim().length == 0) {
      alert("El campo " + currentElement.id + " no puede estar vacio!");
    }
  }
}
