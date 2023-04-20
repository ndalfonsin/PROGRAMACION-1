program resolucionPorCramer;

(* Calcular la solucion por determinante de una matriz cuadrada de 2x2

Metodo de cramer

Ax + By = C
Dx + Ey = F

x = (CE - BF) / (AE - BD)
y = (AF - CD) / (AE - BD)


Para la resolucion guardare las ecuaciones en un array de A a F y
separare la resolucion de x e y en dos funciones, para ultimamente ser unidas
en un procedimiento.


FORMATO DEL ARRAY                          ||  Dx + Ey = F
|   |   |   |   |   |   |
  A   B   C   D   E   F
*)

type
  VRl = Array['A'..'F'] of real;

var
  ec:VRl;
  X,Y: real;
  ch:char;

function Xres(ec:VRl):real;
         begin
              Xres:=((ec['C']*ec['E'])-(ec['B']*ec['F']))/((ec['A']*ec['E'])-(ec['B']*ec['D']));
         end;

function Yres(ec:VRl):real;
         begin
              Yres:=((ec['A']*ec['F'])-(ec['C']*ec['D']))/((ec['A']*ec['E'])-(ec['B']*ec['D']));
         end;

procedure result(ec:VRl);
         begin
              writeln('X = ',Xres(ec):2:1);
              writeln('Y = ',Yres(ec):2:1);
         end;


begin
  repeat
        writeln('Ingrese su primer ecuacion bajo el siguiente formato:');
        writeln('Ax + By = C');

        write('A: ');readln(ec['A']);
        write('B: ');readln(ec['B']);
        write('C: ');readln(ec['C']);
        writeln;
        writeln('Ha ingresado: ',ec['A']:2:1,' + ',ec['B']:2:1,' = ',ec['C']:2:1);
        writeln;
        write('Es correcto? [S/N]'); readln(ch);
        ch:=upcase(ch);
        writeln;

  until ch <> 'N';

  repeat
        writeln('Ingrese su primer ecuacion bajo el siguiente formato:');
        writeln('Ax + By = C');

        write('D: ');readln(ec['D']);
        write('E: ');readln(ec['E']);
        write('F: ');readln(ec['F']);
        writeln;
        writeln('Ha ingresado: ',ec['D']:2:1,' + ',ec['E']:2:1,' = ',ec['F']:2:1);
        writeln;
        write('Es correcto? [S/N]'); readln(ch);
        ch:=upcase(ch);

  until ch <> 'N';

  writeln;
  writeln;

  result(ec);

  readln;

end.

