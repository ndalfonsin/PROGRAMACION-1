Program ej15;

{A partir de un archivo de texto que contiene una secuencia de caracteres terminadas en punto
	a-Cuantas palabras comienzan con una letra ingresada por teclado
	b-Cuantas palabras contienen la letra ingresada por teclado}

var
	ch, chAnt, chUser: char;
	contPA, contPB: byte;
	arch: text;

Begin
	chAnt:= ' ';
	contPA:= 0;
	contPB:= 0;
	
	writeln('Ingrese el caracter que desea buscar');
	readln(chUser);

	Assign(arch, 'test.txt');
	reset(arch);
	read(arch, ch);

	while ch <> '.' do
		begin
			writeln(ch);

			if ((ch=chUser)and(chAnt=' ')) then
				begin				
					contPA:= contPA + 1;
					contPB:= contPB + 1;
				end
			else if (ch=chUser) then
				contPB:= contPB + 1;

			chAnt:= ch;
			read(arch, ch);				
		end;
				
	writeln('Hay ',contPA,' palabras que inician con ',chUser);
	writeln(contPB,' contienen a ',chUser);
	readln;
End.
	
