Program Factorial;

{Desarrollar una funcion para calcular el factorial de un numero
	si n=0 => 1
	si n>0 => n(n-1)!}


Function calcF(n:integer):integer;
	var
		i:byte;
	begin
		calcF:= 1;		
			
		for i:=(n-1) downto 1 do
			calcF:= calcF + (calcF*i);
	end;

var
	n: integer;
begin
	write('Ingrese el numero del que desea el factorial: ');readln(n);
	
	if n > 0 then
		writeln(calcF(n))
	else
		writeln(1);
end.
