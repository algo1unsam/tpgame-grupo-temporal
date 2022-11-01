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
	
	var property subc1 = self.listaAutos(4, velocidad.get(0), "assets/auto3.png", 5, 2, moverseIzquierda)
	
	var property subc2 = self.listaAutos(3, velocidad.get(1), "assets/auto2.png", 7, 3, moverseDerecha)

	var property subc3 = self.listaAutos(2, velocidad.get(2), "assets/auto4.png", 10, 4, moverseIzquierda)

	var property subc4 = self.listaAutos(5, velocidad.get(0), "assets/auto1.png", 5, 5, moverseDerecha)
	
	var property subc5 = self.listaAutos(4, velocidad.get(3), "assets/auto5.png", 5, 6, moverseIzquierda)
	
	// DEVUELVE TODOS LOS SUBCONJUNTOS
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
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
