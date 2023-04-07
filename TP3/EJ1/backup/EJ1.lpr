program Ej1;

var
  Arch : text;
  N, Nmax, ImparMin, i : integer;
  countMax : integer;

begin
  assign(Arch, 'C:\Usuarios\nicob\INGE\PROGRAMACION1\TP3\EJ1\text.txt');
  reset(Arch);

  while not eof(Arch) do
     begin
       read(Arch, N);
       Nmax := low(integer);
       ImparMin := high(integer);
       for i := N downto 1 do
       begin
         read(Arch, N);
         if N > Nmax then
            begin
               Nmax := N;
               countMax := 1;
            end
         else if N = Nmax then
            countMax := countMax + 1;
         if ((N mod 2) = 1) and (N < ImparMin) then
            ImparMin := N;
       end;
       writeln('El numero mas alto es: ', Nmax, ' y aparece ', countMax,' veces');

       if ImparMin <> high(integer) then
          writeln('El numero impar minimo es: ', ImparMin)
       else
          writeln('No hay un numero impar minimo');
       writeln();
     end;
  close(Arch);
  write('(ENTER para salir)'); readln();
end.

