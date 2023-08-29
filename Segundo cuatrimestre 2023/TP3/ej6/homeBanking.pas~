Program homeBanking;

{ Se conoce el saldo inicial de una cuenta bancaria y una serie de movimientos realizados, 
por cada uno: 
	-cod mov [D]Deposito [R]Retiro [F]Fin
	-monto

Escribir un programa que ingrese dichos datos y determine el monto exacto despues de procesar las 
transacciones. 
Indique cuantas veces no pudo retirar dinero por insuficiencia de fondos}

var
	montoi, monto: real;
	action: char; 
	check1: boolean;
	contFi: byte;
begin
	action:= ' ';
	contFi:= 0;	
	writeln('Home Banking');
	write('Ingrese su saldo inicial: ');readln(montoi);
	
	while (action <> 'F') do
		begin
			repeat
				write('[D]Deposito [R]Retiro [F]Fin :');readln(action); 
				action:= upcase(action);				
				check1:= ((action='R')or(action='D')or(action='F'));
			until check1;		
			
			if action <> 'F' then
				begin			
					write('Ingrese el monto a retirar/depositar: $');readln(monto);
					
					if (action='R')then
						begin
							if monto<=montoi then
								begin								
									montoi:= montoi - monto;
									writeln('Transaccion exitosa');
								end
							else
								begin
									writeln('Fondos insuficientes');
									contFi:= contFi + 1;
								end;
						end
					else
						begin
							montoi:= montoi + monto;
							writeln('Transaccion exitosa');
						end;
				end;		
		end;
	writeln('Monto final: $',montoi:5:2);
	writeln('Cantidad de Transacciones erroneas: ', contFi);	
	readln();
end.
