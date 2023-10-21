Program Parcial2022;

{Un Municipio de una localidad turística registra el ingreso de turistas de manera resumida para los últimos N 
años, y para cada año por trimestre. La cantidad de turistas está compuesta por dos valores: cantidad de turistas 
mayores de edad y cantidad de turistas menores de edad. Ambas cantidades están en miles de personas. 
Estos datos se tienen en un archivo de texto TURISTAS.TXT, en la primera línea el valor de N y en las siguientes N 
líneas, una por cada año en orden descendente (comenzando desde 2021). En cada línea se tienen 8 valores: los 
primeros 4 corresponden a los mayores de edad en cada uno de los trimestres, y los últimos 4 a los menores de 
edad. 

En otro archivo ESCALAS.TXT, se almacenan escalas de asistencia turística por trimestre, una escala por fila con su 
descripción (cadena de 15) y su tope máximo de turistas (por ej MUY BAJA 2000, indica que si ingresaron 2000 
turistas o menos, la escala correspondiente es muy baja). Las escalas a manejar son: MUY BAJA, BAJA, MEDIA, 
ALTA, MUY ALTA, EXTRAORDINARIA. 

Además, se establece como un registro FAMILIAR a los trimestres donde la cantidad de turistas menores de edad 
es igual o mayor a la de los mayores de edad. 

Se pide leer los datos de los archivos y almacenar la información necesaria en las estructuras adecuadas, 
paraluego: 
    a) Generar un arreglo con los años,la cantidad total de turistas mayores de edad y menores de edad que 
tengan al menos 2 trimestres con escala X o mayor (X ingresado por teclado; tener en cuenta uso de la 
función Trim (agregar sysutils en sección Uses)). Luego mostrar el arreglo generado. 
    b) Obtener el trimestre con menor asistencia promedio teniendo en cuenta todos los años. En caso de que 
exista más de uno, quedarse con el primero obtenido. 
    c) Dado un año K ingresado por teclado (puede no existir entre los que estaban en el archivo), calcular el 
porcentaje de registros de tipo FAMILIAR. 

Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), necesarios 
para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
    - Calcular la asistencia promedio para un trimestre en todos los años (para el inciso b) 
    - Contar registros de tipo FAMILIAR para un año determinado (para el inciso c) 
Nota: No resolver de manera recursiva ningún otro subprograma que no sean los especificados. }

