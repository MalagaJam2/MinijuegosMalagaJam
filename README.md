# Guía del repositorio comunitario

Este es un proyecto comunitario creado con Godot por y para la comunidad. Su finalidad es pasar un buen rato haciendo minijueguitos. 
Como son bastante cortos, no debería llevar mucho tiempo crear un minijuego (y si lo lleva, no pasa nada). 
El objetivo es llegar a tener un catálogo muy grande de minijuegos y generar una especie de Mario Party / Wario Ware creado por la comunidad.
Las funcionalidades del juego en general se irán aumentando a lo largo de el tiempo pero el objetivo por ahora es:

Crear un juego de minijuegos de 2 a 4 jugadores donde 1 persona gana tras haber conseguido X victorias (siendo X configurable dentro del juego)

## Versión de Godot
Estamos usando la versión 4.7.2

## Requisitos de los minijuegos
- Deben ser minijuegos de entre 7 a 15 segundos
- Deben de poder jugarse con un único botón por jugador (Vale contar la pulsación, dejar de pulsar el botón o mantener el botón)
- Intenta que haya solo 1 ganador. A futuro barajaremos opciones de empate y juegos por equipos.

## Tutorial de como implementar nuevos minijuegos
> Además de este tutorial, también teneis una versión en video: https://youtu.be/sFes9TlMNf4

**⚠️ Para poder subir tus cambios, debes hacer un FORK del repositorio, sino, no te dejará pushear tu rama y hacer un pull request. ⚠️**

Para implementar nuevos minijuegos, tendrás que descargarte el proyecto, crear una rama partiendo desde develop y ahí ya podrás trabajar.<br>
Es recomendable que la rama tenga un nombre estilo: **minigames/NombreMinijuego** para tener los minijuegos agrupados en una sección "minigames".<br>
Crea una carpeta dentro de la carpeta raíz **Minijuegos** con el nombre de tu minijuego Ejemplo: "Minijuego de saltar a la comba".<br>
Ahí colocaras tus scripts, escenas, sprites... Todo lo que necesite tu minijuego.

**Los minijuegos deben ocurrir en una única escena.** <br>
Esta escena debe de tener un script que herede de **MinigameBase**, para que pueda funcionar con la carga de niveles de forma automática.<br>
Debes crear un recurso del tipo **MinigameData** en la carpeta de tu minijuego. Este archivo es donde pondrás los datos de las personas involucradas en el minijuego y una explicación breve de como jugar al minijuego, además de una imagen que sirva de preview. Estos datos aparecerán luego en una preview del minijuego que aparece antes de jugarlo.<br>
Coloca este archivo en el campo **MinigameData** del nodo del minijuego.<br>

A la hora de implementar tu minijuego. Usa las funciones de **OnMinigameStarted** para iniciar tu minijuego. Esta función es llamada desde el gestor de escenas para indicar cuando empieza el minijuego.<br>
Cuando termine tu minijuego, añade la puntuación de quien ha ganado con **ScoreManager.AddVictoryToPlayer(idDelJugadorGanador)** y para continuar con el siguiente minijuego usa la función de MinigameBase **TransitionToNextMinigame()**

Para los input de los jugadores, usaremos la clase global **InputController** que tiene las siguientes señales: <br>
- playerButtonPressed(playerId: int) -> Cuando un jugador ha pulsado un botón, devuelve el id del jugador<br>
- playerButtonReleased(playerId: int) -> Cuando el jugador ha soldato el botón, devuelve el id del jugador<br>
- playerButtonIsBeingPressed : Array[bool] -> También tenemos un array de tipo bool que devuelve en cada frame que botones se están pulsando. Por si vuestro juego necesita comprobar si se están pulsando los botones.<br>
Aunque es recomendable usar la combinación de los dos anteriores (Press y release) para saber si se está haciendo el hold.

Para saber que jugadores están jugando, usa **GetCurrentPlayersIds()** de **PlayersController** que es un array tipo int que te dice los ids de los jugadores que están jugando actualmente.

Para probar el minijuego. Ve a la escena PlayerSelection y en el nodo **RoundController** añade al atributo **AvailableMinigames** tu escena de minijuego. ⚠️Recuerda que el nodo de la escena de tu minijuego debe tener un script que herede de **MinigameBase**

Puedes quitar la escena que haya puesta en el **RoundController** para que así salga tu minijuego directamente, pero **no subas cambios de la escena de PlayerSelection al repositorio** ⚠️

Ahora al darle al play debería salirte una pantalla con botones. Pulsa las teclas **A S D F** para activar los botones de los jugadores y pulsa la tecla **Espacio** para comenzar. *Estas teclas son las que se usarán para testear los inputs de los jugadores, pero a futuro en la versión jugable, los inputs irán definidos por las personas que vayan a jugar.*

Aparecerá la ventana preview del minijuego y deberás pulsar los botones de los jugadores para indicar que están listos.<br>
Después empezará la escena del minijuego.

> ⚠️ Para los nombres de vuestros scripts, intentad usar la siguiente nomenclatura: **NombreDelMinijuego_nombreDelScript** para evitar duplicación de nombres con scripts de otros minijuegos

## Consejos
Como los botones del juego son Rojo, Azul, Verde y Amarillo, si aparece input en pantalla para cada jugador, intenta que sea del color de los botones para que el jugador sepa cuando tiene que pulsar. Por ejemplo, en el minijuego de servir comida, los platos de la comida asignada a cada jugador, son de esos colores. 

## Subir tu minijuego
Una vez hayas probado tu minijuego y comprobado que todo funciona bien. Haz commit de tu rama y hazle push para subirla. Después ve a Github y debería aparecer un mensaje para hacer el pull request:
<p align="center">
<img width="800" height="300" alt="Tutorial6" src="https://github.com/user-attachments/assets/251aaa43-8ac3-473e-9a91-2b78ceb81ecf" />
</p>
Crea tu pull request para subir los cambios
<p align="center">
<img width="478" height="243" alt="Tutorial7" src="https://github.com/user-attachments/assets/a563ee08-ecde-412f-b7ed-8e661ee46c49" />
</p>
Pon la información necesaria para que podamos ver como probar tu juego en el pull request y dale a **Create pull request**
<p align="center">
<img width="800" height="500" alt="Tutorial8" src="https://github.com/user-attachments/assets/91c1d276-2b4b-4935-a0ff-c0a085df08b4" />
</p>
Con eso ya estará todo perfecto y listo para ser revisado


## Herramientas adicionales de ayuda
Para sustituir Dotween hay una clase global llamada **TweenAnimator** que por ahora cuenta con las siguientes funciones:
- ShakeNode2D(node: Node2D, duration: float = 0.3, strength: float = 5.0) -> Hace vibrar un nodo2D
- PunchNode2D(node : Node2D, targetSize: Vector2, duration: float) -> Efecto de punch en un node2D (es decir, cambia la escala a targetSize y luego vuelve a su escala original)
- FadeInOutColorRect(colorRect: ColorRect, color: Color, alpha : float, time:float) -> Hace que la transparencia de un color rect vaya del valor en el que está al valor dado en la variable alpha en el tiempo dado y luego vuelve al valor original.
