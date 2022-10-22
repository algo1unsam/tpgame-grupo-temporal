import wollok.game.*
import interfaz.*
import personajes.*

class Soporte inherits ObjetoMovil{
	var property id = true 
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

object soportes inherits Conjunto{
	const velocidad1 = 600
	const velocidad2 = 400
	const velocidad3 = 300
	const velocidad4 = 400
	
	var property subc1 = [new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(0,8)),
						 new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(7,8)),
						 new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(14,8))]
						 
	var property subc2 = [new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,9)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,9)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,9))]
						 
	var property subc3 = [new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,10)),
						 new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,10)),
						 new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,10))]
						 
	var property subc4 = [new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,11)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,11)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,11))]
						 
	var property subc5 = [new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,12)),
						 new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,12)),
						 new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,12))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
}