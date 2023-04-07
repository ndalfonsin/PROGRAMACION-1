program Ej2;

var
  n:integer;
  result: real;
begin
  writeln('Calculo de la N-esimo termino de la sucesion An = A1 + 3(n-1)');
  writeln('Ingrese el termino cual desea obtener de la sucesion');

  readln(n);

  result:= 1 + 3*(n-1);

  writeln(result:3:2);
  readln;

end.

