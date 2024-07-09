##Librerias

	uses
		Crt{Pantalla},Dos{Incluye ejecuciones del S.O}

Incluir Crt para usar ClrScr;
Incluir Dos para poder usar GetDate(anio, mes, dia, ds{dia de la semana})

	Type
		st10 = String[10];
	Var
		nombre:st10;

	function min(frase: st10):st10 {No permite poner String[10]}
		------
		end;

En los procedimientos los cambios que ocurren en la variable, no son globales. 

	Procedure cambio(y:integer);
		begin
			y:= 1 {Solo dentro del procedimiento}
			writeln(y); {=> 1}
		end;
	
	begin
		x:=0
		cambio(x);
		writeln(x); {=> 0}
	end;

Si en el procedimiento los valores de las variables cambian su valor es necesario: 

	Procedure cambio(var{asigno la variable como E/S} y:integer);
		begin
			y:= 1;
		end;
	
	begin
		x:=0
		cambio(x);
		writeln(x); {=> 1}
	end;

el var lo que hace es pasar la direccion de memoria de la variable {global} y permite al procedimiento alterar su valor. 


