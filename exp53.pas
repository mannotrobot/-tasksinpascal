program exp53;
{
  задача:
  - получить три аргумента \
     имя файла для чтения;
     имя файла для записи строк;
     имя файла для записи чисел;
  - прочитать -- строки которые начинаются с пробела \
     записать в файл;
  - записать в файл длину  строк;
}

procedure create_file_text(var filename: string);
var
    f : text;
begin
    assign(f, filename);
    rewrite(f);
    close(f);
end;

procedure handler_write_string(var filename: string; value : char);
var
    filetext : text;
begin
    {$I-}
    assign(filetext, filename);
    append(filetext);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    write(filetext, value);
    close(filetext);
end;

procedure create_file_type(var filename: string);
var
    f : file of integer;
begin
    assign(f, filename);
    rewrite(f);
    close(f);
end;

procedure handler_write_type(var filename: string; value : integer; pos : integer);
var
    filetype : file of integer;
begin
    {$I-}
    assign(filetype, filename);
    reset(filetype);
    if IOresult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    seek(filetype, pos);
    write(filetype, value);
    close(filetype)
end;

procedure main_handler;
var
    fileread : text;
    symbol   : char;
    count    : integer;
    fname1   : string;
    fname2   : string;
    fname3   : string;
    pos      : integer;
begin
    {$I-}
    if paramcount <> 3 then
    begin
        writeln('Wrong count param...');
        halt;
    end;
    fname1 := paramstr(1);
    fname2 := paramstr(2);
    fname3 := paramstr(3);
    create_file_text(fname2);
    create_file_type(fname3);
    assign(fileread, fname1);
    reset(fileread);
    pos := 1;
    count := 0;
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', fname1);
        halt(1);
    end;
    while not eof(fileread) do
    begin
        read(fileread, symbol);
        writeln(ord(symbol));
        if symbol = #10 then
        begin
            while not eoln(fileread) do
            begin
                read(fileread, symbol);
                write(symbol);
                handler_write_string(fname2, symbol);
                count := count + 1;
            end;
            handler_write_string(fname2, #10); 
        end
        else
        begin
           while not eoln(fileread) do
           begin
               read(fileread, symbol);
               count := count + 1;
           end;
        end;
        handler_write_type(fname3, count, pos);
        pos := pos + 1;
        count := 1;
    end;
end;

begin
    main_handler;    
end.
