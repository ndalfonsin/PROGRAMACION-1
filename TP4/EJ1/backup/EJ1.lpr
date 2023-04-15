Program EJ1;

Function esLetra(ch : char):boolean;
         begin
              ch:= upcase(ch);
              esLetra:= (ch >= 'A') and (ch<='Z');
         end;

var
  caracter:char;

begin
  repeat
    write('Ingrese un caracter: '); Readln(caracter);
  until caracter <> '' ;

  if esLetra(caracter) then
     writeln('Es un caracter')
  else
     writeln('No es un caracter');

  readln;
end;
