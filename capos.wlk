// Personaje
object rolando {
    const property inventario = mochila
    var property enCastillo = false
    // La mayor parte gira en torno a la responsabilidad de la mochila, de igual forma hago que se pueda acceder desde rolando a cada cosa y luego delego a donde realmente está la responsabilidad
    method recolectar(artefacto){
        if (!self.enCastillo()){
            inventario.agregar(artefacto)
        }
    }
    method guardar(){
        if (self.enCastillo()){
            castillo.guardarItems(inventario.items())
            inventario.borrarItems()
        }
    }
    // method verStash(){
    //     if (self.enCastillo()){
            
    //     }
    // }
    method entrarCastillo(){
        enCastillo = true
    }
    method salirCastillo(){
        enCastillo = false
    }
}
// Mochila
object mochila {
  var property capacidad = 0
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
}
// Items
object espadaDelDestino {
  const property nombre = "Espada del Destino"
}
object libroDeHechizos {
  const property nombre = "Libro de Hechizos"
}
object collarDivino {
  const property nombre = "Collar Divino"
}
object armaduraDeAceroValyrio {
  const property nombre = "Armadura de acero Valyrio"
}

// Castillo
object castillo {
  const property stash = #{}
  method guardarItems(items){
    items.forEach({item => stash.add(item)}) // nótese el bloque entiende "stash" (recuerda el contexto donde se definió) \\ además, como en la teoria del testing y el bloque anónimo, forEach probablemente en su implementación utilice un apply de nuestro lambda dado !!!
  }
  method cantidadDeItems(){
    return stash.size()
  }
  method verStash(){
    return stash.map({item => item.nombre()})
  }
}