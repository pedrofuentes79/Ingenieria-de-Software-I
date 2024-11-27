MarsRover >> accept: aVisitor
aVisitor receivRoverAt: position facing: direction.

LogVisitor
receiveRoverAt: aPosition facing: aDirection

- Esto no funciona xD! el accept lo esta llamando el visitor. Yo en realidad quiero que esto se triggeree cuando el MarsRover cambia de direccion/posicion.

- a menos que el marsRover tenga una coleccion de visitors, y le envie a todos un mismo mensaje ???
---
- la facil es que el MarsRover conozca un log y que le envie el mensaje logAt: position facing: direction.
	- El problema es que esto no es la esencia del MarsRover


---
- La opcion del decorator (ya que esto seria funcionalidad ortogonal...) dijeron en clase que no es tan asi...

---
# Decorator

```smalltalk
ObservedMarsRover >> move

```