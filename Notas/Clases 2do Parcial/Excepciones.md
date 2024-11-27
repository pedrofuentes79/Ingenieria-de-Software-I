- Como y cuando usarlas?
	- 
	- Go no tiene excepciones por ejemplo...

### Explicacion Pragmatica y Conceptual
#### Pragmatica
- Al enviarle un mensaje a un objeto, quiero saber si *pudo* hacerlo o no.
- A pesar de cierto comportamiento excepcional, se puede seguir adelante con el sistema
- return code
```smalltalk
returnCode := self m2.
returnCode isError ifTrue: ["handleo error". ^rc].

returnCode := self m3.
returnCode isError ifTrue: ["handlero error". ^rc].
```
- En este handleo del error se puede intentar enviar el mensaje de nuevo, o hacer algo ad hoc.


- Desde el punto de vista, hay codigo repetido.
- Es propensa a errores, si justo no chequeamos el error, va a pasar desapercibido y se siga adelante.
- Es demasiado implementativo, esta mezclado el *que* vamos a hacer con el handleo del error.
- Por cada funcion que se utiliza, tenemos que ir a ver un `defines.h` que indique que significa cada codigo de error.


- Las **excepciones** son la manera de sacar ese codigo repetido, ademas de hacer que el codigo sea menos propenso a errores.
```smalltalk
[self doSomething] 
	on: AnErrorClass 
	do: [:error | self handleError: error].
```

### Programacion por contratos: explicacion conceptual

- Contratos explicitos e implicitos
- Que pasa cuando no se cumple un contrato?
- Eiffel implementa en si mismo el invariante, pre y post condiciones

- Contratos en objetos
	- Pre y post condiciones para ejecutar un metodo.
		- Pre: Condiciones de los colaboradores de un mensaje (ej: mandar una cantidad de dinero negativa, o acceder a un arreglo con un indice fuera del rango)
		- Post: que el codigo que se ejecuto es correcto, y condiciones respecto del resultado, o sobre las modificaciones que realizo el codigo.
		- Invariantes de una clase
			- Si la clase es una caja de ahorro, el saldo es $\geq$ 0
			- Los definimos en los tests! Se van dando en el proceso de TDD.
			- Chequeamos estas condiciones creando **objetos completos y validos**

	
	- Quien las verifica?


- Las excepciones se utilizan para indicar que no se cumple un contrato.

- Cuando sucede una excepcion en el mensaje mk en la cadena de mensajes m1,m2,m3,m4, ..mk
	- Se busca subiendo en el arbol de ejecucion si hay un mensaje que, al llamar a su hijo, handlee esa excepcion.


# Uso
- Cuando levantarlas?
	- Cuando se rompe un contrato
	- Pensarla como algo que no pertenece al dominio de una funcion matematica
	- **NO** se deben usar como control de flujo (ej salir de una recursion, ciclo, etc)
- Quien verifica el contrato?
	- C: el caller debe asegurar las precondiciones
		- Esto puede permitir mas performance, ya que si evitamos el chequeo ahorramos instrucciones. Es necesario estar ABSOLUTAMENTE seguro de que no se va a usar incorrectamente.
	- LISP: el callee debe asegurar las precondiciones
		- Esto genera menos codigo, ya que tenemos SOLO en el callee las verificaciones.
		- Mas seguro.
- Quien informa de la excepcion?
	- Generalmente, los que se encuentran mas abajo en el arbol de ejecucion.
		- Es porque son los que terminan "haciendo" mas cosas.
- Quien debe handlearla?
	- Generalmente son los que estan mas arriba.
	- La analogia de pedirle un cafe a alguien. Si yo le pido a mi hijo que me traiga un cafe de una maquina, y la maquina no tiene cafe. Entonces, en vez de mostrar "no hay cafe", te sirva te automaticamente. Seria bastante raro. O que mi hijo me traiga un te al ver que no hay cafe. Lo correcto seria que mi hijo venga sin nada, y yo decidir si quiero un te o si no quiero nada.
	- Esto es para tener mas informacion y contexto sobre las excepciones.
	- Arriba de todo, hay que tener un handler **generico** de excepciones, para que la aplicacion no rompa nunca, es el `UnexpectedError`
- Como se puede handlearlas?
	- Cerradas (Java, C#, Python, PHP)
		- Terminar el bloque donde se genero la excepcion
		- Se va pasando el contexto de ejecucion de los nodos del arbol de ejecucion.
	- Abiertas (SmallTalk, LISP, SELF)
		- Se devuelve el resultado del try si no hay errores, si no, se devuelve el resultado del bloque del catch.
		- Se puede pasar la excepcion actual al siguiente handler en el arbol de ejecucion, con `error pass.`
		- Se puede reintentar con `error retry`, o seguir adelante con `error resume: aValueToReturn`
			- Ej con division por cero, retornar 1.
- Como handlearlas?
	- `Transcript show: 'error de division con: '`
	- Si no se como handlear una excepcion, ***no deberia handlearla***
	- Por ejemplo, `ZeroDivide`. Los errores que representan un error de programacion no deberian handlearse, ***solo informarse***
- Que excepcion informar?
	- Un tipo de excepcion por cada condicion
		- `IndexOutOfBounds`, `InvalidBalance`, `InvalidName`
	- La misma excepcion siempre, no importa la condicion de error
		- `RuntimeException` (Java), `Error` (Smalltalk)
	- Un mix
	- El META es crear un nuevo tipo de excepcion **solo** cuando quiera handlear ese caso especifico. Ahora, si no voy a handlear ese caso en especifico, puedo usar un error generico y listo.
		- Pero, si estamos creando una clase que no define ningun metodo, ningun comportamiento, **no tiene sentido que exista**.
	- Si las quiero handlear o no a las excepciones, depende del software que estemos escribiendo.
		- Si estamos escribiendo una libreria, generalmente se generan excepciones "de mas" porque no sabemos si alguien va a querer handlear esa excepcion de manera distinta a las demas o no.
- 

