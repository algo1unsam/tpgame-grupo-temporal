import wollok.game.*
import interfaz.*
import personajes.*
import autos.*
import soportes.*
import rio.*
import movimiento.*
// CLASE RESTRINGIDO
class Restringido{
	const columnas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var property conjunto = []
	method setear(){conjunto.clear()}
}
//CLASE PARA LOS OBJETOS QUE SE MUEVEN 
class ObjetoMovil{
	var property image = ""
	var property posicionInicial = null
	var property position = posicionInicial
	var property velocidad = 0
	var property movimiento
	var property limiteIzquierda = self.limite().get(0)
	var property limiteDerecha = self.limite().get(1)
	
	// METODO PARA EL MOVIMIENTO 
	method moverse(){
		movimiento.moverse(self)
	}
	// LIMITE DE MOVIMIENTO DE LOS OBJETOS 
	method limite(){return null}
}
// CLASE PARA LOS OBJETOS INVISIBLES 
class ObjetoInvisible{
	var property position = null
	// DEVUELVE A LA RANA PARA ARRIBA SI COLISIONA 
	method devolverArriba(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().up(1))
		}	
	}
	// DEVUELVE A LA RANA PARA ABAJO SI COLISIONA 
	method devolverAbajo(ranita){
		if(ranita.equals(rana)){
			ranita.position(ranita.position().down(1))
		}	
	}
}
// CLASE PARA LOS CONJUNTOS DE OBJETOS
class Conjunto{
	method todos(){return null}
	// INICIA TODOS LOS OBJETOS
	method setear(){
		self.todos().forEach({objeto => game.addVisual(objeto)})
		self.moverse()
	}
	// DETIENE TODOS LOS OBJETOS
	method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	// MUEVE TODOS LOS OBJETOS
	method moverse(){
		self.todos().forEach({objeto => game.onTick(objeto.velocidad(),"movimiento",{objeto.moverse()})})
	}
	// AUMENTA LAS VELOCIDADES DE TODOS LOS OBJETOS
	method aumentarVelocidades(){
		self.todos().forEach({obj => obj.velocidad(obj.velocidad().div(1.1))})
		self.detenerse()
		self.moverse()
	}
	// ELIMINA TODOS LOS OBJETOS
	method eliminarObjetos(){
		self.todos().forEach({obj => game.removeVisual(obj)})
	}
}
