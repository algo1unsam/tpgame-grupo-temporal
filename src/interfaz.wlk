import wollok.game.*
import personajes.*

object startBtn{
	var property position = game.at(7, 3)
	var property image = "assets/playBtn.png"
	
	method presionar(){
		self.cambiarFondo()
		interfaz.removerBotones()
		[vidas,filaInferior,soportes,rio,autos,mosca].forEach({obj => obj.setear()})
		game.addVisualCharacter(rana)
		keyboard.p().onPressDo({
			if(game.getObjectsIn(game.at(6,8)).contains(cartelPausa)){
				interfaz.quitarPausa()	
			}else{
				interfaz.hacerPausa()
			}
		})
	}
	
	
	method cambiarFondo(){
		interfaz.image("assets/bgTestV4def.png")
	}
}

object instrBtn{
	var property position = game.at(7, 1)
	var property image = "assets/instrBtn.png"
	
	// tengo que hacer la pantalla de instrucciones
	method presionar(){}
	
	method cambiarFondo(){}
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
		soportes.moverse()
		autos.moverse()
	}
}


object interfaz {
	var property image = ""
	var property position = game.origin()
	var property botones = [startBtn, instrBtn, flecha]
	
	method pantallaCarga(){
		game.clear()
		self.image("assets/pantallaCarga.png")
		game.addVisualIn(self, game.origin())
		
		self.hacerBotones()
	}
	
	method hacerBotones(){
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
	
	method removerBotones(){
		botones.forEach({btn => game.removeVisual(btn)})
	}
	
	method victoria(){
		game.clear()
		self.image("assets/pantallaVictoria.png")
		game.addVisualIn(self, game.origin())
		keyboard.s().onPressDo({game.stop()}) 
	}
	
	method derrota(){
		game.clear()
		self.image("assets/pantallaDerrota.png")
		game.addVisualIn(self, game.origin())
		keyboard.s().onPressDo({game.stop()})
		keyboard.enter().onPressDo({self.pantallaCarga()})
		 
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
		game.onTick(250,"rio mata ranita",{conjunto.forEach({celda => if(rana.position() == celda and celda.allElements().size() == 1){self.ahogar(rana)}})})
	}
	
	method ahogar(ranita){
		if(not rana.tieneSoporte()){
			ranita.perderVida()
		}
	}
}

