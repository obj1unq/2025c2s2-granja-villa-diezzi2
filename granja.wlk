object granjavilla {
    const cultivosSembrados    = []
    const cultivosCosechados   = []
    const aspersoresDeLaGranja = []
    const mercadosDeLaGranja   = []

    method esUnCultivoDeLaGranja(cosa) {
        return cultivosSembrados.contains(cosa)
    }

    method esUnMercadoDeGranja(cosa) {
        return mercadosDeLaGranja.contains(cosa)
    }

    method cultivosCosechados() {
        return cultivosCosechados
    }
    
    // Riego

    method colocarEnLaGranja(cosa) {
        aspersoresDeLaGranja.add(cosa)
    }

    // Siembra

    method sembrarEnLaGranja(cultivo) {
        cultivosSembrados.add(cultivo)
    }

    // Cosecha

    method guardarCosechaEnLaGranja(cultivo) {
        cultivosSembrados.remove(cultivo)
        cultivosCosechados.add(cultivo)
    }

    // Venta

    method valorDeCultivosCosechadosEnOro() {
        return cultivosCosechados.sum({cultivo => cultivo.valorDeCultivoEnOro()})
    }

    method venderCultivosCosechados() {
        cultivosCosechados.clear()
    }

    method cantidadDeCultivosCosechados() {
        return cultivosCosechados.size()
    }

    method construirEnLaGranja(mercado) {
        mercadosDeLaGranja.add(mercado)
    }
}