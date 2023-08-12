program exp54;
{
  задача:
  - получить из командной строки имена файлов;
  - последний -- имя файла для записи;
  - в типизированых файлах посчитать кол-во чисел;
  - в типизированых файлах посчитать наимен. число;
  - в типизированых файлах посчитать наибольшое число;
}

uses
    sysutils;

type
    data = record
        count, min, max : integer;
    end;

procedure create_file_text(var filename: string);
var
    f: text;
begin
    assign(f, filename + '.txt');
    rewrite(f);
    close(f);
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
    writeln(filetext, filename);
    line := inttostr(value.count);
    write(filetext, ':');
    write(filetext, line);
    line := inttostr(value.min);
    write(filetext, ' | ' + line);
    line := inttostr(value.max);
    write(filetext, line);
    close(filetext);
end;

begin
    writeln(intToStr(1));
end.

