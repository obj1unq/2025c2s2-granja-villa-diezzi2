import aspersor.*
import wollok.game.*
import cultivos.*
import granja.*


object personaje {
	var property position      = game.center()
	const property image       = "fplayer.png"
	var property granja        = granjavilla
	var property oroDisponible = 0

	// Siembra

	method sembrar(especie) {
		self.validarCeldaParaSiembra()
		especie.serSembrado(self)
	}
		// Validador para siembra
	method validarCeldaParaSiembra() {
		if (not (self.esCeldaVacia())) {
			self.error("No se puede cultivar acá")
		}
	}

	// Riego

	method regar() {
		self.validarCeldaParaRiego()
		game.uniqueCollider(self).serRegado()
	}
		// Validador para riego
	method validarCeldaParaRiego(){
		if (not self.hayCultivoAca()) {
			self.error("No tengo nada para regar acá")
		}
	}

		// Aspersor

	method colocarAspersor() {
		self.validarCeldaParaColocarAspersor()
		aspersor.serColocado(self)
	}

	method validarCeldaParaColocarAspersor() {
	   	if (not self.esCeldaVacia()) {
	 			self.error("No puedo poner un aspersor acá")
	 		}
	}

	// Cosecha

	method cosechar() {
		self.validarCeldaParaCosecha()
		game.uniqueCollider(self).serCosechado()
	}
		// Validador para cosecha
	method validarCeldaParaCosecha(){
		if (not self.hayCultivoAca()) {
			self.error("No tengo nada para cosechar acá")
		}
	}

	// Venta

	method vender() {
		self.validarSiHayMercado()
		self.validarVenta()
		oroDisponible += granja.valorDeCultivosCosechadosEnOro()
		game.uniqueCollider(self).registrarVenta()
		granja.venderCultivosCosechados()
	}

	method comprobarOroYContarCosecha() {
		game.say(self, "Tengo " + oroDisponible.toString() + " monedas y " + granja.cantidadDeCultivosCosechados().toString() + " plantas para vender")
	}
		// Validadores para venta
	method validarSiHayMercado() {
		if (not self.hayMercadoAca()) {
			self.error("Solamente puedo vender en un mercado")
		}
	}

	method validarVenta() {
		if (not self.elMercadoTieneOroSuficiente()) {
			self.error("Este mercado no tiene oro suficiente")
		}
	}

	// Booleanos

	method esCeldaVacia() {
		return game.colliders(self).isEmpty()
	}

	method hayCultivoAca() {
		return (not self.esCeldaVacia()) and granja.esUnCultivoDeLaGranja(game.uniqueCollider(self))
	}

	method hayMercadoAca() {
		return (not self.esCeldaVacia()) and granja.esUnMercadoDeGranja(game.uniqueCollider(self))
	}

	method elMercadoTieneOroSuficiente() {
		return game.uniqueCollider(self).oroDisponible() >= oroDisponible
	}

	// Movimiento

	method moverIzquierda(posiciones) {
		position = game.at(0.max(position.x() - posiciones), position.y())
	}

	method moverDerecha(posiciones) {
	 	position = game.at((game.width() - 1).min(position.x() + posiciones), position.y())
	}
	
	method moverArriba(posiciones) {
	  	position = game.at(position.x(), (game.height() - 1).min(position.y() + posiciones))
	}
	
	method moverAbajo(posiciones) {
	  	position = game.at(position.x(), 0.max(position.y() - posiciones))
	}
}