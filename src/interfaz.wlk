import wollok.game.*
import personajes.*

object interfaz {
	var property image = ""
	var property position = game.origin()
	
	method inicializar(){
		[vidas,filaInferior,soportes,rio].forEach({obj => obj.setear()})
		game.addVisualCharacter(rana)
		autos.setear()
	}
	
	method pantallaCarga(){
		game.clear()
		
		self.image("assets/pantallaCarga.png")
		game.addVisualIn(self, game.origin())
		keyboard.enter().onPressDo({self.comenzar()})
	}
	
	method comenzar(){
		self.image("assets/bg.png")
		self.inicializar()
	}
	
}

class Restringido{
	const columnas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var property conjunto = []
	method setear(){conjunto.clear()}
}

object filaInferior inherits Restringido{
	override method setear(){
		super()
		columnas.forEach({num => conjunto.add(new ObjetoInvisible(position = game.at(num,0)))})
		conjunto.forEach({celda => game.addVisual(celda)})
		conjunto.forEach({celda => game.onCollideDo(celda,{ ranita => celda.devolver(ranita)})})		
	}
}

object rio inherits Restringido{
	const filas = [8,9,10,11,12]
	override method setear(){
		super()
		var bandera = false
		filas.forEach({fila => columnas.forEach({columna => conjunto.add(game.at(columna,fila))})})
		conjunto.forEach({celda => game.onTick(250,"rio mata ranita",{if(rana.position() == celda and celda.allElements().size() == 1){self.ahogar(rana)}})})
	}
	
	method ahogar(ranita){
		if(not rana.sobreSoporte()){
			ranita.perderVida()				
		}
	}
}

