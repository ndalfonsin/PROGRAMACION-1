program EJ15;
(* A partir de un archivo de texto que contiene una secuencia de caracteres
terminados por un punto, informar:
           -cuantas palabras comienzan con la letra ingresada
           -cuantas palabras contienen la letra ingresada
           *)

var
  chV, palabra: string;
  ch, chI, exit: char;
  Arch: text;
  contL1, contL2: byte;
  finPalab, nuevaPalabra: boolean;

begin
  Assign(Arch, 'oraciones.txt');
  Reset(Arch);
  exit := 'S';


  writeln('Contador de caracteres');

  while exit<>'N' do
  begin
       contL1 := 0;
       contL2 := 0;
       finPalab := false;
       palabra := '';


       repeat
              writeln('Ingrese el caracter que desea buscar en el archivo de texto');
              writeln('!!!ATENCION, se distingue entre mayusculas y minusculas');
              readln(chV);
       until (length(chV) = 1);

       chI := chV[1];

       while not EOF(Arch) do
             begin
                  read(Arch, ch);

                  if (ch <> ' ')and(ch <> '.') then
                      palabra:= (palabra + ch)
                  else
                      finPalab := true;

                  if ch = chI then
                      contL2 := (contL2 + 1);

                   if (nuevaPalabra = true) and (palabra[1] = chI) then
                  begin
                      contL1 := (contL1 + 1);
                      nuevaPalabra := false;
                  end;

                  if finPalab = true then
                  begin
                      palabra := '';
                      finPalab := false;
                      nuevaPalabra := true;
                  end;
             end;

       writeln('La cantidad de palabras que empiezan con la letra "',chI,'" son: ',contL1);
       writeln('La cantidad de palabras que contienen la letra "',chI,'" son: ',contL2);
       writeln(' ');
       writeln('Desea continuar? [S/N]');
       readln(exit);
       exit := upcase(exit);
  end;

  readln();

end.
