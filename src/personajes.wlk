import wollok.game.*
import interfaz.*

object rana {
	var property position = game.at(9,1)
	var property image = "assets/ranita.png"
	var cantVidas = 3
	var property sobreSoporte = false
	
	method perderVida(){
		cantVidas -= 1
		const indice = vidas.conjunto().size() - 1 
		game.removeVisual(vidas.conjunto().get(indice))
		vidas.conjunto().remove(vidas.conjunto().get(indice))
		self.position(game.at(9,1))
		
		if(cantVidas == 0){
			interfaz.pantallaCarga()
			cantVidas = 3
		}
	}
}

class ObjetoMovil{
	var property image = ""
	var property posicionInicial = null
	var property position = posicionInicial
	var property velocidad = 0
	var property sentido = ""
	
	method moverse(){
		if(sentido == "r"){
			if (self.position().x() == 19){
				self.position(game.at(0, self.posicionInicial().y()))
			}else{
				self.position(self.position().right(1))
			}
		}
		else if (sentido == "l"){
			if (self.position().x() == 0){
				self.position(game.at(19, self.posicionInicial().y()))
			}else{
				self.position(self.position().left(1))
			}
		}
		
	}
}

class Vehiculo inherits ObjetoMovil{
	method atropellar(ranita){
		ranita.perderVida()
	}
}

class Conjunto{
	method todos(){return null}
	
	method setear(){
		self.todos().forEach({objeto => game.addVisual(objeto)})
		self.todos().forEach({objeto => game.onTick(objeto.velocidad(),"movimiento",{objeto.moverse()})})
	}
}

object autos inherits Conjunto{

	var property subc1 = [new Vehiculo(velocidad = 600, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(0,2)),
				new Vehiculo(velocidad = 600, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(5,2)),
				new Vehiculo(velocidad = 600, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(10,2)),
				new Vehiculo(velocidad = 600, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(15,2))]
	
	var property subc2 = [new Vehiculo(velocidad = 550, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(-1,3)),
				new Vehiculo(velocidad = 550, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(6,3)),
				new Vehiculo(velocidad = 550, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(13,3))]

	var property subc3 = [new Vehiculo(velocidad = 350, image = "assets/auto4.png", sentido = "l",  posicionInicial = game.at(9,4)),
				new Vehiculo(velocidad = 350, image = "assets/auto4.png", sentido = "l",  posicionInicial = game.at(19,4))]

	var property subc4 =	[new Vehiculo(velocidad = 600, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(0,5)),
				new Vehiculo(velocidad = 600, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(4,5)),
				new Vehiculo(velocidad = 600, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(8,5)),
				new Vehiculo(velocidad = 600, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(12,5)),
				new Vehiculo(velocidad = 600, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(16,5))]
	
	var property subc5 = [new Vehiculo(velocidad = 300, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(5,6)),
				new Vehiculo(velocidad = 300, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(10,6)),
		  		new Vehiculo(velocidad = 300, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(15,6)),
				new Vehiculo(velocidad = 300, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(20,6))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	override method setear(){
		super()
		self.todos().forEach({objeto => game.onCollideDo(objeto,{ranita => objeto.atropellar(ranita)})})
	}
}

class Soporte inherits ObjetoMovil{
	
	override method moverse(){
		if(rana.sobreSoporte()){
			if(self.posicionesExtra().contains(rana.position()){
				if(rana.position().x() == 0 or rana.position().x() == 19){
					rio.ahogar(rana)
				}else{
					rana.position(self.siguientePosicion())
				}
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
}

object soportes inherits Conjunto{
	var property subc1 = [new Soporte(velocidad = 600, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(0,8)),
						 new Soporte(velocidad = 600, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(7,8)),
						 new Soporte(velocidad = 600, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(14,8))]
						 
	var property subc2 = [new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,9)),
						 new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,9)),
						 new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,9))]
						 
	var property subc3 = [new Soporte(velocidad = 300, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,10)),
						 new Soporte(velocidad = 300, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,10)),
						 new Soporte(velocidad = 300, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,10))]
						 
	var property subc4 = [new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,11)),
						 new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,11)),
						 new Soporte(velocidad = 400, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,11))]
						 
	var property subc5 = [new Soporte(velocidad = 200, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,12)),
						 new Soporte(velocidad = 200, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,12)),
						 new Soporte(velocidad = 200, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,12))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	override method setear(){
		super()
		self.todos().forEach({objeto => game.onCollideDo(objeto,{ranita => rana.sobreSoporte(true)})})
	}
}

class Vida{
	var property position = null
	var property image = "assets/vida.png"
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

class ObjetoInvisible{
	var property position = null
	method devolver(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().up(1))
		}	
	}
}
