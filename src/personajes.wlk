import wollok.game.*
import interfaz.*

object ranaPausada{
	var property position
	var property image = "assets/ranita.png"
}

object rana {
	var property id = true 
	var property position = game.at(9,1)
	var property image = "assets/ranita.png"
	var cantVidas = 3
	
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

	
	method moverse(x,y){
		if(sentido == "r"){
			if (self.position().x() == y){
				self.position(game.at(x, self.posicionInicial().y()))
			}else{
				self.position(self.position().right(1))
			}
		}
		else if (sentido == "l"){
			if (self.position().x() == x){
				self.position(game.at(y, self.posicionInicial().y()))
			}else{
				self.position(self.position().left(1))
			}
		}
		
	}
}

class Vehiculo inherits ObjetoMovil{
	var property id = false
	method atropellar(ranita){
		ranita.perderVida()
	}
}

class Conjunto{
	method todos(){return null}
	
	method setear(x,y){
		self.todos().forEach({objeto => game.addVisual(objeto)})
		self.moverse(x,y)
	}
	
	method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	
	method moverse(x,y){
		self.todos().forEach({objeto => game.onTick(objeto.velocidad(),"movimiento",{objeto.moverse(x,y)})})
	}
}

object autos inherits Conjunto{
	const velocidad1 = 600
	const velocidad2 = 550
	const velocidad3 = 350
	const velocidad4 = 300

	var property subc1 = [new Vehiculo(velocidad = velocidad1, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(0,2)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(5,2)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(10,2)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto3.png", sentido = "l", posicionInicial = game.at(15,2))]
	
	var property subc2 = [new Vehiculo(velocidad = velocidad2, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(-1,3)),
				new Vehiculo(velocidad = velocidad2, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(6,3)),
				new Vehiculo(velocidad = velocidad2, image = "assets/auto2.png", sentido = "r", posicionInicial = game.at(13,3))]

	var property subc3 = [new Vehiculo(velocidad = velocidad3, image = "assets/auto4.png", sentido = "l",  posicionInicial = game.at(9,4)),
				new Vehiculo(velocidad = velocidad3, image = "assets/auto4.png", sentido = "l",  posicionInicial = game.at(19,4))]

	var property subc4 =	[new Vehiculo(velocidad = velocidad1, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(0,5)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(4,5)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(8,5)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(12,5)),
				new Vehiculo(velocidad = velocidad1, image = "assets/auto1.png", sentido = "r", posicionInicial = game.at(16,5))]
	
	var property subc5 = [new Vehiculo(velocidad = velocidad3, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(5,6)),
				new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(10,6)),
		  		new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(15,6)),
				new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(20,6))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	override method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	
	override method setear(x,y){
		super(x,y)
		self.todos().forEach({objeto => game.onCollideDo(objeto,{ranita => objeto.atropellar(ranita)})})
	}
}

class Soporte inherits ObjetoMovil{
	var property id = true 
	override method moverse(x,y){
		if(self.posicionesExtra().contains(rana.position())){
			if(rana.position().x() == -1 or rana.position().x() == 20){
				rana.perderVida()
			}else{
				rana.position(self.siguientePosicion())
			}
		}	
		super(x,y)
	}
	
	method siguientePosicion(){
		return if(sentido == "l") rana.position().left(1) else rana.position().right(1)
	}
	
	method posicionesExtra(){
		return [self.position(), self.position().right(1), self.position().right(2)]
	}
}

object soportes inherits Conjunto{
	const velocidad1 = 600
	const velocidad2 = 400
	const velocidad3 = 300
	const velocidad4 = 200
	
	var property subc1 = [new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(0,8)),
						 new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(7,8)),
						 new Soporte(velocidad = velocidad1, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(14,8))]
						 
	var property subc2 = [new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,9)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,9)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,9))]
						 
	var property subc3 = [new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,10)),
						 new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,10)),
						 new Soporte(velocidad = velocidad3, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,10))]
						 
	var property subc4 = [new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(4,11)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(11,11)),
						 new Soporte(velocidad = velocidad2, image = "assets/tronco.png", sentido = "r", posicionInicial = game.at(18,11))]
						 
	var property subc5 = [new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(4,12)),
						 new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(11,12)),
						 new Soporte(velocidad = velocidad4, image = "assets/tronco.png", sentido = "l", posicionInicial = game.at(18,12))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
//	method recorrerSubc1(){
//		subc1.forEach({sup => sup.id()})
//	}
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

object mosca{
	const lista = [1,3,5,7,9,11,13,15,17,19]
	var property image = "assets/mosca.png"
	var property position
	method setear(){
		self.position(game.at(self.crearX(), 13))
		game.addVisual(self)
		game.whenCollideDo(self, {juego => interfaz.victoria()})
	}
	
	method crearX(){
		return lista.anyOne()
	}
}
