#Funcion de busqueda

    Function Busqueda(vector: TV; J:byte; busqueda: string):byte;
        var
            i: byte;
        begin
            i:= 1;
            while (vector[i] <> busqueda)and(i<=J+1) do
                begin
                    i:= i + 1;
                end;
            
            if i=J+1 then
                Busqueda:= 0
            else
                Busqueda:= i;
        end;

Busqueda(pepito, chanchito, feliz);

    A B 

    repeat
        writeln(jnngkernkrg);readln(variable);
        variable:= upcase(variable);
    until (variable='A')or(variable='B');