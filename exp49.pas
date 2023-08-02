program exp49;
{
  задача:
ok  - из командной строки получить имя файла;
ok  - считать с потока ввода текст;
ok  - записать в файл;
}
function get_namefile(): string;
begin
   {$I-}
   if paramcount < 1 then
   begin
       writeln('Please specify the file name...');
       halt(1)
   end;
   get_namefile := paramstr(1)
end;

function get_string(): string;
var
    line  : string;
    symbol: char;
begin
    line := '';
    while True do
    begin
        read(symbol);
        if symbol = #10 then
        begin
            break
        end;
        line := line + symbol;
    end;
    get_string := line;
end;

function handler(var filename: string): integer;
var
    f   : text;
    line: string;
begin
    {$I-}
    assign(f, filename);
    rewrite(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file', filename);
        halt(1)
    end;
    while not seekeof do
    begin
        line := get_string;
        writeln(f, line);
    end;
    close(f);
    handler := 1;
end;
var
    filename : string;
    result : integer;
begin
    filename := get_namefile;
    result := handler(filename);
    writeln(result);
end.
