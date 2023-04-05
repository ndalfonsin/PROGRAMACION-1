program Ej3;

var
  hs, sbrut, snet: real;

const
  precioxhs = 200;
  cm = 0.11;
  prev = 0.05;

begin
  writeln('Calculo de sueldo bruto y neto en funcion de las horas trabajadas');
  writeln('Sueldo neto = sueldo bruto - (11% previcional + 5% cobertura medica)');
  writeln('Cuantas horas ha trabajado?');

  readln(hs);

  sbrut := hs * precioxhs;
  snet := sbrut - ( (sbrut * cm) + (sbrut * prev) );

  writeln('Su sueldo bruto es: $', sbrut:3:2);
  writeln('Su sueldo neto es: $', snet:3:2);

  readln;

end.

