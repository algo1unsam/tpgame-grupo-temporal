import wollok.game.*
import interfaz.*
import personajes.*
import filasExteriores.*
import autos.*
import rio.*
import personajesAuxiliares.*
import movimiento.*
// CLASE DE LOS SOPORTES, ES UNA SUBCLASE DE OBJETO MOVIL
class Soporte inherits ObjetoMovil{
	var property id = true 
	// METODO DEL MOVIMIENTO, SI LA RANA ESTA EN EL SOPORTE PUEDE MOVERSE POR ESTE
	override method moverse(){
		if(self.troncoContieneARana()){
			if(self.ranaSeFueDelMapa()){
				rana.perderVida()
			}else{
				self.troncoMueveRana()
			}
		}	
		super()
	}
	
	method ranaSeFueDelMapa(){
		return rana.position().x() == -1 or rana.position().x() == 20
	}
	
	method troncoContieneARana(){
		return self.posicionesExtra().contains(rana.position())
	}
	
	method troncoMueveRana(){
		rana.position(self.siguientePosicion())
	}
	
	method siguientePosicion(){
		return movimiento.troncoMueveRanaA(self)
	}
	
	method posicionesExtra(){
		return [self.position(), self.position().right(1), self.position().right(2)]
	}
	
	override method limite(){return [-3,22]}
}
// CONSTRUCTOR DE LOS SOPORTES
object soportes inherits Conjunto{
	const velocidad = [600,400,300,650]
	
	var property subc1 = self.listaSoportes(velocidad.get(0), 8, derecha)

	var property subc2 = self.listaSoportes(velocidad.get(1), 9, izquierda)

	var property subc3 = self.listaSoportes(velocidad.get(2), 10, derecha)
						 
	var property subc4 = self.listaSoportes(velocidad.get(1), 11, izquierda)
						 
	var property subc5 = self.listaSoportes(velocidad.get(3), 12, derecha)
	
	// DEVUELVE TODOS LOS SUBCONJUNTOS
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	// CREA UNA LISTA DE CIERTA CANTIDAD DE SOPORTES, VARIANDO LA POSICION DE CADA UNO DE ACUERDO A LA DISTANCIA (RELATIVA A LAS FILAS) ENTRE ELLOS
	method listaSoportes(_velocidad, columna, sentido){
		const rango = new Range(start = 1, end = 3)
		const lista = []
		const distanciaEntreSoportes = 7
		var fila = 0
		
		rango.forEach({e => lista.add(new Soporte(velocidad = _velocidad, image = "assets/tronco.png", movimiento = sentido, posicionInicial = game.at(fila,columna))) fila += distanciaEntreSoportes})
		return lista
	}
}