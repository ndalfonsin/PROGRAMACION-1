Program parabola;

{Dada la ecuacion de una parabola y=ax²+bx+c escribir un programa mediante un menu de opciones interativo:
	-Encontrar el eje de simetria sabiendo que x=-b/(2.a) y si esyto representa un minimo o un maximo
	-Informar hacia donde es abierta la parabola
	-Calcular y mostrar las raices, informar en caso que no existan. Para ello se debe analizar si el discriminante es mayor, menor o igual a cero.
	-Dado un conjunto de valores de x informar su imagen}

Uses
	Crt;

{Procedimiento de ingreso de datos}
Procedure ingresoDatos(var a,b,c:real);
	Begin
		ClrScr;		
		writeln('La formula a ingresar es: y=ax²+bx+c');
		write('Ingrese a: ');readln(a);
		write('Ingrese b: ');readln(b);
		write('Ingrese c: ');readln(c);
	End;

{Procedimiento de muestra del menu}
Procedure menu(a,b,c:real);
	Begin
		ClrScr;	
		writeln('Calculadora de parabolas');
		writeln('Su formula: ',a:1:1,'x²+',b:1:1,'x+',c:1:1);
		writeln('1: Eje de simetria'); {listo}
		writeln('2: Sentido de la parabola');
		writeln('3: Raices');
		writeln('4: Imagen a partir de x'); {listo}
		writeln('0: Salir');
	End;

{Funcion para calcular el eje de simetria de una parabola}
Function simetria(a,b:real):real;
	Begin
		simetria:= -b/(2*a);
	End;

{Funcion para calcular la imagen de una ecuacion a partir de x}
Function imagen(x:integer; a,b,c:real):real;
	begin
		imagen:= ((a*(sqr(x)))+(b*x)+c)
	end;

{Procedimiento para obtener valor de x y mostrar el return de la funcion "imagen"}
Procedure muestraImagen(a,b,c:real);
	var
		x: integer; {!!!- x tendria que ser variable global?}
	begin
		ClrScr;
		write('Ingrese el valor de x: ');readln(x);
		writeln('La imagen de x=',x,' es: ',imagen(x, a, b, c):2:2);
	end;

{Programa principal | Aqui se realiza la ejecucion de todo el programa}
Procedure main(a,b,c:real; ctl:byte);
	Begin {!!! - Esta bien ejecutar todos los modulos en un procedimiento main?}
		repeat {!!! - Esta bien usar un repeat?}			
			menu(a,b,c);
			write('Ingrese su opcion: ');readln(ctl);
			ClrScr;
			case ctl of					
					1: writeln('El eje de simetria se encuentra en x=',simetria(a,b):2:1);
					4: muestraImagen(a,b,c);
			end;
		writeln;
		if ctl <> 0 then
			Begin				
				write('Presione ENTER para continuar');readln;
			End;
		until (ctl = 0);
	End;

{Seccion declarativa - Variables globales}
Var
	ctl: byte;
	a, b, c: real;

{Seccion ejecutable}
Begin
	{Declaracion generica de variables}
	a:=0;
	b:=0;
	c:=0;
	ctl:= 0;

	{!!!- Deberia ingreso datos estar en el main? lo diferencio para que las variables sean globales
	y asi pasarlas a cada funcion o procedimiento que las necesite}

	ingresoDatos(a,b,c);{Ingreso de datos}
	main(a,b,c,ctl);{Ejecucion del programa principal}
End.
