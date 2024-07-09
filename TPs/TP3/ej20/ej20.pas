Program DelimitadoresNegativosPromedio;

{Leer desde un archivo un conjunto de numeros, con elementos negativos que funcionaran como delimitadores de subconjuntos. Obtener e informar el promedio de cada subconjunto}

var
	Arch: text;
	num, sum: integer;
	promedio: real;
	i, cont: byte;
begin
	
	i:= 0;
	
	Assign(Arch, 'numeros.txt');
	Reset(Arch);
	readln(Arch,  num);

	while not EOF(Arch) do
		begin
			sum:= 0;
			cont:= 0;
			if num > 0 then
				readln(Arch,num);
			if num < 0 then
				begin
					readln(Arch, num);
					while num > 0 do
						begin
							sum:= sum + num;
							cont:= cont + 1;
							readln(Arch, num);
						end;
					promedio:= sum/cont;
				writeln('El promedio del subconjuto ',i,' es: ',promedio:4:2);
				i:= i + 1;
				end;		
		end;
end.
