Program EsMayus;
(*
	Informar si un caracter ingresado es letra minuscula, mayuscula o un caracter especial
*)
var 
	ch: char;
	chEsp: boolean;
Begin
	writeln('Ingrese un caracter para determinar si es mayuscula, min, u otro caracter');
	readln(ch);
	chEsp:= (('-'<=ch) and (ch<='@')) or (('['<=ch) and (ch<='`')) or (('{'<=ch) and (ch<='ü'));
	
	if chEsp then
		writeln('Es un caracter de tipo especial o numerico')
	else if ('A'<=ch) and (ch<='Z') then
		writeln('Es un caracter en Mayuscula')
	else if ('a'<=ch) and (ch<='z') then
		writeln('Es un caracter en Minuscula');
	
	readln();
End.
	
