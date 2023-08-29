Program enteros;

{Ingresar N numeros enteros e informar cuantas veces se supera al anterior}

var
	num, numAnt: integer;
	cont, N, i: byte;
begin
	numAnt:= 32767; //inicializo en el maximo posible
	cont:= 0;

	write('Cuantos numeros desea ingresar: ');readln(N);

	for i:=1 to N do
		begin
			write('Ingrese el ',i,' numero: ');readln(num);

			if num>numAnt then
				cont:= cont + 1;					

			numAnt:= num;
		end;
	
	writeln('Se supero ',cont,' veces el numero anterior');
	readln;
end.
