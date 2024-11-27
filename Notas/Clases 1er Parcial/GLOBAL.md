# Heuristicas
1) Crear objetos completos
2) Crear objetos validos
	- Se puede hacer con precondiciones de existencia de objetos.
3) Favorecer el uso de objetos inmutables.
4) No usar nill / null
5) Evitar getters y setters a menos que sea estrictamente necesario
	- Rompen encapsulamiento
6) Modificaciones atomicas
	- Un setter que modifica todo el objeto de una.

# Tips
- No le tengas miedo al colaborador interno. Puede mejorar mucho el codigo, en el sentido de que no tengo que mandar siempre por parametro otras cosas, y puedo separar mejor en distintos metodos.