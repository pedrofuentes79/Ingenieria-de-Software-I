- La idea es **mantener** un codigo choto ya hecho, sin tests.


 - Clase anemica: no tiene fuerza, no hace nada. Es decir, tiene getters y setters.


## Que hacer?
- Escribir tests para ver que funcione!

- Tipos de datos para test para usar.
	- Transient
		- Todos los datos estan en memoria
	- Persistent-fresh
		- Los datos persisten durante la ejecucion de los tests, pero se crean de vuelta cada vez que abrimos la base de datos.
	- Persistent-shared
		- Los datos se comparten entre los tests, y NO estan bajo el control de los tests


- Llevar el metodo al contexto del Test, de este modo ir destripandolo y ver que funcione, y luego ir separando cada pedazo del metodo donde corresponda, hasta que no quede nada de funcionalidad en el test.

- Estamos haciendo testing, no TDD. Podemos romper alguna que otra heuristica.
- En los tests, podemos empezar a cambiar un poco las clases existentes para darle una mejor semantica, aunque mantengamos toda la estructura anterior.


- Template Method: 
	- Ej: CSVImporter, con subclases CustomerImporter, ProductImporter, BankImporter, etc.
	- Si hacemos el metodo declarativo nos vamos a dar cuenta de que va a ser reutilizable.
