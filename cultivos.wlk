import wollok.game.*
import personaje.*
import granja.*

class Maiz {
	var position

	method position() {
		return position
	}

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_baby.png"
	}
}

class Tomaco {
	var position

	method position() {
		return position
	}

	method image() {
		return "tomaco_baby.png"
	}
}

class Trigo {
	var position

	method position() {
		return position
	}

	method image() {
		return "wheat_0.png"
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