import wollok.game.*
import autos.*
import interfaz.*
import soportes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*
import sonidos.*
import movimiento.*

// RANA PAUSADA
object ranaPausada{
	var property position
	var property image
}
// RANA DEL JUEGO
object rana {
	var property id = true 
	var property position = game.at(9,1)
	var property image = "assets/sprites/ranitaTry.png"
	var property cantVidas = 3
	// MOVIMIENTO, ANIMACION DEL RANA Y CHEQUEO DE COLISIONES
	method setearListeners(){
		keyboard.up().onPressDo({
			self.sonidoSaltar()
			self.image("assets/sprites/ranitaSalto.png")
			game.schedule(300, {self.image("assets/sprites/ranitaTry.png")})
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.down().onPressDo({
			self.sonidoSaltar()
			self.image("assets/sprites/ranitaSaltoA.png")
			game.schedule(300, {self.image("assets/sprites/ranitaTryA.png")})
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.right().onPressDo({
			self.sonidoSaltar()
			self.image("assets/sprites/ranitaSaltoD.png")
			game.schedule(300, {self.image("assets/sprites/ranitaTryD.png")})
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
		keyboard.left().onPressDo({
			self.sonidoSaltar()
			self.image("assets/sprites/ranitaSaltoI.png")
			game.schedule(300, {self.image("assets/sprites/ranitaTryI.png")})
			if(self.existeRanita()){				
				self.chequearColision()
			}
		})
	}
	// DEVUELVE SI LA RANA EXISTE EN EL JUEGO
	method existeRanita(){
		return game.allVisuals().contains(self)
	}
	// SI LA RANA ESTA EN EL RIO Y NO TIENE SOPORTE PIERDE UNA VIDA
	method chequearColision(){
		if(self.ranaRio() && !self.tieneSoporte()){
			soundProducer.sound("assets/sonidoAhogar.wav").play()
			self.perderVida()
		}
	}
	// DEVUELVE SI LA RANA ESTA EN EL RIO 
	method ranaRio(){
		return self.position().y() >= 8 && self.position().y() <= 12 
	}
	
	// PIERDE UNA VIDA , SI LLEGA A 0 CAMBIA A LA PANTALLA DE DERROTA
	method perderVida(){
		cantVidas -= 1
		self.quitarVisualVida()
		self.setear()
		self.reiniciarPosicionMosca()

		if(cantVidas == 0){
			interfaz.derrota()
			cantVidas = 3
		}
	}
	// SACA UNA VIDA DE LA INTERFAZ
	method quitarVisualVida(){
		const ultima = vidas.conjunto().last()
		game.removeVisual(ultima)
		vidas.conjunto().remove(ultima)
	}
	// AUXILIAR PARA LA MOSCA
	method reiniciarPosicionMosca(){
		mosca.borrar()
		mosca.setear()
	}
	// COMPRUBEA SI LA RANA ESTA EN ALGUN SOPORTE
	method tieneSoporte(){
		return soportes.todos().any({soporte => soporte.posicionesExtra().contains(self.position())})
	}
	// ACTIVA EL MODO PAUSA
	method modoPausa(){
		const prePos = self.position()
		ranaPausada.position(prePos)
		ranaPausada.image(self.image())
		game.removeVisual(self)
		game.addVisual(ranaPausada)
	}
	// SACA LA PAUSA
	method quitarPausa(){
		game.removeVisual(ranaPausada)
		self.position(ranaPausada.position())
		game.addVisual(self)
	}
	// UBICA LA RANA EN LA POSICION INICIAL DEL JUEGO
	method setear(){
		self.position(game.at(9,1))
	}
	// SONIDO DEL SALTO DE LA RANA
	method sonidoSaltar(){
		soundProducer.sound("assets/hop.wav").play()
	}
	
}
// CLASE PARA LAS VIDAS
class Vida{
	var property position = null
	var property image = "assets/vida.png"
}
// CONSTRUCTOR DE LAS VIDAS
object vidas{
	var property conjunto = []
	// INICIALIZA LAS VIDAS
	method setear(){
		conjunto = [new Vida(position = game.at(0,0)),
					new Vida(position = game.at(1,0)),
					new Vida(position = game.at(2,0))]
					
		conjunto.forEach({vida => game.addVisual(vida)})
		rana.cantVidas(3)
	}
}
// MOSCA DEL JUEGO
object mosca{
	const lista = [1,3,5,7,9,11,13,15,17,19]
	var property image = "assets/mosca.png"
	var property position
	// INICIALIZA LA MOSCA EN UNA POSICION ALEATORIA
	method setear(){
		self.position(game.at(self.crearX(), 13))
		game.addVisual(self)
		game.whenCollideDo(self, {ranita => score.subirPuntos()})
	}
	// DEVUELVE UN VALOR ALEATORIO LA LISTA
	method crearX(){
		return lista.anyOne()
	}
	// BORRA LA MOSCA
	method borrar(){
		game.removeVisual(self)
	}
}

