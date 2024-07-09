Program LiqSueldos;

{ Se debe liquidar el sueldo de N empleados, de ellos se sabe Nombre y antiguedad en años.
Todos parten de un basico de 15000 y la antiguedad se calcula: 

	-Hasta 5 años 5%
	-de 6 a 10 años 8%
	-de 11 a 15 años 12%
	-mas de 15 años 20%

Ademas se descuenta un 11% por cargas sociales y $500 de seguro obligatorio. 
Calcular e informar: 
	-Nombre y sueldo de cada empleado
	-Nombre del empleado que mas cobra
	-Monto de sueldo promedio
}

var
	i, N, ant{antiguedad}: byte;
	nombre, nomDest{Empleado que mas cobra}: string[10];
	sueldo, sumSueld{sum de sueldos}, prom{promedio}, sueldoMax: real;
	
const
	sueldoBase = 15000;
	seguro = 500;
	cargSoc = 0.89;
	ant1 = 1.05;
	ant2 = 1.08;
	ant3 = 1.12;
	ant4 = 1.20;
	
begin
	sumSueld:= 0.0;
	prom:= 0.0;
	sueldo:= 0.0;
	sueldoMax:= 0.0;

	write('Ingrese la cantidad de empleados que desea calcular: ');readln(N);

	for i:=1 to N do
		begin
			write('Ingrese el nombre del empleado: ');readln(nombre);
			write('Ingrese la antiguedad del empleado: ');readln(ant);

			if ant <= 5 then
				sueldo:= sueldoBase*ant1
			else if ((ant>=6)and(ant<=10)) then
				sueldo:= sueldoBase*ant2
			else if ((ant>=11)and(ant<=15)) then
				sueldo:= sueldoBase*ant3
			else
				sueldo:= sueldoBase*ant4;

			sueldo:= (sueldo - seguro)*cargSoc;

			sumSueld:= sumSueld + sueldo;

			if sueldo >= sueldoMax then
				begin
					sueldoMax:= sueldo;
					nomDest:= nombre;
				end;

			writeln('El sueldo de ',nombre,' es $',sueldo:5:2);
		
		end;
		prom:= sumSueld/N;
		writeln('El empleado que mas cobra es ',nomDest);
		writeln('El promedio de sueldos es de: ',prom:5:2);
		readln;

end.
