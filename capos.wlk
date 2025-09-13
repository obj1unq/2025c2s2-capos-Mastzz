// Personaje
object rolando {
    const property inventario = mochila
    method recolectar(artefacto){
        inventario.agregar(artefacto)
    }
}
// Mochila
object mochila {
  var property capacidad = 0
  const property items = []
  method agregar(item) {
    if (self.puedoAgregar()){
        items.add(item)
    }
  }
  method cantidadDeItems(){
    return items.size()
  }
  method puedoAgregar() {
    return self.cantidadDeItems() < capacidad
  }
}
// Items
object espadaDelDestino {
}
object libroDeHechizos {
}
object collarDivino {
}
object armaduraDeAceroValyrio {
}