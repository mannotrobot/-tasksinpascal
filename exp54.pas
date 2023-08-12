program exp54;
{
  задача:
ok  - получить из командной строки имена файлов;
ok  - последний -- имя файла для записи;
ok  - в типизированых файлах посчитать кол-во чисел;
ok  - в типизированых файлах посчитать наимен. число;
ok  - в типизированых файлах посчитать наибольшое число;
ok  - записать полученные данные в файл;
}

uses
    sysutils;

type
    data = record
        count, min, max : integer;
        name : string;
    end;

procedure create_file_text(var filename: string);
var
    f: text;
begin
    assign(f, filename);
    rewrite(f);
    close(f);
end;

function get_count(var filename: string) : integer;
var
    f : file of integer;
    count : integer;
begin
    {$I-}
    count := 0;
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    while not eof(f) do
    begin
        seek(f, count);
        count:= count + 1;
    end;
    close(f);
    get_count:= count - 1;
end;

function get_min(var filename: string): integer;
var 
    f   : file of integer;
    min : integer;
    next: integer;
begin
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    read(f, min);
    while not eof(f) do
    begin
        read(f, next);
        if next < min then
        begin
            min := next;
        end; 
    end;
    close(f);
    get_min := min;
end;
 

function get_max(var filename: string): integer;
var 
    f   : file of integer;
    max : integer;
    next: integer;
begin
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    read(f, max);
    while not eof(f) do
    begin
        read(f, next);
        if next > max then
        begin
            max := next;
        end; 
    end;
    close(f);
    get_max := max;
end;

function get_data(var filename: string) : data;
var
    value : data;
begin
    value.name := filename;
    value.count := get_count(filename);
    value.min := get_min(filename);
    value.max := get_max(filename);
    get_data:= value;
end;

procedure handler_write(var filename: string; var value: data);
var
    filetext : text;
    line     : string;
begin
    {$I-}
    assign(filetext, filename);
    append(filetext);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    line := inttostr(value.count);
    write(filetext, 'filename: ' + value.name + '|');
    write(filetext, ' count: ' + line);
    line := inttostr(value.min);
    write(filetext, '| min: ' + line);
    line := inttostr(value.max);
    write(filetext, '| max: ' + line);
    write(filetext, #10, #13);
    close(filetext);
end;

procedure handler_params(var filename: string);
var
    count_params: integer;
    value       : data;
    name        : string;
begin
    count_params := 1;
    while count_params <= paramcount - 1 do
    begin
        name := paramstr(count_params) + '.bin';
        value := get_data(name);
        handler_write(filename, value);
        count_params := count_params + 1;
    end;
end;

var
    filename : string;
begin
    filename := paramstr(paramcount) + '.txt';
    create_file_text(filename);
    handler_params(filename);
  
end.

