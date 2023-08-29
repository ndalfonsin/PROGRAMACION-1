Program ej3;
(*
	Dada una cantidad X de horas trabajadas, calcular e imprimir el sueldo
bruto y neto de un empleado.
	
	+Paga: $200/hs
	-11% del previcional
	-5% de la covertura medica
*)
Var
	hs: byte;	
	sBruto, sNeto: real;
Const
	precHs = 200; //Precio por hora
	prev = 0.11; //Descuento de previcional
	cobMed = 0.05; //Descuento por cobertura medica
Begin
	Writeln('Calculo del sueldo bruto y neto. $200xHora');
	Writeln('Ingrese a cantidad de horas trabajadas');	
	readln(hs);
	
	//Calculo de sueldo Neto
	sNeto := precHs * hs;
	
	//Calculo de sueldo Bruto
	sBruto := sNeto - ((sNeto*prev)+(sNeto*cobMed));

	writeln('Cantidad de horas trabajadas: ',hs);
	writeln('Sueldo Neto: $',sNeto:4:2);
	writeln('Descuento del 11% previcional: -$',(sNeto*prev):4:2);
	writeln('Descuenton del 5% por cob medica: -$',(sNeto*cobMed):4:2);
	writeln('Sueldo Bruto: $',sBruto:4:2); 
End.	
