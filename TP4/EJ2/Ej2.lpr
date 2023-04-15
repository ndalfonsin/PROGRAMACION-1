program Ej2;

function calcF(N: integer):integer;
    var
       i:integer;

    begin
      calcF:=1;

      for i := N downto 1 do
          calcF:= (calcF * i);
    end;

var
   N:integer;

begin
  repeat
    write('Ingrese el numero del que desea sacar el factorial: '); readln(N);
  until N>=0;

  if N = 0 then
      writeln(N,'! = 1')
  else
      Writeln(N,'! = ',calcF(N));
  readln;
end.
