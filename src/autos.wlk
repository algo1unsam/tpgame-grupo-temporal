import wollok.game.*
import interfaz.*
import personajes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*

class Vehiculo inherits ObjetoMovil{
	var property id = false
	method atropellar(ranita){
		game.sound("assets/sonidoAtropellar.wav").play()
		ranita.perderVida()
	}
	
	override method limite(){return [0,19]}
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
	
	var property subc5 = [new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(5,6)),
				new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(10,6)),
		  		new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(15,6)),
				new Vehiculo(velocidad = velocidad4, image = "assets/auto5.png", sentido = "l", posicionInicial = game.at(20,6))]
	
	override method todos(){
		return self.subc1() + self.subc2() + self.subc3() + self.subc4() + self.subc5()
	}
	
	override method detenerse(){
		self.todos().forEach({objeto => game.removeTickEvent("movimiento")})
	}
	
	override method setear(){
		super()
		self.todos().forEach({objeto => game.onCollideDo(objeto,{ranita => objeto.atropellar(ranita)})})
	}
}
