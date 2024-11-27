- Idiom
	- solucion concreta a un problema recurrente
	- Depende del lenguaje de programacion
	- No resuelve nada de un modelo de negocio???
- Patrones de diseño
	- Son soluciones abstractas, no tienen codigo relacionado

- Frameworks
	- Inversion de control: Los objetos del framework le envian un mensaje a mi objeto especifico.
		- Son los frameworks quienes inician la colaboracion, el envio de mensajes
		- Es distinto en una collection, por ejemplo.
		- TODO: ahondar un poco mas en lo de inversion de control
	- Si son concretos
	- Depende del lenguaje de programacion
	- Resuelve un problema tecnologico! no resuelve un problema de negocio


-----
Separacion modelo-vista

---
Los frameworks van evolucionando, **madurando**
1) Generan codigo
	- Scaffolding
		- Esto es codigo repetido! Si estas siempre generando codigo, es porque el framework no puede generalizar ese codigo para unificarlo en una clase
		- Y si tengo que modificar el codigo que generan?
2) "de caja blanca"
	- Se rompe encapsulamiento, se mete con la implementacion
	- Utiliza subclasificacion
	- EJ: app web, tengo que crear un `CustomerController`, y hay una clase llamada `Controller` que yo tengo que subclasificar para hacer la mia
		- Esto rompe el encapsulamiento, ya que la subclase tiene que poder acceder a la implementacion de su padre

	- Si una superclase, al actualizar de version por ejemplo, implementa el mensaje `xx`, que yo tenia en mi sublcase, me genera un problema, ya que semanticamente pueden no ser lo mismo!
	- Ejemplo: en `rails` tenes que subclasificar `ActiveRecord`. Genera acoplamiento!

3) "de caja negra"
	- ORM
	- Mapeo de bases relacionales???
	- No subclasificas una clase ya existente, si no que INSTANCIAS una clase ya existente.

---

# Patrones de diseño

- Composite, por ejemplo. No lo podemos "bajar de internet". Tenemos que implementarlo cada vez en el contexto en el que lo necesitamos. 
- No hay codigo relacionado.
- No depende del lenguaje del programacion
- Son soluciones que no estan relacionadas con ningun dominio de negocio en particular.
	- A partir de ciertos ejercicios en los que reconocemos un problema recurrente, vamos a tener que deducir los patrones de diseño nosotros mismos!


- *The timeless way of building*. Libro sobre arquitectura que documenta patrones de arquitectura recurrentes.

- Lo mas importante de los patrones de diseño son la intencion

- Hay que aprenderlos, entenderlos y olvidarlos! NO hay que proponerlos como solucion directa a un problema de entrada.
- La estructura es lo que menos importa en un patron de diseño. Son todos casi iguales en cuanto a patron estructural.
	- La jerarquia de clases, estructuralmente, es igual
	- Los diferencia la intencion! cumplen objetivos distintos.
- 