Program potenciaN;

{Desarrollar una funcion que calcule la potencia enesima de un numero x}

Function Pot(x,n:integer):real;
	var
		i: integer;
		ctr: boolean;	
	Begin
		ctr:= False;
		Pot:= 1;

		if n<0 then
			begin
				ctr:= True;
				n:= n*(-1);
			end;
		
		for i:=1 to n do
			begin
				Pot:= (Pot*x)
			end;

		if ctr then
			Pot:= 1/Pot;
	End;

var
	x, n: integer;

Begin
	writeln('Calculadora de potencias Xn');
	write('Ingrese X: ');readln(x);
	write('Ingrese N: ');readln(n);
	writeln;
	writeln(x,'^',n,' = ',Pot(x,n):4:2);
end.
