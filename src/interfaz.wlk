import wollok.game.*
import personajes.*

object interfaz {
	var property image = ""
	var property position = game.origin()
	
	method inicializar(){
		const autos = misAutos.todos()
		
		autos.forEach({autito => game.addVisual(autito)})
		game.addVisualCharacter(rana)
		
		misAutos.movIzquierda().forEach({ autito => game.onTick(autito.velocidad(),"movimiento",{autito.moverse("l")})})
		misAutos.movDerecha().forEach({ autito => game.onTick(autito.velocidad(),"movimiento",{autito.moverse("r")})})
		autos.forEach({autito => game.onCollideDo(autito,{ranita => autito.atropellar(ranita)})})
	}
	
	method pantallaCarga(){
		self.image("assets/pantallaCarga.png")
		game.addVisualIn(self, game.origin())
		keyboard.enter().onPressDo({self.comenzar()})
	}
	
	method comenzar(){
		self.image("assets/fondo.png")
		self.inicializar()
	}
	
}

object misAutos{

	var property subconjunto1 = [new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(0,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(5,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(10,2)),
							  new Vehiculo(velocidad = 600, image = "assets/auto3.png", posicionInicial = game.at(15,2))]
							  
	var property subconjunto2 = [new Vehiculo(velocidad = 450, image = "assets/auto2.png", posicionInicial = game.at(-1,3)),
							  new Vehiculo(velocidad = 450, image = "assets/auto2.png", posicionInicial = game.at(6,3)),
							  new Vehiculo(velocidad = 450, image = "assets/auto2.png", posicionInicial = game.at(13,3))]
							  
	var property subconjunto3 = [new Vehiculo(velocidad = 250, image = "assets/auto4.png", posicionInicial = game.at(9,4)),
							  new Vehiculo(velocidad = 250, image = "assets/auto4.png", posicionInicial = game.at(19,4))]
							  
	var property subconjunto4 =  [new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(0,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(4,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(8,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(12,5)),
							  new Vehiculo(velocidad = 600, image = "assets/auto1.png", posicionInicial = game.at(16,5))]
	
	var property subconjunto5 = [new Vehiculo(velocidad = 200, image = "assets/auto5.png", posicionInicial = game.at(5,6)),
							  new Vehiculo(velocidad = 200, image = "assets/auto5.png", posicionInicial = game.at(10,6)),
							  new Vehiculo(velocidad = 200, image = "assets/auto5.png", posicionInicial = game.at(15,6)),
							  new Vehiculo(velocidad = 200, image = "assets/auto5.png", posicionInicial = game.at(20,6))]
	
	method todos(){
		return self.movIzquierda() + self.movDerecha()
	}
	
	method movIzquierda(){
		return subconjunto1 + subconjunto3 + subconjunto5
	}
	
	method movDerecha(){
		return subconjunto2 + subconjunto4
	}
}