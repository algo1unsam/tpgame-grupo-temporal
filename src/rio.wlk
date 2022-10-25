import wollok.game.*
import interfaz.*
import personajes.*
import autos.*
import soportes.*
import filasExteriores.*
import personajesAuxiliares.*
// CONSTRUCTOR DEL RIO 
object rio inherits Restringido{
	const filas = [8,9,10,11,12]
	var property ahogoRanita = true
	// INICIALIZO LOS OBJETOS
	override method setear(){
		super()
		filas.forEach({fila => columnas.forEach({columna => conjunto.add(game.at(columna,fila))})})
	}
}

// CONSTRUCOR DE LOS NENUFARES
object nenufar inherits Restringido{
	const property celdas = [0,2,4,6,8,10,12,14,16,18]
	// INICIALIZO LOS OBJETOS
	override method setear(){
		super()
		celdas.forEach({celda => conjunto.add(new ObjetoInvisible(position = game.at(celda,13)))})
		conjunto.forEach({celda => game.addVisual(celda)})
		conjunto.forEach({celda => game.onCollideDo(celda,{ ranita => ranita.perderVida()})})
	}
}