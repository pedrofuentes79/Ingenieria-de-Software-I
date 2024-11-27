1) crear un carrito, que este vacio  (devuelve 200)

4) caso feliz del addToCart (todo es correcto y anda ok)
5) agregar un libro con isbn incorrecto
6) agregar un libro con cantidad <1 rompe
7) agregar un libro a un carrito invalido rompe


### Given [setup] when [execution] then [verification]
GivenInvalidCredentialsWhenCreatingCartFails
GivenValidCredentialsWhenCreatingCartReturnsEmptyCart

# Diseño de un sistema


Interface                 MODELO                Interface


REST               Objetos y Mensajes        REST




- Mi test no deberia entrar por la interfaz, deberia mantenerse dentro del modelo, hablando en Objetos y Mensajes. Hacerlo asi es mas simple, de otro modo estamos testeando la interfaz en si...


- Top down, bottom up, middle out. (respecto del arbol de ejecucion, que se ve algo como interfaz->interfaz... -> cart)
- Top down
	- Se simulan ciertas cosas por simpleza (???
	- Ej: al testear una cuenta bancaria que se conecta con una lista, se *simula* esa lista con la que se conecta la cuenta. Asi, testeamos la cuenta bancaria de manera **unitaria**.
	- Tu test queda acoplado a la implementacion
	- No se puede testear un objeto ***in isolation***.
	- Se tarda mucho en tener un primer test
- Bottom up
	- test unitarios de caja negra (testean funcionalidad)
	- Al empezar por abajo, no sabemos ***qué*** es lo que necesitamos hacer en nuestro sistema. Tenemos que imaginar que va a suceder mas arriba.
		- Ej: Empezar a testear el objeto `Libro`, en el que empezamos a testear ciertas cosas del libro. Luego, pensamos que el `Libro` es agregado al `Carrito`, y lo testeamos.

- Middle out
	- Empezamos (por debajo de la interfaz generalmente) y por un objeto. Empiezo por ese objeto, luego voy hacia abajo, y luego voy hacia arriba
	- No necesito tener todo desarrollado para empezar a testear
	- No empiezo por tests que no tienen valor, por ser tan chiquitos
	- Empiezo por algo que haga algo que sea significativo en el sistema.
	- Son tests funcionales, no unitarios. Y caja negra.
	- No hay que mockear ni simular nada.




# Test unitario vs funcional
- Testear una unidad / modulo (?)
	- No es claro que es una unidad. (algo que corre rapido?? algo simple??)

- Fowler los llama solitarios vs sociales, respectivamente
	- Testea un objeto que esta solo
	- Testean objetos que estan en sociedad con otros

-----------

- Los tests que hacemos con TDD son los que nos sirven a los programadores, para generar codigo. 
- Tienen que ser rapidos, faciles de mantener. 

----
#### Metaforas
En el ejercicio TusLibros la metafora es como en el supermercado (el carrito...)
- Amazon la pego con la metafora del carrito, haciendo simple el entendimiento de que es lo que hace la aplicacion: "ahhh, es como ir al supermercado, meto cosas en el carrito y despues pago"

- En el supermercado, siempre que agarramos un carrito, **esta vacio**
- Entonces, no vamos a testear el tema de la autenticacion, porque de eso se encarga la interfaz. Primero representamos bien el modelo, luego la interfaz.
- 
