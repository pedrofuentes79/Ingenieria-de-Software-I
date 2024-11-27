diferencia entre adapter y decorator
- El decorator agrega funcionalidad ortogonal
- El adapter adapta el protocolo de un objeto para que pueda comunicarse con otro
	- Solamente agrega la funcionalidad relacionada con adaptar
- No tiene sentido hacer una "cadena" del adapter
- No hay perdida del 'self'.

- Estructuralmente son muy similares, pero el concepto es distinto

- Tiene el problema de que si tenes n objetos a adaptar, tenes `n` objetos para adaptar a un modelo. Y si tenes `m` modelos, tenes una explosion de clases de `n x m` clases...

- Pero, con metaprogramacion se puede hacer algo...

```smalltalk
ProtoObject subclass: PlugabbleAdapter

doesNotUnderstand: aMessage
"evalua el closure que tiene en el diccionario, si tiene una key con aMessage"
"si no la tiene, manda super doesNotUnderstand: aMessage"

```

- `PluggableAdapter` conoce un diccionario que tiene como keys a los mensajes y como valores los closures que representan la implementacion de ese mensaje.
	- `#asShowable -> [...]`
- Asi evitamos la explosion de clases y lo mantenemos todo en una.

```smalltalk
ProtoObject 

adapting: aSelector with: aBlockClosure
"agrega al diccionario"

```
- `PluggableAdapter` es una "clase *on the fly*", en el sentido de que la creas a tu gusto cuando la instancies y le agregues entradas al diccionario.


- Ademas, `PluggableAdapter` pasa a ser una clase dinamica, le podemos modificar sus mensajes y sus implementaciones en tiempo de ejecucion.
- 
- En python se puede hacer algo parecido con \_get__attr__
- 

# Proxy
- diferencia con el decorator y adapter
	- No agrega funcionalidad! Solamente controla el acceso a ese objeto.
	- No tiene mucho sentido chainear proxies...
		- Un ejemplo de que si tiene sentido es con objetos remotos. Si vos hablas con un objeto en otra maquina, lo haces mediante un proxy. Y si ese objeto se va a otra maquina, no te enteras, simplemente hablas con el proxy que dejo en su primer maquina.
	- La diferencia es la intencion del patron.