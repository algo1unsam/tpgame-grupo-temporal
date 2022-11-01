import wollok.game.*
import personajes.*
import autos.*
import soportes.*
import filasExteriores.*
import rio.*
import personajesAuxiliares.*
import sonidos.*
import movimiento.*

object botonInicio{
	var property position = game.at(7, 3)
	var property image = "assets/playBtn.png"
	//INICIA EL JUEGO 
	method presionar(){
		game.clear()
		self.cambiarFondo()
		self.cambiarMusica()
		self.setearObjetos()
		self.gestionarRana()
		self.gestionarPausa()
	}
	// CAMBIO AL FONDO DEL JUEGO 
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/bgTestV4def.png")
	}
	// INICIO AL MUSICA DEL JUEGO
	method cambiarMusica(){
		musica.sonidoStop()
		musica.sonidoJuego()
	}
	// INICIALIZACION DE LA RANA 
	method gestionarRana(){
		game.addVisualCharacter(rana)
		rana.setearListeners()
	}
	// BOTON DE PAUSA
	method gestionarPausa(){
		keyboard.p().onPressDo({
			if(game.getObjectsIn(game.at(6,8)).contains(cartelPausa)){
				interfaz.quitarPausa()	
			}else{
				interfaz.hacerPausa()
			}
		})
	}
	// INICIALIZO LOS OBJETOS DEL JUEGO
	method setearObjetos(){
		[vidas,filaInferior,filaSuperior,nenufar,rio,mosca,score,soportes,autos,rana].forEach({obj => obj.setear()})
	}
	
}

object botonInstrucciones{
	var property position = game.at(7, 1)
	var property image = "assets/instrBtn.png"
	// INICIALIZA LA PANTALLA DE INSTRUCCIONES
	method presionar(){
		game.clear()
		self.cambiarFondo()
		self.cambiarMusica()
		self.volverInicio()
	}
	// CAMBIA EL FONDO 
	method cambiarFondo(){
		interfaz.cambiarPantalla("assets/instrucciones.png")
	}
	// CAMBIA A LA MUSICA DEL JUEGO
	method cambiarMusica(){
		musica.sonidoStop()
		musica.sonidoJuego()
	}
	// AL PRESIONAR V VUELVE A LA PANTALLA DE INCIO
	method volverInicio(){
		keyboard.v().onPressDo({
			interfaz.pantallaCarga()
			musica.sonidoStop()
			soundProducer.sound("assets/seleccionar.mp3").play()
		})
	}
}
// FLECHA DEL MENU 
object flecha{
	var property position = game.at(6,3)
	var property image = "assets/flecha.png"
	// SELECCIONA EL OBJETO 
	method seleccionar(){
		soundProducer.sound("assets/seleccionar.mp3").play()
		self.dameSeleccion().first().presionar()
	}
	// METODO PARA MOVERSE ENTRE LOS OBJETOS
	method mover(){
		if(self.position().y() == 1){
			self.position(game.at(6, 3))
		}else{
			self.position(game.at(6, 1))
		}
	}
	// DEVUELVE AL POSICION DEL OBJETO SELECCIONADO
	method dameSeleccion(){
		const selecPos = game.at(self.position().x()+1, self.position().y())
		return game.getObjectsIn(selecPos) 
	}
}
// CARTEL DE PAUSA 
object cartelPausa{
	var property position = game.at(6, 8)
	var property image = "assets/cartelPausa.png"
	// PAUSA LOS OBJETOS DEL JUEGO
	method pausar(){
		rana.modoPausa()
		musica.pausar()
		soportes.detenerse()
		autos.detenerse()
	}
	// REANUDA LOS OBJETOS DEL JUEGO
	method reanudar(){
		rana.quitarPausa()
		musica.reanudar()
		soportes.moverse()
		autos.moverse()
	}
}

