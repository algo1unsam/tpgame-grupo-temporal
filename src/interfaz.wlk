import wollok.game.*
import personajes.*
import autos.*
import soportes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*

object startBtn{
	var property position = game.at(7, 3)
	var property image = "assets/playBtn.png"
	
	method presionar(){
		game.clear()
		self.cambiarFondo()
		self.gestionarMusica()
		self.setearObjetos()
		self.gestionarRana()
		self.gestionarPausa()
	}
	
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/bgTestV4def.png")
	}
	
	method gestionarMusica(){
		musica.sonidoStop()
		musica.sonidoJuego()
	}
	
	method gestionarRana(){
		game.addVisualCharacter(rana)
		rana.setearListeners()
	}
	
	method gestionarPausa(){
		keyboard.p().onPressDo({
			if(game.getObjectsIn(game.at(6,8)).contains(cartelPausa)){
				interfaz.quitarPausa()	
			}else{
				interfaz.hacerPausa()
			}
		})
	}
	
	method setearObjetos(){
		[vidas,filaInferior,filaSuperior,nenufar,rio,mosca,score,soportes,autos,rana].forEach({obj => obj.setear()})
	}
	
}

object instrBtn{
	var property position = game.at(7, 1)
	var property image = "assets/instrBtn.png"
	
	method presionar(){
		game.clear()
		self.cambiarFondo()
		self.gestionarMusica()
		self.gestionarVuelta()
	}
	
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/instrucciones.png")
	}
	
	method gestionarMusica(){
		musica.sonidoStop()
		musica.sonidoJuego()
	}
	
	method gestionarVuelta(){
		keyboard.v().onPressDo({
			interfaz.pantallaCarga()
			musica.sonidoStop()
		})
	}
}

object flecha{
	var property position = game.at(6,3)
	var property image = "assets/flecha.png"
	
	method seleccionar(){
		game.sound("assets/seleccionar.mp3").play()
		self.dameSeleccion().first().presionar()
	}
	
	method mover(){
		if(self.position().y() == 1){
			self.position(game.at(6, 3))
		}else{
			self.position(game.at(6, 1))
		}
	}
	
	method dameSeleccion(){
		const selecPos = game.at(self.position().x()+1, self.position().y())
		return game.getObjectsIn(selecPos) 
	}
}

object cartelPausa{
	var property position = game.at(6, 8)
	var property image = "assets/cartelPausa.png"
	
	method pausar(){
		rana.modoPausa()
		musica.pausar()
		soportes.detenerse()
		autos.detenerse()
	}
	
	method reanudar(){
		rana.quitarPausa()
		musica.reanudar()
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
		game.schedule(200, {=>musica.sonidoMenu()})
		self.cambiarPantalla("assets/pantallaCarga.png")
		self.hacerBotones()
	}
	
	method hacerBotones(){

		botones.forEach({btn => game.addVisual(btn)})
		
		keyboard.down().onPressDo({
			game.sound("assets/moverMenu.mp3").play()
			flecha.mover()
		})
		keyboard.up().onPressDo({
			game.sound("assets/moverMenu.mp3").play()
			flecha.mover()
		})
		keyboard.enter().onPressDo({
			game.sound("assets/moverMenu.mp3").play()
			flecha.seleccionar()
		})
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
		self.gestionarMusica("assets/sonidoGanador.mp3")
		self.cambiarPantalla("assets/pantallaVictoria.png")
		keyboard.s().onPressDo({
			self.pantallaCarga()
			musica.sonidoStop()
		}) 
	}
	
	method derrota(){
		game.clear()
		musica.sonidoStop()
		game.schedule(1000, {self.gestionarMusica("assets/gameOver.mp3")})
		self.cambiarPantalla("assets/pantallaDerrota.png")
		self.gestionarBotonesDerrota()
	}
	
	method cambiarPantalla(img){
		self.image(img)
		game.addVisual(self)
	}
	
	method gestionarMusica(cancion){
		musica.sonidoStop()
		musica.reproducir(cancion)
	}
	
	method gestionarBotonesDerrota(){
		keyboard.s().onPressDo({self.pantallaCarga()})
		keyboard.enter().onPressDo({self.pantallaCarga()})
	}
	
}

object score{
	var property position = game.at(0,14)
	var property textColor = "FFFFFFFF"
	var property puntos = 0
	var property text = (0).toString() + "/5"
	
	method subirPuntos(){
		if(puntos == 4){
			game.removeVisual(self)
			self.setear()
			interfaz.victoria()
		}
		else{
			self.gestionarMultimedia()
			self.gestionarMosca()
			self.aumentarDificultad()
		}
	}
	
	method gestionarMultimedia(){
		game.sound("assets/sumarPuntos.wav").play()
		puntos += 1
		self.text((puntos).toString() + "/5")
	}
	
	method gestionarMosca(){
		game.removeVisual(mosca)
		mosca.setear()
	}
	
	method aumentarDificultad(){
		[autos,soportes].forEach({conjunto => conjunto.aumentarVelocidades() })
		rana.position(game.at(9,1))	
	}
	
	method setear(){
		game.addVisual(self)
		puntos = 0
		text = (0).toString() + "/5"
	}
}

object musica{
	var property sonando
	
	method reproducir(cancion){
		sonando = game.sound(cancion)
		sonando.play()
	}
	
	method sonidoMenu(){
		sonando = game.sound("assets/musicaMenu.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.7)
	}
	
	method sonidoStop(){
		sonando.stop()
	}
	
	method sonidoJuego(){
		sonando = game.sound("assets/musicaGame.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.6)
	}
	
	method pausar(){
		sonando.pause()
	}
	
	method reanudar(){
		sonando.resume()
	}
	
}