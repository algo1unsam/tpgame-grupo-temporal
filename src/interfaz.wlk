import wollok.game.*
import personajes.*

object interfaz {
	var property image = ""
	var property position = game.origin()
	
	method inicializar(){
		game.addVisualCharacter(rana)		
		[vidas,filaInferior,autos,rio].forEach({obj => obj.setear()})
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

object autos{

	var property subconjunto1 = [new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(0,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(5,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(10,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(15,2))]
							  
	var property subconjunto2 = [new Vehiculo(velocidad = 550, image = "assets/auto2.png", posicionInicial = game.at(-1,3)),
							  new Vehiculo(velocidad = 550, image = "assets/auto2.png", posicionInicial = game.at(6,3)),
							  new Vehiculo(velocidad = 550, image = "assets/auto2.png", posicionInicial = game.at(13,3))]
							  
	var property subconjunto3 = [new Vehiculo(velocidad = 350, image = "assets/auto4.png", posicionInicial = game.at(9,4)),
							  new Vehiculo(velocidad = 350, image = "assets/auto4.png", posicionInicial = game.at(19,4))]
							  
	var property subconjunto4 =  [new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(0,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(4,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(8,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(12,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(16,5))]
	
	var property subconjunto5 = [new Vehiculo(velocidad = 300, image = "assets/auto5.png", posicionInicial = game.at(5,6)),
							  new Vehiculo(velocidad = 300, image = "assets/auto5.png", posicionInicial = game.at(10,6)),
							  new Vehiculo(velocidad = 300, image = "assets/auto5.png", posicionInicial = game.at(15,6)),
							  new Vehiculo(velocidad = 300, image = "assets/auto5.png", posicionInicial = game.at(20,6))]
	
	method todos(){
		return self.movIzquierda() + self.movDerecha()
	}
	
	method movIzquierda(){
		return subconjunto1 + subconjunto3 + subconjunto5
	}
	
	method movDerecha(){
		return subconjunto2 + subconjunto4
	}
	
	method setear(){
		self.todos().forEach({autito => game.addVisual(autito)})
		self.movIzquierda().forEach({ autito => game.onTick(autito.velocidad(),"movimiento",{autito.moverse("l")})})
		self.movDerecha().forEach({ autito => game.onTick(autito.velocidad(),"movimiento",{autito.moverse("r")})})
		self.todos().forEach({autito => game.onCollideDo(autito,{ranita => autito.atropellar(ranita)})})
	}
}

object vidas{
	var property conjunto = []
	
	method setear(){
		conjunto = [new Vida(position = game.at(0,0)),
					new Vida(position = game.at(1,0)),
					new Vida(position = game.at(2,0))]
					
		conjunto.forEach({vida => game.addVisual(vida)})
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
		filas.forEach({fila => columnas.forEach({columna => conjunto.add(game.at(columna,fila))})})
		conjunto.forEach({celda => game.onTick(250,"rio mata ranita",{if(rana.position() == celda and celda.allElements().size() == 1){self.ahogar(rana)}})})
	}
	
	method ahogar(ranita){
		ranita.perderVida()
	}
}

