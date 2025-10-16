import wollok.game.*


class Mercado {
    var position
    const granja
    var oroDisponible
    const mercaderia = []

    method position() {
        return position
    }

    method image() {
        return "market.png"
    }

    method oroDisponible() {
        return oroDisponible
    }

    method registrarVenta() {
        oroDisponible -= granja.valorDeCultivosCosechadosEnOro()
        mercaderia.addAll(granja.cultivosCosechados())
    }

}

object mercado {
    
    method crearMercadoEn_Con_Oro_EnLaGranja_(positionDada, oroDado, granjaDada) {
        const nuevoMercado = new Mercado(position = positionDada, oroDisponible = oroDado, granja = granjaDada)
		granjaDada.construirEnLaGranja(nuevoMercado)
		game.addVisual(nuevoMercado)
    }
}