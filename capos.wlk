// Personaje
object rolando {
    const property inventario = mochila
    var property enCastillo = false
    method recolectar(artefacto){
        if (!self.enCastillo()){
            inventario.agregar(artefacto)
        }
    }
    method guardar(){
        if (self.enCastillo()){
            castillo.guardarItems(inventario.items())
            inventario.items().clear()
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

// Castillo
object castillo {
  const property stash = []
  method guardarItems(items){
    items.forEach({item => stash.add(item)})
  }
  method cantidadDeItems(){
    return stash.size()
  }
}