// OBJETO QUE CONTIENE LAS DIFERENTES INTERFACES DEL JUEGO 
object interfaz {
	var property image = ""
	var property position = game.origin()
	var property botones = [botonInicio, botonInstrucciones, flecha]
	// PANTALLA DE INICIO 
	method pantallaCarga(){
		game.clear()
		game.schedule(200, {=>musica.sonidoMenu()})
		self.cambiarPantalla("assets/pantallaCarga.png")
		self.hacerBotones()
	}
	// INICIA LOS BOTONES Y MUEVE LA FLECHA
	method hacerBotones(){
		const tocarMusiquita = {soundProducer.sound("assets/moverMenu.mp3").play()}
		botones.forEach({btn => game.addVisual(btn)})
		
		keyboard.down().onPressDo({
			tocarMusiquita.apply()
			flecha.mover()
		})
		keyboard.up().onPressDo({
			tocarMusiquita.apply()
			flecha.mover()
		})
		keyboard.enter().onPressDo({
			tocarMusiquita.apply()
			flecha.seleccionar()
		})
	}	
	//LLAMAR A LA PAUSA
	method hacerPausa(){
		game.addVisual(cartelPausa)
		keyboard.m().onPressDo({self.pantallaCarga()})
		
		cartelPausa.pausar()
	}
	//SACAR LA PAUSA
	method quitarPausa(){
		game.removeVisual(cartelPausa)
		cartelPausa.reanudar()
	}
	// PANTALLA DE VICTORIA 
	method victoria(){
		game.clear()
		self.cambiarMusica("assets/sonidoGanador.mp3")
		self.cambiarPantalla("assets/pantallaVictoria.png")
		keyboard.s().onPressDo({
			self.pantallaCarga()
			musica.sonidoStop()
			soundProducer.sound("assets/seleccionar.mp3").play()
		}) 
	}
	// PANTALLA DE DERROTA
	method derrota(){
		game.clear()
		musica.sonidoStop()
		game.schedule(1000, {self.cambiarMusica("assets/gameOver.mp3")})
		self.cambiarPantalla("assets/pantallaDerrota.png")
		self.mostrarBotonesDerrota()
	}
	// AUXILIAR PARA CAMBIAR LAS PANTALLAS
	method cambiarPantalla(img){
		self.image(img)
		game.addVisual(self)
	}
	// AUXILIAR PARA LA MUSICA 
	method cambiarMusica(cancion){
		musica.sonidoStop()
		musica.reproducir(cancion)
	}
	// BOTONES DE LA PANTALLA DE DERROTA
	method mostrarBotonesDerrota(){
		keyboard.s().onPressDo({
			self.pantallaCarga()
			soundProducer.sound("assets/seleccionar.mp3").play()
		})
		keyboard.enter().onPressDo({
			self.pantallaCarga()
			soundProducer.sound("assets/seleccionar.mp3").play()
		})
	}
	
}
//CARTEL DE PUNTUACION
object score{
	var property position = game.at(0,14)
	var property textColor = "FFFFFFFF"
	var property puntos = 0
	var property text = (0).toString() + "/5"
	// AUMENTA LA DIFICULTAD CADA VEZ QUE SE SUBE DE PUNTUACION LLEGANDO A LA MOSCA, SI LLEGA A 4 CAMBIA A LA PANTALLA DE VICTORIA
	method subirPuntos(){
		if(puntos == 4){
			game.removeVisual(self)
			self.setear()
			interfaz.victoria()
		}
		else{
			puntos += 1
			self.sonidoSubirPuntos()
			self.reiniciarPosicionMosca()
			self.aumentarDificultad()
		}
	}
	// REPRODUCE SONIDOS AL SUBIR PUNTOS
	method sonidoSubirPuntos(){
		soundProducer.sound("assets/sumarPuntos.wav").play()
		self.text((puntos).toString() + "/5")
	}
	// REINICIA LA POSICION DE LA MOSCA
	method reiniciarPosicionMosca(){
		game.removeVisual(mosca)
		mosca.setear()
	}
	// AUMENTA LA VELOCIDAD DE LOS OBJETOS 
	method aumentarDificultad(){
		[autos,soportes].forEach({conjunto => conjunto.aumentarVelocidades()})
		rana.position(game.at(9,1))	
	}
	// INICIA EL CARTEL DE PUNTUACION
	method setear(){
		game.addVisual(self)
		puntos = 0
		text = (0).toString() + "/5"
	}
}
