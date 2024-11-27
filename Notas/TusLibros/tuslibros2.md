- Hay que modelar realmente el carrito? 
	- si no le agrega nada de funcionalidad, alcanza con usar una `Collection`
- No solo porque se hable de algo en el dominio de problema hay que crear una clase que lo represente


- por todo esto es que el primer test no deberia testear cosas que podria hacer con una `Collection` y nada mas.
- Si ya tenes una abstraccion que resuelve tu problema, porque crearias una nueva clase?
	- Ejemplo al modelar fracciones, tengo que modelar `Numerador` y `Denominador`?
		- No, porque es solamente un numero, no tiene ninguna funcionalidad aparte de eso


- En este caso, lo que diferencia al carrito de una `Collection` es que el carrito no puede tener libros de otra editorial!


## Mis tests
- Mis primeros 3 tests estan haciendo el zero, one, many de la cantidad de libros agregados. Termino testeando la collection en vez del carrito.

- Al hacer un test que tiene que fallar, tenemos que chequear: ***que no haya pasado lo que no tenia que pasar***.
	- En este caso, al agregar un ISBN invalido, que salte el error y que no se haya agregado al carrito.

- No hice el test de si un carrito conoce sus items. 

----
- Es responsabilidad del carrito determinar si es valido agregar X al carrito?
	- Podemos modelar un `Catalogo` que sepa que items son validos
		- Pero para que? podemos simplemente usar una `Collection` que sea conocida por el `Cart`.
- No tiene sentido modelar el libro, porque no hace nada!
	- *Los objetos son lo que hacen, si no hacen, no son.*


-----
# Cashier
- conoce una pricelist

#### Tests
1) cannot checkout empty cart
2) te cobra el precio correcto
3) >1 producto
4) Un producto que no este en la price list?
	- No! eso no deberia pasar pues asumimos que el carrito funciona bien. Estariamos testeando el carrito...
5) Empezar a modelar el pago. Primer test de pago con la tarjeta
	- Todo sigue dentro del mensaje checkoutCart:
		- No agrego otro asi mantengo los test 2 y 3. Asumo que el pago anda para estos tests
	- MerchantProcessor
		- Deberia tener un falso MerchantProcessor.
		- Al tener que interactuar con algo externo, pasa a ser un test fragil/erratico
			- La regla de oro de los tests es que tienen que estar en control de TODO.
	- Le corresponde a la tarjeta decidir si esta vencida? Hasta ahi, le puedo mandar la fecha de hoy, y que con esa fecha diga si esta vencida o no.


---
# Objetos simuladores
- Dummies, stubs, mocks, fakes

---
# Interfaces
- Cara interna y cara externa de la interfaz. La cara interna sigue hablando en idioma objetos y mensajes, y la cara externa habla REST, o lo que sea.

- Para el MerchantProcessor puedo tener, en la cara externa, el objeto simulador del MerchantProcessor.
- La otra opcion es simular la cara interna. El `Cashier` habla directamente con el objeto simulador. 
	- Esto es mas facil. Si bien voy a tener que modelar la externa en algun momento:
		- Me va a tomar mas tiempo
		- No tengo que testear la cara externa, yo estoy testeando el `Cashier`.
		- La cara interna real, no la simulada, la voy a desarrollar en algun momento, y ahi voy a simular la cara externa!
		- El objeto simulador es polimorfico con su simulado.



- Ya pensando en el test, el test de la tarjeta robada. En el test mismo nosotros le decimos al merchant processor que la tarjeta X esta robada, y luego tratamos de pagar con esa tarjeta.
	- `merchant debit: amount from: X`