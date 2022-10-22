import wollok.game.*
import autos.*
import interfaz.*
import soportes.*

object ranaPausada{
	var property position
	var property image = "assets/ranita.png"
}

object rana {
	var property id = true 
	var property position = game.at(9,1)
	var property image = "assets/ranita.png"
	var property cantVidas = 3
	
	method setearListeners(){
		keyboard.up().onPressDo({
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.down().onPressDo({
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.right().onPressDo({
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.left().onPressDo({
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
	}
	
	method existeRanita(){
		return game.allVisuals().contains(self)
	}
	
	method chequearColision(){
		if(self.ranaRio() && !self.tieneSoporte()){
			self.perderVida()
		}
	}
	
	method ranaRio(){
		return self.position().y() >= 8 && self.position().y() <= 12 
	}
	
	
	method perderVida(){
		cantVidas -= 1
		const ultima = vidas.conjunto().last()
		game.removeVisual(ultima)
		vidas.conjunto().remove(ultima)
		self.position(game.at(9,1))
		
		if(cantVidas == 0){
			interfaz.derrota()
			cantVidas = 3
		}
	}
	
	method tieneSoporte(){
		return soportes.todos().any({soporte => soporte.posicionesExtra().contains(self.position())})
	}
	
	method modoPausa(){
		const prePos = self.position()
		ranaPausada.position(prePos)
		game.removeVisual(self)
		game.addVisual(ranaPausada)
	}
	
	method quitarPausa(){
		game.removeVisual(ranaPausada)
		self.position(ranaPausada.position())
		game.addVisual(self)
	}
	
	method setear(){
		self.position(game.at(9,1))
	}
	
}

class ObjetoMovil{
	var property image = ""
	var property posicionInicial = null
	var property position = posicionInicial
	var property velocidad = 0
	var property sentido = ""
	var property x = self.limite().get(0)
	var property y = self.limite().get(1)
	
	method moverse(){
		
		if(sentido == "r"){
			if (self.position().x() == self.y()){
				self.position(game.at(self.x(), self.posicionInicial().y()))
			}else{
				self.position(self.position().right(1))
			}
		}
		else if (sentido == "l"){
			if (self.position().x() == self.x()){
				self.position(game.at(self.y(), self.posicionInicial().y()))
			}else{
				self.position(self.position().left(1))
			}
		}
		
	}
	
	method limite(){return null}
}



class Conjunto{
	method todos(){return null}
	
	method setear(){
		self.todos().forEach({objeto => game.addVisual(objeto)})
		self.moverse()
	}
	
	method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	
	method moverse(){
		self.todos().forEach({objeto => game.onTick(objeto.velocidad(),"movimiento",{objeto.moverse()})})
	}
	
	method aumentarVelocidades(){
		self.todos().forEach({obj => obj.velocidad(obj.velocidad().div(1.1))})
		self.detenerse()
		self.moverse()
	}
	
	method eliminarObjetos(){
		self.todos().forEach({obj => game.removeVisual(obj)})
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
		rana.cantVidas(3)
	}
}

class ObjetoInvisible{
	var property position = null
	method devolverArriba(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().up(1))
		}	
	}
	
	method devolverAbajo(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().down(1))
		}	
	}
}

object mosca{
	const lista = [1,3,5,7,9,11,13,15,17,19]
	var property image = "assets/mosca.png"
	var property position
	method setear(){
		self.position(game.at(self.crearX(), 13))
		game.addVisual(self)
		game.whenCollideDo(self, {ranita => score.subirPuntos()})
	}
	
	method crearX(){
		return lista.anyOne()
	}
}