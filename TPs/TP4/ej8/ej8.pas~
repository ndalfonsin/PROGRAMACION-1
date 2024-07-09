Program creditCards;

{En un archivo de texto se registraron las compras de N titulares de tarjetas de credito de la siguiente forma: 
	-codigo de cliente y a continuacion sus compras (no se sabe cuantas son)
		-tipoCompra => [C]Combustible, [S]Supermercado [O]Otros [F]Fin
		-Dia(1--31)
		-Monto

El banco ofrece un descuento de:
	-5% los dias 10, 20 y 30 para el tipo Otros si el monto supera los $300
	-10% para Combustible en la 2da quincena
	-15% para Supermercado en la 1er quincena

Se pide:
	a- Codigo de cliente y total abonado por cada cliente que no se beneficio de desc
	b- Cuantos clientes obtubieron descuento en los 3 rubros
	c- Informar cuanto ahorro cada cliente

DESARROLLAR UNA FUNCION DESCUENTO a partir de tipoCompra, dia y monto}

Function desc(tipoCompra:char; dia:byte; monto:real):real;
	Const
		descOtros = 0.05;
		descComb = 0.10;
		descSup = 0.15;
	Begin
		if ((tipoCompra = 'O')and((dia = 10)or(dia = 20)or(dia=30))and(monto>300)) then
			desc:= monto*descOtros
		else if ((tipoCompra = 'C')and(dia >= 15)) then
			desc:= monto*descComb
		else if ((tipoCompra = 'S')and(dia <= 15)) then
			desc:= monto*descSup
		else
			desc:= 0;
	End;

Type
	st8 = string[8];
Var
	Arch: text;
	tipoCompra: char;
	dia, acumDesc: byte;
	monto, montoTot, descuento: real;
	codUser: st8;
	conDesc, descC, descO, descS: boolean;
Begin
	Assign(Arch, 'creditCards.txt');
	Reset(Arch);
	
	while not EOF(Arch) do
		begin
			{Inicializacion de variables}
			conDesc:= False;
			montoTot:= 0;
			descC:= False;
			descO:= False;
			descS:= False;
			acumDesc:= 0;
			descuento:= 0;
			
			readln(Arch, codUser);
			readln(Arch, tipoCompra);
			while tipoCompra <> 'F' do
				begin
					readln(Arch, dia);
					readln(Arch, monto);
					montoTot:= montoTot + monto;
					descuento:= descuento + desc(tipoCompra, dia, monto);
					if descuento <> 0 then
						begin						
							conDesc:= True;
							if (tipoCompra = 'C') then
								descC:= True
							else if (tipoCompra = 'O') then
								descO:= True
							else if (tipoCompra = 'S') then
								descS:= True;			
						end;	 
					readln(Arch, tipoCompra);
				end;
			if not conDesc then
				begin
					writeln('El cliente ',codUser,' no ha aplicado a ningun descuento');
					writeln('El monto total a pagar es de: $',montoTot:2:2);
				end;
			if descC and descO and descS then
				acumDesc:= acumDesc + 1;
			writeln('El cliente ',codUser,' tuvo un total de descuentos de $',descuento:2:2);	
		end;
	writeln('un total de ',acumDesc,' accedieron a las 3 promociones');
	readln;
	Close(Arch);
End.		
