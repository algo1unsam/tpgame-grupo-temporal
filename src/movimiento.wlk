import wollok.game.*
import personajes.*
import autos.*
import soportes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*
import sonidos.*


object derecha{
	method moverse(personaje){
		if (self.estaEnLimite(personaje)){
			self.volverAPosicionInicial(personaje)
		}else{
			personaje.position(personaje.position().right(1))
		}
	}
	
	method volverAPosicionInicial(personaje){
		personaje.position(game.at(personaje.x(), personaje.posicionInicial().y()))
	}
	
	method estaEnLimite(personaje){
		return personaje.position().x() == personaje.y()
	}
	
	method troncoMueveRanaA(tronco){
		return rana.position().right(1)
	}
}

object izquierda{
	method moverse(personaje){
		if (self.estaEnLimite(personaje)){
			self.volverAPosicionInicial(personaje)
		}else{
			personaje.position(personaje.position().left(1))
		}
	}
	
	method volverAPosicionInicial(personaje){
		personaje.position(game.at(personaje.y(), personaje.posicionInicial().y()))
	}
	
	method estaEnLimite(personaje){
		return personaje.position().x() == personaje.x()
	}
	
	method troncoMueveRanaA(tronco){
		return rana.position().left(1)
	}
}