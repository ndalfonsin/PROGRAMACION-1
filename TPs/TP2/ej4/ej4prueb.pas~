Program compFechas;

(*
	Dadas dos fechas (dia, mes, año) indicar cual es la mas antigua y a que trimestre pertenecen
*) 

var 
	year1, year2: integer; //Porque para el 3000 no creo se siga usando pascal
	dia1, dia2, mes1, mes2: byte;
Begin	
	writeln('Debera ingresa 2 fechas para ser comparadas {Dia, mes, año}');
	writeln();
	writeln('PRIMER FECHA');
	write('Ingrese el dia: ');readln(dia1);
	write('Ingrese el mes: ');readln(mes1);
	write('Ingrese el año: ');readln(year1);
	writeln();
	writeln('SEGUNDA FECHA');
	write('Ingrese el dia: ');readln(dia2);
	write('Ingrese el mes: ');readln(mes2);
	write('Ingrese el año: ');readln(year2);

	if year1 > year2 then
		begin	
			writeln('La segunda fecha es la mas antigua');
		
			if mes2 <= 4 then
				writeln('Pertenece al primer trimestre')
			else if mes2>4 and mes2<=8 then
				writeln('Pertenece al segundo trimestre')
			else
				writeln('Pertenece al tercer trimestre');
		end	
	else if year1 < year2 then
		begin
			writeln('La primer fecha es la mas antigua');
		
			if mes1 <= 4 then
				writeln('Pertenece al primer trimestre')
			else if mes1>4 and mes1<=8 then
				writeln('Pertenece al segundo trimestre')
			else
				writeln('Pertenece al tercer trimestre');
		end
	else
		begin
			if mes1 > mes2 then
				begin
					writeln('La segunda fecha es la mas antigua');
		
					if mes2 <= 4 then
						writeln('Pertenece al primer trimestre')
					else if mes2>4 and mes2<=8 then
						writeln('Pertenece al segundo trimestre')
					else
						writeln('Pertenece al tercer trimestre');	
				end
			else if mes1 < mes2 then
				begin
					writeln('La primer fecha es la mas antigua');
		
					if mes1 <= 4 then
						writeln('Pertenece al primer trimestre')
					else if (mes1>4 and mes1<=8) then
						writeln('Pertenece al segundo trimestre')
					else
						writeln('Pertenece al tercer trimestre');
				end
			else
				begin
					if dia1 > dia2 then
						writeln('La segunda fecha es la mas antigua')
					else
						writeln('La primer fecha es la mas antigua');
					
					if mes1 <= 4 then
						writeln('Pertenece al primer trimestre')
					else if (mes1>4 and mes1<=8) then
						writeln('Pertenece al segundo trimestre')
					else
						writeln('Pertenece al tercer trimestre');
				end;
		end;	
End. 
