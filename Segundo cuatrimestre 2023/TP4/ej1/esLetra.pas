Program esLetra;
{Desarrollar una funcion booleana que dado un caracter diga si es letra o no}

Function esLetra(ch:char):boolean;
    begin
        if ((ch>'A')and(ch<'Z') or (ch>'a')and(ch<'z')) then
            esLetra:= True
        else
            esLetra:= False;
    end;

var
    ch: char;

begin
    write('ingrese una letra o caracter: ');readln(ch);
    
    if esLetra(ch) then 
        writeln('Es una letra')
    else
        writeln('Es un caracter especial');
end.