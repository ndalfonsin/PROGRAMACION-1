Program Ej3;

function sumaN(N: integer):integer;
         var
           i:integer;

         begin
           sumaN:= 0;

           for i:=N downto 1 do
               sumaN:=(sumaN + i);
         End;

var
  N:integer;

begin
  repeat
    write('Ingrese un numero natural para obtener la suma: ');readln(N);
  until n>0 ;

  writeln('La suma de entre 0<',N,' es ',sumaN(N));
  readln();
end.
