- Agregar funcionalidad de manera dinamica a un objeto.
	- La funcionalidad es **ortogonal** al objeto, es decir, no es del dominio del problema.
ejemplo: una `Connection` subclasificada/decorada para que sea una `LoggedConnection`.

- El objeto decorador conoce al objeto decorado. 
	- Es decir, el `LoggedConnection` loggea lo que tiene que loggear, y luego le delega la responsabilidad a `Connection`. 
	- Se pueden chainear los decorators.

Ejemplo de jerarquia
```smalltalk
Connection
	ConnectionDecorator
		EncryptedConnectionDecorator
		TracedConnectionDecorator
		ZippedConnectionDecorator
	TCPConnection (la conexion posta)
```
- Cada decorator define lo que tiene que definir, ya sea en el send o en el close. 
- Forwardea lo que no le corresponde hacer a su `decoratee`




- NO es una opcion a la clasificacion, no da lo mismo!!!



Con este ejemplo de decoradores podemos ver el patron builder, que crea objetos complejos. 
Por ejemplo, una conexion que se debe decorar con un zip, un logger y un encriptador, en ese orden. El builder crea esa cadena de decoraciones y devuelve el objeto que inicia la cadena.


- Delegar un mensaje vs Forwardear un mensaje
	- Se pierde el self si se forwardea el mensaje.
	- El decorator, en un lenguaje de prototipacion, no tiene sentido, no existe como problema.
	- El decoratee es el parent, ya existen esas cadenas de mensajes.