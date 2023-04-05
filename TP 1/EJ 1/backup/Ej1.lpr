Program Ej1;

var
  tipo:char;
  cant:real;

const
  calq = 2.11;

begin
  Writeln('Calcular la cantidad de pintura blanca o negra necesaria para obtener color Gris Mara');
  Writeln('Ingrese el color del que desea partir: (B)->Blanco o (N)->Negro');
  Readln(tipo);

  tipo:=Upcase(tipo);

  if (tipo <> 'B') and (tipo <> 'N') then
     Writeln('Los Datos ingresados no son validos')
  else
    begin
     Writeln('Ingrese la cantidad de pintura que se tiene');
     Readln(cant);

     if tipo = 'B' then
        cant := cant * calq
     else
        cant := cant / calq;
    end;

  writeln(cant:3:2);
  readln;
end.
