Program AlumnosNotas; 

{Dado un conjunto de alumnos, no se sabe cuantos son y de cada uno de ellos se conoce:
	-Nombre
	-Nota1, Nota2, Nota3

Ingresar la informacion e informar 
	a- El promedio de cada alumno y su condición
		-'Aprobado' si su promedio es mayor o igual a 4
		-'Desaprobado' si su promedio es menor a 4
	b- Porcentaje de alumnos aprobados}

var
	nombre: string;
	nota1, nota2, nota3: byte;
	promedio: real;
	sumNotas, contA: word;
	arch: text;
begin
	promedio:= 0.0;
	sumNotas:= 0;
	contA:= 0;
	
	Assign(arch, 'notas.txt');
	reset(arch);

while nombre <> '***' do
	begin
		readln(arch, nombre);
		readln(arch, nota1, nota2, nota3);
		
		promedio:= (nota1+nota2+nota3)/3;

		if (nombre <> '***') then
			begin
				if(promedio >= 4) then
					writeln('El alumno/a ',nombre,' ha aprobado la asignatura con ',promedio:2:1)		
				else
					writeln('El alumno/a ',nombre,' ha desaprobado la asignatura con ',promedio:2:1);				
			end;
		
		writeln;	
		contA:= contA + 1;
		sumNotas:= sumNotas + nota1 + nota2 + nota3;	
	end;
	Close(arch);

	promedio:= sumNotas/(contA*3);
	writeln('El promedio general es de: ',promedio:2:1);
	readln;
end.
