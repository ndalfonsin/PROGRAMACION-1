Program Ej4;

(* Ingresar N numeros enteros (ordenados de forma descendente) e informar
cual es la maxima diferencia entre pares de numeros
     Ej: (25 19 11 9 3 -3), la max diferencia es 8 del en la posicion 2 y 3
*)

Uses
    SysUtils;
var
  Ncad : string;
  N, Nant : integer;
  i, iPar, diff, diffAnt, diffM : byte;
  Arch : text;

begin
  Assign(Arch, 'C:\Users\nicob\INGE\PROGRAMACION1\TP3\EJ4\numeros.txt');
  Reset(Arch);

  NAnt := 0;
  i := 0;
  iPar := 0;
  diff := 0;
  diffAnt := 0;
  diffM :=0;


  while not EOF(Arch) do
        begin
          read(Arch, Ncad);

          N := StrToInt(Ncad);

          i := (i+1);

          if i<>1 then
             diff := (N-Nant);

          if diff > diffAnt then
             begin
                  diffM := diff;
                  iPar := i;
             end;

          Nant := N;
          diffAnt := diff;
        end;

  writeln('La maxima diferencia entre numeros consecutivos es: ',diffM);
  writeln('Se encuentran en la posicion ',iPar,' y ',(Ipar+1));
  readln();
end.

