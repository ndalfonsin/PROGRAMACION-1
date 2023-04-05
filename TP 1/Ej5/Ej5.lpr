program Ej5;
var
   N, M:real;
   cantB:integer;
const
   areaB = 0.25*0.25;
begin
  writeln('Calculo de baldosas para una superficie N x M');
  writeln('Maximo del terreno 10 x 30 // 30 x 10');
  writeln ('Ingrese la longitud del primer lado de la superficie');
  readln(N);
  writeln('Ingrese la longitud del segundo lado de la superficie');
  readln(M);

  if ((N<=10) and (M<=30)) or ((N<=30) and (M<=10)) then
     begin
          cantB := trunc((N * M) / areaB);
          writeln('Necesitara ',CantB,' baldosas para cubrir su superficie de ',N:3:2,' x ',M:3:2);
          readln();
     end
  else
      writeln('Los datos ingresados no son validos');
      readln();
end.

