Program Ej1;
//En una pintureria se necesita obtener el color gis mara. Se deben mezclar 9.5 litros de 
// Negro y 4.5 litros de blanco

//Tiene N litros de Negro, ¿Cuanto deberia mezclar de blanco?
//Tiene M litros de Blanco, ¿Cuanto deberia mezclar de negro?

Var
	tipo: char;
	cantI, cantC: real;

Const
	calq = 2.11;//Calculo de diferencia porcentual entre colores

Begin
	writeln('Calculo de litros para crear pintura Gris Mara');
	writeln('Va a partir de pintura Blanca(B) o Negra(N)?');
	readln(tipo); //Tipo B o N

	tipo := upcase(tipo);//Si es minuscula lo convierto en mayuscula
	writeln('Cuantos litros tiene de pintura?: ');
	readln(cantI);//Cantidad inicial
	
	//Calculo dependiendo de que color se parte
	if tipo='B' then
		cantC:= cantI/calq
	else
		cantC:= cantI*calq;

	
	writeln('Va a necesitar ',cantC:3:2,' litros, para generar un total de ',(cantI+cantC):3:2,' litros de Gris Mara');
	
	
	readln();
End.
