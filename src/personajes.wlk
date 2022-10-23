import wollok.game.*
import autos.*
import interfaz.*
import soportes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*

// representa a la ranita pausada
object ranaPausada{
	var property position
	var property image = "assets/ranitaTry.png"
}

// representa a la rana con la que jugamos
object rana {
	var property id = true 
	var property position = game.at(9,1)
	var property image = "assets/ranitaTry.png"
	var property cantVidas = 3
	
	method setearListeners(){
		keyboard.up().onPressDo({
			self.sonidoSaltar()
			self.image("assets/ranitaSalto.png")
			game.schedule(300, {self.image("assets/ranitaTry.png")})
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.down().onPressDo({
			self.sonidoSaltar()
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.right().onPressDo({
			self.sonidoSaltar()
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.left().onPressDo({
			self.sonidoSaltar()
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
			game.sound("assets/sonidoAhogar.wav").play()
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
		
		mosca.borrar()
		mosca.setear()
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
	
	method sonidoSaltar(){
		game.sound("assets/hop.wav").play()
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
	
	method borrar(){
		game.removeVisual(self)
	}
}

