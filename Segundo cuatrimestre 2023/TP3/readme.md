# Utilizacion del Random

se debe agregar un `randomize;` antes de utilizar el Random() para que en todos los ciclos no te devuelva el mismo numero aleatorio.

	randomize;
	aleatorio:= Random(50);

# Procesamiento de secuencia de caracteres

El reconocimiento de ciertos `Patrones` sobre las secuencias de caracteres.

`XXXXXXXXX XXX X XXX X.`

Una secuencia vacia contiene solo un punto.
La lectura se realiza caracter a caracter.
Uno de los problemas tipicos es reconocer "Parejas" de caracteres, lo que requiere tener `dos caracteres consecutivos` de la secuencia en dos variables.

	Program SecMa;

	{Determinar cuantas veces aparece la silaba 'ma' en la sentencia}

	var
		arch: text;
		Car1,Car2: char;
		ContMa: word;

	Begin
		ASSIGN(arch, 'Secuen.txt'); RESET(arch);
		ContMa:= 0;
		
		read(arch, Car1); {lee el primer caracter}
		while Car1 <> '.' do
			begin
				read(arch, Car2); {lee el segundo caracter de la pareja}
				if (Car1='m')and(Car2='a') then
					ContMa:= ContMa + 1;
				Car1:=Car2;{El segundo caracter sera el primero}
			end;
		
		Close(arch);
		writeln('El total es de: 'ContMa);
	End.


