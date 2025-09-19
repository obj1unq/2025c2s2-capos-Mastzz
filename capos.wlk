// Personajes
// RONALDOOOO SIUUUUUU
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
    method cualesPuedeVencer(tierra){
      return tierra.cualesPuedeVencer(self)
    }
    method queMoradasConquista(tierra) {
      return tierra.queMoradasConquista(self)
    }
    method poderDePelea(){
      return poderBase + inventario.poderTotalDeArtefactos(self)
    }
    method batallar() {
      inventario.usarArtefactos()
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
    method poderMejorArtefactoDelHogar() {
      return hogar.poderMejorArtefacto(self)
    }
    method tieneArtefactoFatal(enemigo){
      return inventario.hayArtefactoFatal(self, enemigo)
    }
}
// Mochila
object mochila {
  var property capacidad = 2
  var property items = #{}
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
  method usarArtefactos(){
    items.forEach({item => item.usarArtefacto()})
  }
  method esPoderMayor(item, personaje, enemigo) {
    return item.poderArtefacto(personaje) > enemigo.poderDePelea()
  }
  method hayArtefactoFatal(personaje, enemigo){
    return items.findOrDefault({item => self.esPoderMayor(item, personaje, enemigo)}, null)
  }
  
}
// CATERINAAAAA
object caterina {
  var property poderBase = 28
  var property hogar = fortalezaAcero
  method poderDePelea(){
    return poderBase
  }
}
// ARCHIBALDOOOOO
object archibaldo {
  var property poderBase = 16
  var property hogar = palacioMarmol
  method poderDePelea(){
    return poderBase
  }
}
// ASTRAAAAAAAAAA
object astra {
  var property poderBase = 14
  var property hogar = torreMarfil
  method poderDePelea(){
    return poderBase
  }
}
// Items
object espadaDelDestino {
  const property nombre = "Espada del Destino"
  var property usado = false
  method poderArtefacto(personaje){
    return if(!usado) personaje.poderBase() else personaje.poderBase() / 2
  }
  method usarArtefacto(){
    usado = true
  }
}
object libroDeHechizos {
  const property nombre = "Libro de Hechizos"
  var property hechizos = []

  method poderPrimerHechizo(personaje) {
    return hechizos.first().poderPelea(personaje)
  }
  method poderArtefacto(personaje){
    return if(hechizos.size() != 0) self.poderPrimerHechizo(personaje) else 0
  }
  method usarArtefacto(){
    hechizos.remove(hechizos.first())
  }

}
// Hechizos
object bendicion {
  method poderPelea(personaje){
    return 4
  }
}
object invisibilidad {
  method poderPelea(personaje) {
    return personaje.poderBase()
  }
}
object invocacion {
  method poderPelea(personaje) {
    return personaje.poderMejorArtefactoDelHogar()
  }
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
  method usarArtefacto(){
    usos += 1
  }
}
object armaduraDeAceroValyrio {
  const property nombre = "Armadura de acero Valyrio"
  method poderArtefacto(personaje){
    return 6
  }
  method usarArtefacto(){
  }
}

// Hogares
object castillo {
  var property stash = #{}
  method guardarItems(items){
    stash.addAll(items)
  }
  method cantidadDeItems(){
    return stash.size()
  }
  method verStash(){
    return stash.map({item => item.nombre()})
  }
  method mejorArtefacto(personaje){
    return stash.max({item => item.poderArtefacto(personaje)})
  }
  method poderMejorArtefacto(personaje) {
    return if(stash.size() != 0) self.mejorArtefacto(personaje).poderArtefacto(personaje) else 0
  }
}

object fortalezaAcero {
  
}
object palacioMarmol {
  
}
object torreMarfil{

}
// Tierra de erethia
object erethia {
  const property enemigos = #{caterina, archibaldo, astra}
  method cualesPuedeVencer(personaje){
    return enemigos.filter({enemigo => self.puedeVencerlo(personaje, enemigo) })
  }
  method puedeVencerlo(personaje, enemigo){
    return personaje.poderDePelea() > enemigo.poderDePelea()
  }
  // Cuidado que map devuelve una lista (conversión implícita en este caso que lo utilizo sobre un set) por lo que le envío el mensaje 'asSet'
  method queMoradasConquista(personaje) {
    return self.cualesPuedeVencer(personaje).map({enemigo => enemigo.hogar()}).asSet()
  }
  method esPoderoso(personaje) {
    return enemigos == self.cualesPuedeVencer(personaje)
  }
}

