import wollok.game.*
import personajes.*

object interfaz {
	var property image = ""
	var property position = game.origin()
	
	method pantallaCarga(){
		self.image("assets/pantallaCarga.png")
		game.addVisualIn(self, game.origin())
		keyboard.enter().onPressDo({self.comenzar()})
	}
	
	method comenzar(){
		self.image("assets/fondo.png")
		game.addVisualCharacter(rana)
	}
	
}
