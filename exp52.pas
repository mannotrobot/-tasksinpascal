program exp52;
{
  задача:
ok  - получить имена файлов из командной строки;
ok  - прочитать файлы;
ok  - найти самые длинные строки в файле;
ok  - найти самую длинную строку;
}

type
     line = record
         line : string;
         len  : longint;
         fname: string;
     end;

function get_len_str(var s : string) : longint;
begin
    get_len_str := length(s);
end;

function get_longest_line(var filename: string): line;
var
    f        : text;
    len      : longint;
    cur_line : string;
    cur_len  : longint;
    totalline: line;  
begin
    {$I-}
    assign(f, filename);
    reset(f);
    totalline.line := '';
    totalline.len  := -1;
    totalline.fname:= filename;
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    len := 0;
    while not seekeof(f) do 
    begin
        readln(f, cur_line);
        cur_len := get_len_str(cur_line);
        if cur_len > len then
        begin
            len := cur_len;
            totalline.line := cur_line;
            totalline.len := len;  
        end; 
    end;
    close(f);
    get_longest_line := totalline; 
end;

procedure handler_args;
var
    count   : integer;
    mostline: line;
    cur     : line;
    name    : string;
begin
    {$I-}
    if paramcount < 1 then
    begin
        writeln('Please specify the file names');
        halt(1);
    end;
    count := 1;
    mostline.line := '';
    mostline.len := 0;
    mostline.fname := '';
    while count <= paramcount do
    begin
        name := paramstr(count);
        cur := get_longest_line(name);
        if cur.len > mostline.len then
        begin
            mostline := cur;
        end;
        writeln('***********************');
        writeln('FILENAME: ' + cur.fname);
        writeln('STRING: ' + cur.line);
        writeln('LENGTH: ', cur.len);
        writeln('***********************');
        count := count + 1;
    end;
    writeln('MOST STRING IN FILENAME: ' + mostline.fname);
    writeln('STRING: ' + mostline.line);
    writeln('LENGTH: ', mostline.len);
end;

begin
    handler_args;
end.
