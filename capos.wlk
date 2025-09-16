// Personaje
object rolando {
    const property inventario = mochila
    const property historial = []
    var property hogar = castillo
    var property poderBase = 5
    var property enCastillo = false
    method recolectar(artefacto){
        if (!self.enCastillo()){
            historial.add(artefacto)
            inventario.agregar(artefacto)
        }
    }
    method guardarEnCastillo(){
        if (self.enCastillo()){
            hogar.guardarItems(inventario.items())
            inventario.borrarItems()
        }
    }
    method poderDePelea(){
      return poderBase + inventario.poderTotalDeArtefactos(self)
    }
    method usarArtefactos(){
      inventario.actualizarUsos()
    }
    method batallar() {
      self.usarArtefactos()
      poderBase += 1
    }
    method verItemsEnInventario(){
      return inventario.verItems()
    }
    method verItemsEnCastillo(){
      return castillo.verStash()
    }
    method itemsEnTotal(){
      return castillo.stash() + mochila.items()
    }
    method cantidadItemsTotales(){
      return self.itemsEnTotal().size()
    }
    method verItemsEnTotal(){
      return self.itemsEnTotal().map({item => item.nombre()})
    }
    method entrarCastillo(){
        enCastillo = true
    }
    method salirCastillo(){
        enCastillo = false
    }
    method tieneArtefacto(artefacto){
      return self.itemsEnTotal().contains(artefacto)
    }
    method cantidadHistorial(){
      return historial.size()
    }
}
// Mochila
object mochila {
  var property capacidad = 2
  const property items = #{}
  method agregar(item) {
    if (self.puedoAgregar()){
        items.add(item)
    }
  }
  method borrarItems() {
    items.clear()
  }
  method cantidadDeItems(){
    return items.size()
  }
  method puedoAgregar() {
    return self.cantidadDeItems() < capacidad
  }
  method verItems(){
    return items.map({item => item.nombre()})
  }
  method poderTotalDeArtefactos(personaje){
    return items.sum({item => item.poderArtefacto(personaje)})
  }
  method aumentarUso(item){
    item.usos(item.usos() + 1)
  }
  method actualizarUsos(){
    items.forEach({item => self.aumentarUso(item)})
  }
}
// Items
object espadaDelDestino {
  const property nombre = "Espada del Destino"
  var property usos = 0
  method poderArtefacto(personaje){
    if (usos == 0){
      return personaje.poderBase()
    }
    else{
      return personaje.poderBase() / 2
    }
  }
}
object libroDeHechizos {
  const property nombre = "Libro de Hechizos"
}
object collarDivino {
  const property nombre = "Collar Divino"
  var property usos = 0
  const poderCollar = 3
  method poderArtefacto(personaje){
    if (personaje.poderBase() > 6){
      return poderCollar + usos
    }
    else{
      return poderCollar
    }
  }
}
object armaduraDeAceroValyrio {
  const property nombre = "Armadura de acero Valyrio"
  var property usos = 0
  method poderArtefacto(personaje){
    return 6
  }
}

// Castillo
object castillo {
  const property stash = #{}
  method guardarItems(items){
    stash.addAll(items)
  }
  method cantidadDeItems(){
    return stash.size()
  }
  method verStash(){
    return stash.map({item => item.nombre()})
  }
}