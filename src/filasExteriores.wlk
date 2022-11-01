import wollok.game.*
import interfaz.*
import personajes.*
import autos.*
import soportes.*
import rio.*
import personajesAuxiliares.*
import movimiento.*

object filaInferior inherits Restringido{
	override method setear(){
		super()
		columnas.forEach({num => conjunto.add(new ObjetoInvisible(position = game.at(num,0)))})
		conjunto.forEach({celda => game.addVisual(celda)})
		conjunto.forEach({celda => game.onCollideDo(celda,{ ranita => celda.devolverArriba(ranita)})})		
	}
}

object filaSuperior inherits Restringido{
	override method setear(){
		columnas.forEach({num => if(not nenufar.celdas().contains(num)){conjunto.add(new ObjetoInvisible(position = game.at(num,14)))}})
		conjunto.forEach({celda => game.addVisual(celda)})
		conjunto.forEach({celda => game.onCollideDo(celda,{ ranita => celda.devolverAbajo(ranita)})})
	}
}