Program ej6;

var 
	N, cif, cent: integer; //no es byte porque el numero puede superar los 255 caracteres
Begin
	writeln('Ingrese un numero entero de mas de 3 cifras');
	readln(N);
	cif := Trunc(N/1000);
	cent := Trunc((N/100)) mod 10;

	writeln('El numero ingresado es: ',N);
	writeln('El numero ingresado sin las ultimas 3 cifras: ', cif);
	writeln(cent);
	readln();
end.
