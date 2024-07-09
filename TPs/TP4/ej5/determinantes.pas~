Program determinantes;
{Calcular la solucion por determinantes de un sistema de dos ecuaciones lineales con dos incognitas(se supone compatible y determinado).Desarrollar una funcion que dados a,b,c y d calcule x.

	X= |a b|   se calcula x=(a*e - d*b)
	   |c d|
Aplicarlo en 2x +3y = 5     6x + 3y = 12
			 3x -2y = 1     2x + y = 1
}

Function determinantes(a,b,c,d: integer):real;
	begin
		determinantes:= (a*c) - (d*b);
	end;

Var 
	a, b, c, d: integer;

Begin
	writeln('Ingrese el sistema de ecuaciones lineales de la siguiente manera');
	writeln('ax + by = t');
	writeln('cx * dy = t');
	write('Ingrese a: '); readln(a);
	write('Ingrese b: '); readln(b);
	write('Ingrese c: '); readln(c);
	write('Ingrese d: '); readln(d);

	writeln('El determinante de su matriz es: ',determinantes(a,b,c,d):4:2);
	readln;
End.
