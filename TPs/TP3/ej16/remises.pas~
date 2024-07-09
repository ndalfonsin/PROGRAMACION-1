Program Remises;

{Una empresa de autos de alquiler posee N autos y ha registrado la siguiente informacion de los viajes realizados, para cada uno de ellos:
 	-Patente
	-Total de litros consumidos
	-KM recorridos

Se pide ingresar los datos e informar:
	-Por cada auto el consumo que tuvo (cantidad de litros por km recorridos)
	-Patente del vehiculo que mas viajes hizo
	-Total de litros consumidos por el auto que hizo la menor cantidad de viajes}


var
	patente, MasViajes: string[6];
	km, kmXViaje, litros, menLitros: word;
	N, i, cantViajes, cantViajesAnt: byte;
	Arch: text;
begin
	cantViajes:= 0;
	cantViajesAnt:= 0;
	menLitros:= 32000;
	Assign(Arch, 'autos.txt');
	reset(Arch);
	readln(Arch, N);

	for i:=1 to N do
		begin
			readln(Arch, patente);
			readln(Arch, litros);
			readln(Arch, km);
			readln(Arch, kmXViaje);

			while kmXViaje <> 0 do
				begin	
					cantViajes:= cantViajes + 1;
					readln(Arch, kmXViaje);
				end;

			if  cantViajes>cantViajesAnt then
				MasViajes:= patente;
			
			if menLitros>litros then
				menLitros:= litros;		
			
			writeln('Auto nro: ',patente);
			writeln('Cantidad de consumo: ',litros/km:4:2,'l/km');
			writeln;		
		end;
	writeln('El auto que mas viajes realizo es: ',MasViajes);
	writeln('Total de litros consumidos por el auto que menos viajes hizo: ',menLitros:2);
	readln;
end.
