import wollok.game.*
import personajes.*

object startBtn{
	var property position = game.at(7, 3)
	var property image = "assets/playBtn.png"
	
	method presionar(){
		game.clear()
		self.cambiarFondo()
		[vidas,filaInferior,rio,mosca,score,rana].forEach({obj => obj.setear()})
		soportes.setear(-3,22)
		autos.setear(0,19)
		game.addVisualCharacter(rana)
		rana.setearListeners()
		keyboard.p().onPressDo({
			if(game.getObjectsIn(game.at(6,8)).contains(cartelPausa)){
				interfaz.quitarPausa()	
			}else{
				interfaz.hacerPausa()
			}
		})
	}
	
	
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/bgTestV4def.png")
	}
	
}

object instrBtn{
	var property position = game.at(7, 1)
	var property image = "assets/instrBtn.png"
	
	method presionar(){
		game.clear()
		self.cambiarFondo()
		keyboard.v().onPressDo({interfaz.pantallaCarga()})
	}
	
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/instrucciones.png")
	}
}

object flecha{
	var property position = game.at(6,3)
	var property image = "assets/flecha.png"
	
	method seleccionar(){
		const selecPos = game.at(self.position().x()+1, self.position().y())
		const seleccion = game.getObjectsIn(selecPos)
		
		seleccion.first().presionar()
	}
}

object cartelPausa{
	var property position = game.at(6, 8)
	var property image = "assets/cartelPausa.png"
	
	method pausar(){
		rana.modoPausa()
		soportes.detenerse()
		autos.detenerse()
	}
	
	method reanudar(){
		rana.quitarPausa()
		soportes.moverse(-3,22)
		autos.moverse(0,19)
	}
}


object interfaz {
	var property image = ""
	var property position = game.origin()
	var property botones = [startBtn, instrBtn, flecha]
	
	method pantallaCarga(){
		game.clear()
		console.println(self.image())
		self.cambiarPantalla("assets/pantallaCarga.png")
		
		self.hacerBotones()
	}
	
	method hacerBotones(){
		console.println("hago buttons")
		botones.forEach({btn => game.addVisual(btn)})
		
		keyboard.down().onPressDo({flecha.position(game.at(6,1))})
		keyboard.up().onPressDo({flecha.position(game.at(6,3))})
		keyboard.enter().onPressDo({flecha.seleccionar()})
	}	
	
	method hacerPausa(){
		game.addVisual(cartelPausa)
		keyboard.m().onPressDo({self.pantallaCarga()})
		
		cartelPausa.pausar()
	}
	
	method quitarPausa(){
		game.removeVisual(cartelPausa)
		cartelPausa.reanudar()
	}
	
	method victoria(){
		game.clear()
		self.cambiarPantalla("assets/pantallaVictoria.png")
		keyboard.s().onPressDo({self.pantallaCarga()}) 
	}
	
	method derrota(){
		game.clear()
		self.cambiarPantalla("assets/pantallaDerrota.png")
		keyboard.s().onPressDo({self.pantallaCarga()})
		keyboard.enter().onPressDo({self.pantallaCarga()})
	}
	
	method cambiarPantalla(img){
		console.println("pantalla enviada para cambiar: " + img)
		self.image(img)
		game.addVisual(self)
	}
	
}

class Restringido{
	const columnas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var property conjunto = []
	method setear(){conjunto.clear()}
}

object filaInferior inherits Restringido{
	override method setear(){
		super()
		columnas.forEach({num => conjunto.add(new ObjetoInvisible(position = game.at(num,0)))})
		conjunto.forEach({celda => game.addVisual(celda)})
		conjunto.forEach({celda => game.onCollideDo(celda,{ ranita => celda.devolver(ranita)})})		
	}
}

object rio inherits Restringido{
	const filas = [8,9,10,11,12]
	var property ahogoRanita = true
	override method setear(){
		super()
		filas.forEach({fila => columnas.forEach({columna => conjunto.add(game.at(columna,fila))})})
	}
	
	method ahogar(ranita){
		if(not rana.tieneSoporte()){
			ranita.perderVida()
		}
	}
}

object score{
	var puntos = 0
	
	method subirPuntos(){
		if(puntos == 2){
			self.setear()
			interfaz.victoria()
		}
		else{
			puntos += 1
			[autos,soportes].forEach({conjunto => conjunto.aumentarVelocidades() })
			rana.position(game.at(9,1))
		}
	}
	method setear(){
		puntos = 0
	}
}
