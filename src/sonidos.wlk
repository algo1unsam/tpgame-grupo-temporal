import wollok.game.*
// MUSICA DEL JUEGO
object musica{
	var property sonando
	// REPRODUCE LA MUSICA
	method reproducir(cancion){
		sonando = soundProducer.sound(cancion)
		sonando.play()
	}
	// MUSICA DEL MENU
	method sonidoMenu(){
		sonando = soundProducer.sound("assets/musicaMenu.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.7)
	}
	// DETIENE LA MUSICA
	method sonidoStop(){
		sonando.stop()
	}
	// MUSICA DEL JUEGO PRINCIPAL
	method sonidoJuego(){
		sonando = soundProducer.sound("assets/musicaGame.mp3")
		sonando.play()
		sonando.shouldLoop(true)
		sonando.volume(0.3)
	}
	// PAUSA LA MUSICA
	method pausar(){
		sonando.pause()
	}
	// REANUDA LA MUSICA
	method reanudar(){
		sonando.resume()
	}
	
}
// SONIDO PARA LOS TESTS 
object soundMock {
	
	method pause(){}
	
	method paused() = true
	
	method play(){}
	
	method played() = false
	
	method resume(){}
	
	method shouldLoop(looping){}
	
	method shouldLoop() = false
	
	method stop(){}
	
	method volume(newVolume){}
	
	method volume() = 0
}

object soundProducer {
	
	var provider = game
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}

object soundProviderMock {
	
	method sound(audioFile) = soundMock
	
}