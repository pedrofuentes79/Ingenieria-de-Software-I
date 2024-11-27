- es lo que se usa para, dado un msj y un objeto receptor, buscar el metodo relacionado a ese objeto y a ese mensaje.


- DTS: Dispatch Table Search
	- Es un algoritmo "medio choto", en el sentido de que es *O(n)*
	- GCL: Global Lookup Cache
		- Esto se usa para mejorar la performance. 

| Class  | Selector | Method |
| ------ | -------- | ------ |
| clase1 | m1       | ^ 10   |
- Con tan solo 256 entradas, el hitrate es de ~95%. Si le pones mas, empeora xD.


- Otro algoritmo es PIC: Polymorphic Inline Cache
- 