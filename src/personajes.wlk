import wollok.game.*

object rana {
	var property position = game.at(9,1)
	var property image = "assets/ranita.png"
	var property vidas = 3
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
		ranita.vidas(ranita.vidas()-1)
		ranita.position(game.at(9,1))
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
	var property image = "assets/vida.png"
	var property position = null
}

class ObjetoInvisible{
	var property position = null
	
	method devolver(ranita){
		if(ranita == rana){
			ranita.position(ranita.position().up(1))
		}
	}
}
