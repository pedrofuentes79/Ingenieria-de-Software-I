El concepto de iniciar un ambiente de objetos que tiene smalltalk se llama bootstrapping. Sucede en todos los lenguajes que tienen una VM (java, python, ruby), solo que en smalltalk podemos guardar eso en un archivo que llamamos imagen.

---

La VM solamente sabe que cada objeto es una instancia de una clase, y que cada clase tiene un diccionario (sus metodos). A partir de eso, podemos construir lo que llamamos el **metamodelo**.


-----
Ejemplo
```
hoy := Date new.
hoy class. " busca en la clase Date, no lo encuentra, va a Object y lo encuentra. Se ejecuta en el contexto de 'hoy' "

Date class. "busca en Class, no encuentra, va a Object, lo encuentra y lo ejecuta en el contexto 'Date' "
```
- Class es instancia de si mismo... tiene ese chiche
----

## Cambio en el metamodelo
- Para que la clase Date sepa responder mensajes especializados, del tipo `Date today`, hay que hacer ciertos cambios en el metamodelo.
- Ahora, necesitamos que las clases tengan comportamiento especializado. Esto lo logramos haciendo que la clase `Date` sea instancia de su propia clase! De este modo, `today` esta definido en la clase de `Date`. Sin esto, las clases no sabian responder mensajes por si mismas, solo podian pedirle a su clase padre (`Class`) que les resuelva eso con el methodLookup.
- A esta clase, la llamamos `DateClass`, lo mismo para `Object`, se llama `ObjectClass`. A su vez, todas las clases que objetos que definamos, tienen que tener una jerarquia, para evitar redefinir. Es decir, `DateClass` va a ser subclase de `ObjectClass`, de este modo solamente definimos el `new` en `ObjectClass` y el resto de clases (metaclases) lo van a saber responder.
	- Estas metaclases tienen una sola instancia! por eso pueden responder `soleInstance`, pero este metodo no esta implementado en `Class`, porque no todas las clases tienen una sola instancia. (ejemplo `Date`)
- Finalmente, `ObjectClass` es instancia de `MetaClass`, donde se definen los comportamientos de las Metaclases.
- Y ademas, para terminar el ciclo, `Class`  y `Metaclass` son subclases de `Object`.

- "Toda clase es instancia de su metaclase, y las metaclases tienen su propia instancia

---
Despues se agrega `Behavior`, y `MetaClass` y `Class` son subclases de el.
	Behavior representa todo lo que tiene un comportamiento.
		Sabe responder `new` por ejemplo
		
A su vez, `Behavior` subclasifica `Object`.
y la frutilla del postre, `Behavior` es instancia de `BehaviorClass`, que es instancia de `MetaClass`, como cualquier otra.

Tambien, `Class es instancia de ClassClass`, que es instancia de `MetaClass`, como cualquier otra.

Y para cerrar el circulo, `MetaClass` es instancia de `MetaClassClass`, que a su vez es instancia de `MetaClass`, como cualquier otra.

A partir de entender este metamodelo, podemos entender el metamodelo de cualquier otro lenguaje de programacion.

- Para el final: The Early History Of Smalltalk
- 