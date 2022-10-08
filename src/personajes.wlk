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

class ObjetoInvisible{
	var property position = null
	method devolver(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().up(1))
		}	
	}
}
