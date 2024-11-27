- La empresa tiene un sistema **batch**. A la noche generan un archivo de los pedidos, etc.
- Hay otro sistema que se encarga del pago (validacion de la tarjeta de credito, etc)
	- `MerchantProcessor`. Esto cobra por transaccion! Se debe validar la mayor cantida de informacion posible antes de enviarla al mismo. (no le voy a mandar una tarjeta vencida).
	- Tiene un ambiente de desarrollo, pero se debe usar luego de la integracion
	- Tiene una interfaz REST
		- Estandariza la comunicacion de sistemas, es un protocolo de comunicacion de sistemas, que se monta sobre HTTP, que a su vez se monta sobre TCP.
		- le pasamos `creditCardNumber, creditCardExpiration, creditCardOwner, transactionAmount`.
			- Si el formato esta mal devuelve 400 (bad request)
			- Si pudo debitar, devuelve 200 con "0 OK"
			- Si no pudo debitar se desea pasar la descripcion del error al usuario.
		- A veces se cae el `MerchantProcessor`. Si esta caido (devuelve timeout), al momento de validar una transaccion, se debe guardar en un archivo la transaccion. Estas transacciones se procesan ***de manera batch*** a la noche. 


# La interfaz REST que nosotros ofrecemos
1) `/createCart`: 
	- `clientId, password`
2) `/addToCart`
	- `cartId, bookIsbn, bookQuantity>=1`
3) `/listCart`

4) `/checkoutCart`
	- `cartId, ccn, ccen, cco`
	- Esto hace el cobro al cliente. Si le puedo cobrar, devuelvo el transactionId
	- Si no, devuelvo error y el codigo de error
5) `/listPurchases`
	- `clientId, password`
	- devuelve las compras del cliente, y su total gastado
	- si hay error devuelve `1 | descripcion de error`


# Formato de archivos
...
#




