- en la solucion, el `Cashier` se modela "por venta", es decir que tiene el carrito como colaborador interno, y no cambia. No es necesariamente la unica solucion. tiene sus pro y contras.
	- Esta bueno porque queda mas *MethodObject*. Sirve mas para **registrar la venta**.
- No modele todavia el `LibroDeVentas` porque no tuve la necesidad de registrar las ventas aún.


- Estaria bueno armar la TestObjectsFactory que defina todas las tarjetas de credito, el merchant, las fechas, etc, para usar en los tests.

# Simuladores
- Dummy: No se usan en el contexto del test, cualquier objeto puede actuar como dummy.
	- Es decir, como no le enviamos ningun mensaje, le podemos mandar cualquier cosa y va a funcionar igual. En un lenguaje dinamico podes pasar cualquier cosa. En uno estatico tenes que crear un objeto dummy de ese tipo en particular.

- Fake: implementan lo mismo que el objeto que simulan, pero de manera mas liviana.
	- Ejemplo: una BD in-memory (las posta usarian disco)

- Stub: configuramos su comportamiento para que devuelva lo que queremos

- Mock: Guarda los mensajes que va recibiendo. Las aserciones se hacen sobre ***como colaboraron los objetos***. Es decir, que mensajes recibio el merchant processor y de quien.

- Este es un ejemplo de test de caja blanca.
```smalltalk
merchant := Mock onlyProcessing.
receivedMessages := merchant receivedMessages.

debitFromMessage := receivedMessages first.

self assert: debitFromMessage selector equals: #debit:#from:.
self assert: 
```

- No sobrevive a un renombre de `#debit:#from:`. No esta tan bueno por eso...
	-


# Interfaz externa
- Facade/API/ etc
- Los tests de la cara interna de la interfaz tienen que estar en terminos del protocolo REST. Recien ahi configuramos la cara externa de la interfaz. 


# Tests
-  createCart?user_id=id&pass=pass
	1) caso en el que no se autentican el user_id y la password. La autenticacion la resuelve otro sistema externo (el cual tenemos que simular con un stub)
	2) caso correcto. que tengo que asertar sobre la response? nada.. es un id. No me deberia dar nada de info ese id.  Quiero ver que ese id es de un carrito vacio
		- Tengo que usar listCart para eso! osea, dependo de haber implementado bien lo otro. 
- listCart
	1) 