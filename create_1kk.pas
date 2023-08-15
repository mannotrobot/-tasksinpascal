program kk;
{
    задача:
      -написать программу, которая создает файл в 1кк записей;
}

type
    item = record
        name : string;
        count: longint;
    end;

const
    COUNT = 1000000;
    AZ    = 65;

function get_item() : item;
var
    value : item;
    symbol: char;
    name  : string;
    i     : integer;
    j     : integer;
begin
    name := '';
    for i := 0 to 5 do
    begin
        j := random(25);
        symbol := chr(AZ + j);
        name := name + symbol;
    end;
    value.name := name;
    value.count := 1;
    get_item := value;
end;

procedure create(var filename: string);
var
    f    : file of item;
    value: item;
    i    : int64;
begin
     {$I-}
     assign(f, filename);
     rewrite(f);
     if IOResult <> 0 then
     begin
         writeln('Couldn''t open file ', filename);
         halt(1);
     end;
     i := 0;
     while i <= COUNT do
     begin
         value := get_item;
         write(f, value);
         i := i + 1;
     end;
     close(f);
end;
var
    filename : string;
begin
     randomize;
     filename := paramstr(1);
     create(filename);
end.
