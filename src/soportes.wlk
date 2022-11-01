import wollok.game.*
import interfaz.*
import personajes.*
import filasExteriores.*
import autos.*
import rio.*
import personajesAuxiliares.*
// CLASE DE LOS SOPORTES, ES UNA SUBCLASE DE OBJETO MOVIL
class Soporte inherits ObjetoMovil{
	var property id = true 
	// METODO DEL MOVIMIENTO, SI LA RANA ESTA EN EL SOPORTE PUEDE MOVERSE POR ESTE
	override method moverse(){
		if(self.posicionesExtra().contains(rana.position())){
			if(rana.position().x() == -1 or rana.position().x() == 20){
				rana.perderVida()
			}else{
				rana.position(self.siguientePosicion())
			}
		}	
		super()
	}
	method siguientePosicion(){
		return if(sentido == "l") rana.position().left(1) else rana.position().right(1)
	}
	
	method posicionesExtra(){
		return [self.position(), self.position().right(1), self.position().right(2)]
	}
	
	override method limite(){return [-3,22]}
}
// CONSTRUCTOR DE LOS SOPORTES
object soportes inherits Conjunto{
	const velocidad = [600,400,300,650]
	
	var property subc1 = self.listaSoportes(3, velocidad.get(0), "assets/tronco.png", 7, 8, "r")

	var property subc2 = self.listaSoportes(3, velocidad.get(1), "assets/tronco.png", 7, 9, "l")

	var property subc3 = self.listaSoportes(3, velocidad.get(2), "assets/tronco.png", 7, 10, "r")
						 
	var property subc4 = self.listaSoportes(3, velocidad.get(1), "assets/tronco.png", 7, 11, "l")
						 
	var property subc5 = self.listaSoportes(3, velocidad.get(3), "assets/tronco.png", 7, 12, "r")
	
	// DEVUELVE TODOS LOS SUBCONJUNTOS
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	// CREA UNA LISTA DE CIERTA CANTIDAD DE SOPORTES, VARIANDO LA POSICION DE CADA UNO DE ACUERDO A LA DISTANCIA (RELATIVA A LAS FILAS) ENTRE ELLOS
	method listaSoportes(cantidad, _velocidad, imagen, distanciaEntreSoportes, columna, _sentido){
		const rango = new Range(start = 1, end = cantidad)
		const lista = []
		var fila = 0
		
		rango.forEach({e => lista.add(new Soporte(velocidad = _velocidad, image = imagen, sentido = _sentido, posicionInicial = game.at(fila,columna))) fila += distanciaEntreSoportes})
		return lista
	}
}