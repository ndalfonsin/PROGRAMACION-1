program Ej3;

(* Dados N numeros enteros informar cuantas veces un numero supera al anterior *)

Var
  N, NAnt, contN: 0..999;
  Arch : text;

begin
  assign(Arch, 'C:\Users\nicob\INGE\PROGRAMACION1\TP3\EJ3\numeros.txt');
  reset(Arch);

  //Inicializo en el max valor para que en la primera interaccion no ingrese al if
  NAnt:=999;
  contN:=0;

  while not EOF(Arch)do
        begin
          read(Arch,N);

          //Condicion para sumar 1 al contador sii N>NAnt
          if N>NAnt then
             contN:=(contN + 1);

          NAnt:=N;
        end;
  Writeln('Un numero supero a su antecesor un total de: ',contN:3);
  Readln();
end.
