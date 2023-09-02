Program DelimitadoresNegativos;

{Leer desde un archivo un conjunto de numeros, con elementos negativos que funcionaran como delimitadores de subconjuntos. Obtener e informar el valor maximo de cada subconjunto}

var
	Arch: text;
	num, max: integer;
	i: byte;
begin
	
	i:= 0;
	
	Assign(Arch, 'numeros.txt');
	Reset(Arch);
	readln(Arch,  num);

	while not EOF(Arch) do
		begin
			max:= 0;
			if num > 0 then
				readln(Arch,num);
			if num < 0 then
				begin
					readln(Arch, num);
					while num > 0 do
						begin
							if num>max then
								max:= num;
							readln(Arch, num);
						end;
				writeln('El maximo del subconjuto ',i,' es: ',max);
				i:= i + 1;
				end;		
		end;
  	Close(Arch);
end.
