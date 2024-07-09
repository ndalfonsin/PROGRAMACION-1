Program eContable;
{Un estudio contable registro la facturacion de varios comercios en los ultimos N meses, por cada uno se tiene:
	-Nombre
	-Tipo (S/N)
	-Cant meses
	-Importe (x mes)

Se pide informar 
	-Nombre, tipo y cuanto pago de iva en los ultimos N meses
	-El nombre del comercio Responsable inscripto que menos facturo en total

Impuesto => Si es R.I 21%
			Si no es R.I 21% + 10%}

Function Impuesto(esRI: char; facturacion:real):real;
	Const
		RI = 0.31;
		notRi = 0.21;
	Begin
		if (esRi = 'S') then
			Impuesto:= facturacion * RI
		else
			Impuesto:= facturacion * notRi;
	End;

var
	Nombre, nombreMenFac{Nombre del comercio de menor facturacion}: string;
	esRI, ctr : char;
	facturacion, menFact: real;
	N: byte;
	

Begin
	menFact:=1000000000; {el valor maximo es 34000000000.0}
	ctr:= ' ';
	Repeat
		Write('Ingrese el nombre del comercio: ');readln(Nombre);
		Write('Es responsable inscripto? [S]si [N]no: ');readln(esRI);
		Write('Cuantos meses tiene registrados?: ');readln(N);
		Write('Ingrese el importe mensual facturado sin IVA: ');readln(facturacion);
		writeln;
		writeln('Datos ingresados: ');
		writeln('Nombre: ',Nombre);
		
		if (upcase(esRI) = 'S') then
			writeln('Es responsable inscripto')
		else
			writeln('No es responsable inscripto');

		writeln('Cantidad de meses facturados: ',N);
		writeln('Facturacion de IVA por ',N,' meses: $',Impuesto(esRI, facturacion):4:2);
		writeln;
		if (facturacion<menFact) then		
			nombreMenFac := nombre;
		writeln('Desea seguir ingresando comercios? [S]si, [N]no');readln(ctr);
		writeln;
	Until (ctr = 'N');
	writeln('El comercio que menos pago de iva es: ',nombreMenFac);
	readln;
End.	
