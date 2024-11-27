
- Idea: recibir un mensaje y distribuir su procesamiento en partes mas pequeñas, de manera **polimorfica**.


- Ejemplo: igualar dos objetos.
	- Si tenemos objetos que son subclase de `comparableObject`, (o de `printableObject`, si se quiere usar otro ejemplo) y sus atributos tambien lo son, son polimorficos respecto de esa clase abstracta (`comparableObject`), y saben responder el mensaje `==`.




	- En vez de tener un objeto `Comparador` que se encargue de determinar si dos instancias de, por ejemplo, un objeto `Motor` son iguales, el `Motor` mismo sabe determinar si es igual a otro mediante recursion en sus atributos. Es decir, si `Motor` tiene ciertas variables como `Valvulas`, `ArbolDeLevas`y `Cigueñal`, el metodo se veria algo asi
```smalltalk
== otroMotor
^(valvulas == otroMotor valvulas) & (arbolDeLevas == otroMotor arbolDeLevas) & (ciguenal == otroMotor ciguenal).
```
De este modo, la variable de instancia `valvulas` se ocupara de igualarse a la variable de instancia `valvulas` de `otroMotor`, asi hasta llegar a un objeto que termine la recursion, como un `SmallInteger` o un `String`, ya el CPU se encarga de la comparacion de estos de manera trivial.


> Otro ejemplo motivador es el mensaje `copy` a un objeto. Este hara una copia simple, de la raiz del objeto, llamado `simpleCopy`, y luego hara una copia de los atributos del objeto, llamado `postCopy`. En este ultimo mensaje, cada atributo se copiara, enviando nuevamente el mensaje `copy`, asi hasta llegar a algo trivialmente copiable.
---

- Todos los objetos se pueden comparar de esta manera, llegando finalmente a un objeto final cuya comparacion es "primitiva".

# Ventajas
- **Procesamiento distribuido**
- **Flexibilidad de responsabilidades**: quien envia el primer mensaje no tiene porque saber hasta donde llega la recursion o como se distribuye el procesamiento de los mensajes en los distintos objetos.
- **Flexibilidad de roles**: Los objetos que actuan como *recursivos* para algunas cadenas pueden actuar como *casos base* para otros.
- **Encapsulamiento**: Cada objeto sabe como responder al mensaje recursivo en su propia interfaz, sin necesidad de que exista un objeto `Comparador` que encapsule toda la logica.

# Desventaja
- **Complejidad al programarlo**: Sobreuso de este patron puede hacer que se complejice mucho un sistema, y que sea dificil de entender y mantener.

# Aclaraciones
- El mensaje inicial que envia el cliente (`initiator makeRequest`) no debe ser polimorfico con el mensaje del recursor (`recursor handleRequest`)
	- Si el `makeRequest` no tiene ningun sender (o el `handleRequest`), nunca se va a iniciar la recursion, entonces todos los recursores y terminadores podrian nunca ser llamados, a pesar de tener senders.