program Ej6;

(*
Dados 3 numeros enteros calcular cual es el mayor. Plantear 3 tipos de soluciones
-Alternativas secuenciales
-Alternativas anidadas con expresiones logicas compuestas
-Alternativas anidadas con expresiones logicas simples
*)

var
  numero1,numero2,numero3:byte;

begin
  //Ingreso de datos por el usuario
  writeln('Ingrese el primer numero: ');
  readln(numero1);
  writeln('Ingrese el segundo numero: ');
  readln(numero2);
  writeln('Ingrese el tercer numero: ');
  readln(numero3);

  //Alternativas secuenciales
  if (numero1<>numero2)or(numero1<>numero3) then
     begin
       if numero1>numero2 then
          begin
               if numero1>numero3 then
                  writeln('El numero ',numero1,' es el mayor de los ingresados');
          end;

       if numero2>numero1 then
          begin
               if numero2>numero3 then
                  writeln('El numero ',numero2,' es el mayor de los ingresados');
          end;

       if numero3>numero1 then
          begin
               if numero3>numero2 then
                  writeln('El numero ',numero3,' es el mayor de los ingresados');
          end;
     end
  else
      writeln('Los numeros ingresados son iguales');


  //Alternativas anidadas con expresiones logicas compuestas

  if ((numero1>numero2)and(numero1>numero3))and((numero1<>numero2)or(numero1<>numero3)) then
     writeln('El numero ',numero1,' es el mayor de los ingresados')
  else if ((numero2>numero1)and(numero2>numero3))and((numero1<>numero2)or(numero1<>numero3)) then
     writeln('El numero ',numero2,' es el mayor de los ingresados')
  else if ((numero3>numero1)and(numero3>numero2))and((numero1<>numero2)or(numero1<>numero3)) then
     writeln('El numero ',numero3,' es el mayor de los ingresados')
  else
     writeln('Los numeros ingresados son iguales');

  //Alternativas anidadas con expresiones logicas simples

  if (numero1<>numero2)or(numero1<>numero3) then
     begin
          if (numero1>numero2)and(numero1>numero3) then
               writeln('El numero ',numero1,' es el mayor de los ingresados')
          else if (numero2>numero1)and(numero2>numero3) then
               writeln('El numero ',numero2,' es el mayor de los ingresados')
          else if (numero3>numero1)and(numero3>numero2) then
               writeln('El numero ',numero3,' es el mayor de los ingresados');
     end
  else
      writeln('Los numeros ingresados son iguales');

  readln();
End.
