import wollok.game.*
import interfaz.*
import personajes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*
import sonidos.*
import movimiento.*
// CLASE VEHICULO , ES UNA SUBCLASE DE OBJETOMOVIL
class Vehiculo inherits ObjetoMovil{
	var property id = false
	// COLISION CON LA RANA
	method atropellar(ranita){
		soundProducer.sound("assets/sonidoAtropellar.wav").play()
		ranita.perderVida()
	}
	// LIMITE DEL JUEGO
	override method limite(){return [0,19]}
}
// CONSTRUCTOR DE LOS AUTOS
object autos inherits Conjunto{
	const velocidad = [600,550,350,300]
	
	var property listaAutos = [self.listaAutos(4, velocidad.get(0), "assets/auto3.png", 5, 2, izquierda),
							self.listaAutos(3, velocidad.get(1), "assets/auto2.png", 7, 3, derecha),
							self.listaAutos(2, velocidad.get(2), "assets/auto4.png", 10, 4, izquierda),
							self.listaAutos(5, velocidad.get(0), "assets/auto1.png", 5, 5, derecha),
							self.listaAutos(4, velocidad.get(3), "assets/auto5.png", 5, 6, izquierda)]
	

	
	// DEVUELVE TODOS LOS SUBCONJUNTOS
	override method todos(){
		return listaAutos.flatten()
	}
	// DETIENE TODOS LOS AUTOS
	override method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	// INICIALIZA LOS AUTOS
	override method setear(){
		super()
		self.todos().forEach({objeto => game.onCollideDo(objeto,{ranita => objeto.atropellar(ranita)})})
	}
	
	// CREA UNA LISTA DE CIERTA CANTIDAD DE AUTOS, VARIANDO LA POSICION DE CADA UNO DE ACUERDO A LA DISTANCIA (RELATIVA A LAS FILAS) ENTRE ELLOS
	method listaAutos(cantidad, _velocidad, imagen, distanciaEntreAutos, columna, sentido){
		const rango = new Range(start = 1, end = cantidad)
		const lista = []
		var fila = 0
		
		rango.forEach({e => lista.add(new Vehiculo(velocidad = _velocidad, image = imagen, movimiento = sentido, posicionInicial = game.at(fila,columna))) fila += distanciaEntreAutos})
		return lista
	}
}
