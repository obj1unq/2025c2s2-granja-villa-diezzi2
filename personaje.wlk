import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method sembrar(especie) {
		self.validarCeldaParaSembrar()
		especie.serSembrado(self)
	}

	method validarCeldaParaSembrar() {
		if (not (game.colliders(self).isEmpty())) {
			self.error("No se puede cultivar acá")
		}
	}
}