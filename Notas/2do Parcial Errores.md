- No deberia haber creado `Blinky` y `Clyde`, con un objeto `PacmanGameGhost` me alcanzaba. Diferenciar entre fantasmas era el trabajo del PacmanGame. La unica diferencia entre Blinky y Clyde es que uno arranca mirando a la izquierda y otro a la derecha. El movimiento de estos es controlado por el Game, entonces es lo mismo!

- En general el camino que segui con el orden de los tests no se si fue el optimo...

- Tanto las entidades como el tablero conocian la posicion de ambos...

- Estaba mal modelar el State de la entidad! Con tener guardado un "displacement" como variable de instancia alcanzaba. Es decir, 
```
nextPosition
	^ position + displacement
...
startMovingLeft
	displacement := 1@0.
```
Esto ahorraba un monton de complejidad! Incluso un monton de codigo :P


- No hice la jerarquia de Pill, podria haber pasado la cantidad de puntos a aumentar si era recibida por un pacman.  Es decir
```
BigPill
receivePacman
	^ game pillReceivesPacmanAdding: 2
...
SmallPill
receivePacman
	^ game pillReceivesPacmanAdding: 1
```

Incluso es innecesaria la jerarquia de SmallPill y BigPill. Solo con una clase pill que conociera su cantidad de puntos alcanzaba.

- Era mas facil que el fantasma se quede con la Pill en vez de hacer el quilombo que hice con hiddenPositions. Es decir, que el fantasma cuando haga leavePosition que le diga al game que ponga una pill donde el estaba antes.

----
