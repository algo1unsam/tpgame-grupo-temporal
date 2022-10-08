import wollok.game.*
import interfaz.*

object rana {
	var property position = game.at(9,1)
	var property image = "assets/ranita.png"
	var cantVidas = 3
	
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
	
	method moverse(sentido){
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

class Soporte inherits ObjetoMovil{
	method sostener(ranita){
	}
	
	method siguientePosicion(sentido){
		return if(sentido == "l") game.at(self.position().x()-1, self.position().y()) else game.at(self.position().x()+1, self.position().y())
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
