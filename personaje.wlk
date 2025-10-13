import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	// Siembra

	method sembrar(especie) {
		self.validarCeldaParaSiembra()
		especie.serSembrado(self)
	}
	
	method validarCeldaParaSiembra() {
		if (not (self.esCeldaVacia())) {
			self.error("No se puede cultivar acá")
		}
	}

	// Riego

	method regar() {
		self.validarCeldaParaRiego()
		
	}

	method validarCeldaParaRiego(){
		if (not self.hayCultivoAca()) {
			self.error("No tengo nada para regar acá")
		}
	}

	// Chequeos de celda actual

	method esCeldaVacia() {
		return game.colliders(self).isEmpty()
	}

	method hayCultivoAca() {
		return (not self.esCeldaVacia()) and game.uniqueCollider(self).esCultivo()
	}
}