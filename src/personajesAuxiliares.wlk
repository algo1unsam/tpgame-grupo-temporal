import wollok.game.*
import interfaz.*
import personajes.*
import autos.*
import soportes.*
import rio.*

class Restringido{
	const columnas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var property conjunto = []
	method setear(){conjunto.clear()}
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
