import wollok.game.*
import personajes.*

object interfaz {
	var property image = ""
	var property position = game.origin()
	
	method inicializar(){
		const autito = new Vehiculo(velocidad = 500, image = "assets/autito.png", position = game.at(19,3))
		
		game.addVisualCharacter(rana)
		game.addVisual(autito)
		
		game.onTick(autito.velocidad(),"movimiento",{autito.moverse("l")})
		game.onCollideDo(autito,{ranita => autito.atropellar(ranita)})
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
