Program enteros;

{ Se desean ingresar N numeros enteros por teclado y se debera calcular e informar:

	-El maximo, que lugar ocupa la primera aparicion y cuantas ocurrencias tiene
	-El minimo de los impares
}

var
	posMax, max, min, contMax, num, i, N: byte;
begin
	max:= 0;
	min:= 255;
	contMax:= 1;	

	write('Cual es la cantidad de numeros que desea ingresar?: ');readln(N);
	
	for i:=1 to N do
		begin
			write('Ingrese el ',i,' numero: ');readln(num);
			
			if num>max then
				begin				
					max:= num;
					posMax := i;
				end
			else if num = max then
				contMax := contMax + 1;
			
			if num<min then 
				min:= num;				
		end; 
	
	writeln('El mayor de los numeros es: ',max);
	writeln('Aparece por primera vez en la posicion ',posMax);
	writeln('Aparece ',contMax,' veces');
	writeln('El menor de los numeros es: ',min);
	readln;
end.
