import wollok.game.*

object rana {
	var property position = game.at(9,1)
	var property image = "assets/ranota2.png"
	var property vidas = 3
}
class ObjetoMovil{
	var property image = ""
	var property position = null
	var property velocidad = 0	
}

class Vehiculo inherits ObjetoMovil{
	method atropellar(ranita){
		ranita.vidas(ranita.vidas()-1)
		ranita.position(game.at(9,1))
	}
	
	method moverse(sentido){
		if(sentido == "r"){
			self.position(self.position().right(1))
		}
		else{
			self.position(self.position().left(1))
		}
		
		
	}
}
