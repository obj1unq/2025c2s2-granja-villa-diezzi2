import wollok.game.*
import personaje.*
import granja.*

class Maiz {
	var position
	var etapaDeCrecimientoActual = etapaDeMaizBaby
	const etapaDeCrecimientoMaxima = etapaDeMaizAdult

	method position() {
		return position
	}

	method image() {
		return etapaDeCrecimientoActual.image()
	}

	method esCultivo() {
		return true
	}

	method serRegado() {
		if (etapaDeCrecimientoActual != etapaDeCrecimientoMaxima) {
			etapaDeCrecimientoActual = etapaDeCrecimientoActual.siguienteEtapaDeCrecimiento()
		}
	}
}

object etapaDeMaizBaby {
	const siguienteEtapaDeCrecimiento = etapaDeMaizAdult

	method image(){
		return "corn_baby.png"
	}

	method siguienteEtapaDeCrecimiento() {
		return siguienteEtapaDeCrecimiento
	}
}

object etapaDeMaizAdult {
	
	method image(){
		return "corn_adult.png"
	}
}

class Tomaco {
	var property position

	method image() {
		return "tomaco_baby.png"
	}

	method esCultivo() {
		return true
	}

	method serRegado() {
		self.validarRiegoDeTomaco()
		position = self.siguientePosicionDeTomaco()
	}

	method siguientePosicionDeTomaco() {
		if (self.estaEnElBorde()) {
			return game.at(position.x(), 0)
		}
		else return position.up(1)
	}

	method validarRiegoDeTomaco() {
		if (self.estaOcupadaLaSiguientePosicion()){
			self.error("No hay espacio para regar este tomaco")
		}
	}

	method estaEnElBorde() {
		return position.y() == game.height() - 1
	}

	method estaOcupadaLaSiguientePosicion() {
		return not game.getObjectsIn(self.siguientePosicionDeTomaco()).isEmpty()
	}
}

class Trigo {
	var position
	var etapaDeCrecimientoActual = 0
	var etapaDeCrecimientoMaxima = 3

	method position() {
		return position
	}

	method image() {
		return "wheat_" + etapaDeCrecimientoActual.toString() + ".png"
	}

	method esCultivo() {
		return true
	}

	method serRegado() {
		if (etapaDeCrecimientoActual == etapaDeCrecimientoMaxima) {
			etapaDeCrecimientoActual = 0
		}
		else etapaDeCrecimientoActual += 1
	}
}

object maiz {
	var granja = granjavilla
	method serSembrado(granjero) {
		const nuevoMaiz = new Maiz(position = granjero.position())
		granja.incluirEnLaGranja(nuevoMaiz)
		game.addVisual(nuevoMaiz)
	}
}

object tomaco {
	var granja = granjavilla
	method serSembrado(granjero) {
		const nuevoTomaco = new Tomaco(position = granjero.position())
		granja.incluirEnLaGranja(nuevoTomaco)
		game.addVisual(nuevoTomaco)
	}
}

object trigo {
	var granja = granjavilla
	method serSembrado(granjero) {
		const nuevoTrigo = new Trigo(position = granjero.position())
		granja.incluirEnLaGranja(nuevoTrigo)
		game.addVisual(nuevoTrigo)
	}
}