Program palabras;

{A partir de un archivo de texto que contiene palabras separadas entre si por uno o mas espacios desarrollar un programa para:
	-Mostrar la palabra con mas cantidad de vocales del texto.
	-Grabar en un texto de salida las palabras con mas de 4 letras pero escritas al revez
	-Contar cuantas son palindromas}

var
	ch, aux: char;
	contVocal: byte;
	palabra: string;
	ArchE, ArchS: text;
begin
	Assign(ArchE, 'palabras.txt');
	Reset(ArchE);
	Assign(ArchS, 'salida.txt');
	rewrite(ArchS);

	while not EOF(ArchE) do
		begin
			read(ArchE, ch);
			palabra:= '';

			while ch <> ' ' do
				begin
					palabra:= palabra + ch;
					read(ArchE);
				end;

		end;
end.
