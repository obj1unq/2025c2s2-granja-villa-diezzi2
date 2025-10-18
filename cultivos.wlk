import wollok.game.*
import personaje.*
import granja.*


// Clase Maíz -------------------------------------------------------------------------------


class Maiz {
	var position
	var etapaDeCrecimientoActual   = etapaDeMaizBaby
	const etapaDeCrecimientoMaxima = etapaDeMaizAdult
	const valorDeCultivoEnOro      = 150
	const granja

	method position() {
		return position
	}

	method image() {
		return etapaDeCrecimientoActual.image()
	}

	method esAdulto() {
		return etapaDeCrecimientoActual == etapaDeCrecimientoMaxima
	}


	// Riego

	method serRegado() {
		if (etapaDeCrecimientoActual != etapaDeCrecimientoMaxima) {
			etapaDeCrecimientoActual = etapaDeCrecimientoActual.siguienteEtapaDeCrecimiento()
		}
	}

	// Cosecha

	method serCosechado() {
		self.validarSiEsCosechable()
		granja.guardarCosechaEnLaGranja(self)
		game.removeVisual(self)
	}

	method validarSiEsCosechable() {
		if (etapaDeCrecimientoActual != etapaDeCrecimientoMaxima) {
			self.error("Aún no se puede cosechar este maíz")
		}
	}
	
	// Venta

	method valorDeCultivoEnOro() {
		return valorDeCultivoEnOro
	}
}

	// Etapas de crecimiento de maíz

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


// Clase Tomaco -----------------------------------------------------------------------------


class Tomaco {
	var property position
	const granja
	const valorDeCultivoEnOro = 80

	method image() {
		return "tomaco_baby.png"
	}

	// Riego

	method serRegado() {
		self.validarRiegoDeTomaco()
		position = self.siguientePosicionDeTomaco()
	}
		// Nueva posición tras riego
	method siguientePosicionDeTomaco() {
		if (self.estaEnElBorde()) {
			return game.at(position.x(), 0)
		}
		else return position.up(1)
	}
		// Validador para riego
	method validarRiegoDeTomaco() {
		if (self.estaOcupadaLaSiguientePosicion()){
			self.error("No hay espacio para regar este tomaco")
		}
	}
		// Booleanos para Riego
	method estaEnElBorde() {
		return position.y() == game.height() - 1
	}

	method estaOcupadaLaSiguientePosicion() {
		return not game.getObjectsIn(self.siguientePosicionDeTomaco()).isEmpty()
	}

	// Cosecha

	method serCosechado() {
		granja.guardarCosechaEnLaGranja(self)
		game.removeVisual(self)
	}

	// Venta

	method valorDeCultivoEnOro() {
		return valorDeCultivoEnOro
	}
}


// Clase Trigo ------------------------------------------------------------------------------


class Trigo {
	var position
	var granja
	var etapaDeCrecimientoActual   = 0
	const etapaDeCrecimientoMaxima = 3

	method position() {
		return position
	}

	method image() {
		return "wheat_" + etapaDeCrecimientoActual.toString() + ".png"
	}

	method etapaDeCrecimientoActual() {
		return etapaDeCrecimientoActual
	}

	// Riego

	method serRegado() {
		if (etapaDeCrecimientoActual == etapaDeCrecimientoMaxima) {
			etapaDeCrecimientoActual = 0
		}
		else etapaDeCrecimientoActual += 1
	}

	// Cosecha

	method serCosechado() {
		self.validarSiEsCosechable()
		granja.guardarCosechaEnLaGranja(self)
		game.removeVisual(self)
	}

	method validarSiEsCosechable() {
		if (etapaDeCrecimientoActual < 2) {
			self.error("Aún no se puede cosechar este trigo")
		}
	}

	// Venta

	method valorDeCultivoEnOro() {
	   return (etapaDeCrecimientoActual - 1) * 100
	}
}


// Instancias de cultivos -------------------------------------------------------------------


// Maíz

object maiz {

	method serSembrado(granjero) {
		const nuevoMaiz = new Maiz(position = granjero.position(), granja = granjero.granja())
		granjero.granja().sembrarEnLaGranja(nuevoMaiz)
		game.addVisual(nuevoMaiz)
	}
}

// Tomaco

object tomaco {

	method serSembrado(granjero) {
		const nuevoTomaco = new Tomaco(position = granjero.position(), granja = granjero.granja())
		granjero.granja().sembrarEnLaGranja(nuevoTomaco)
		game.addVisual(nuevoTomaco)
	}
}

// Trigo

object trigo {
	
	method serSembrado(granjero) {
		const nuevoTrigo = new Trigo(position = granjero.position(), granja = granjero.granja())
		granjero.granja().sembrarEnLaGranja(nuevoTrigo)
		game.addVisual(nuevoTrigo)
	}
}