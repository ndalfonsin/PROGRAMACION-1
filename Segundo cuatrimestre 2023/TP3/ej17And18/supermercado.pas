Program Supermarket;

{La cajera de un supermercado ha registrado varias ventas, de cada una se sabe:
	-nombre del cliente (***** indica fin de datos)
	-Si esta en promocion S o N
		Promocion: 10%
Se pide ingresar e informar: 
	-Monto total de cada venta, el total de descuento y el precio final
	-Nombre del cliente que compro mayor cantidad de articulos en oferta
	-Cuantos clientes compraron articulos solo en oferta}

var
	nombre, nombreMasCompras: String;
	Prom, aux: char;
	N, NmasCompras, i, contOferta: byte;
	valorCompra: integer;
	totalNeto, TotalBruto, valorDesc, totalDesc: real;
	todoOferta: boolean;
	Arch: text;
const
	desc = 0.90;
begin
	NmasCompras:= 0;
	contOferta:= 0;	
	Assign(Arch, 'ventas.txt');
	Reset(Arch);
	
	readln(Arch, nombre);
	
	while nombre <> '*****' do
		begin
			readln(Arch, N);
			todoOferta:= True;
			totalNeto:= 0;
			totalBruto:= 0;
			totalDesc:= 0;			

			for i:=1 to N do
				begin
					readln(Arch, valorCompra, aux, Prom);
					if prom <> 'S' then
						begin
							todoOferta:= False;
							totalBruto:= totalBruto + valorCompra; 
						end
					else
						begin
							valorDesc:= valorCompra*desc;
							totalDesc:= totalDesc + (valorCompra - valorDesc);
							totalBruto:= totalBruto + valorDesc;
						end;

					totalNeto:= totalNeto + valorCompra; 
				end;
			
			if todoOferta = True then
				contOferta:= contOferta + 1;
	
			if N > NmasCompras then
				begin
					NmasCompras := N;
					nombreMasCompras:= nombre;
				end;

			writeln('El/la cliente ',nombre,' ha gastado un total neto de: $',totalNeto:6:2);
			writeln('Ha ahorrado un total de $',totalDesc:6:2);
			writeln('Total Bruto: ',totalBruto:6:2);
			writeln;	
			readln(Arch, nombre);		
		end;
	writeln('El cliente con mas compras es: ',nombreMasCompras);
	writeln('El total de clientes que compraron solo productos en ofertas es de ',contOferta); 
End.
