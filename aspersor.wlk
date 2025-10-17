import wollok.game.*

class Aspersor {
    var property position
    const granja

    method position() {
		return position
	}

    method image() {
        return "aspersor.png"
    }

    method comenzarRiego() {
        game.onTick(1000, "Riego automático", {self.regar()})
    }

    method regar() {
        self.cultivosCercanos().forEach({cultivo => cultivo.serRegado()})
    }

    method cultivosCercanos() {
        return self.cosasCercanas().filter({cosa => granja.esUnCultivoDeLaGranja(cosa)})
    }

    method cosasCercanas() {
        return (
            game.getObjectsIn(position.up(1))            +
            game.getObjectsIn(position.up(1).right(1))   +
            game.getObjectsIn(position.right(1))         +
            game.getObjectsIn(position.right(1).down(1)) +
            game.getObjectsIn(position.down(1))          +
            game.getObjectsIn(position.down(1).left(1))  +
            game.getObjectsIn(position.left(1))          +
            game.getObjectsIn(position.left(1).up(1))
               )
    }
}

object aspersor {
    
    method serColocado(granjero) {
		const nuevoAspersor = new Aspersor(position = granjero.position(), granja = granjero.granja())
		granjero.granja().colocarEnLaGranja(nuevoAspersor)
		game.addVisual(nuevoAspersor)
        nuevoAspersor.comenzarRiego()
	}
}