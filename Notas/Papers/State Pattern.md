### Usos
- El comportamiento de un objeto depende de su estado, y este estado cambia en tiempo de ejecución. 
-  Se tienen operaciones grandes con instrucciones condicionales que dependen del estado del objeto.
	- En este caso el estado quizas no cambia en runtime, pero es mas conveniente organizar el codigo asi.

### Ventajas

- **Mantenibilidad:** Localiza el comportamiento específico del estado, facilitando la adición de nuevos estados o la modificación del comportamiento de los existentes.
- **Claridad:** Hace que las transiciones de estado sean explícitas y fáciles de entender.
- **Compartir objetos de Estado:** Los objetos de Estado sin variables de instancia pueden ser compartidos por múltiples contextos, reduciendo la duplicación de código. Es decir, cada estado seria un ***singleton***