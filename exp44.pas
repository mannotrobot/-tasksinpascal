program exp44;
{
  задача:
  - принять из stdin строку;
  - обработать сроку выбрав самую длинную последдовательность цифр;
  - вывести на экран последовальность;
}

procedure read_stdin_line;
var
    c: char;
    i: integer;
begin
    while not eoln do
    begin
        read(c);
        i := ord(c);
        if (i >= 48) and (i <= 57) then
            writeln(chr(i));
    end;
end;

begin
    read_stdin_line;
end.
