program exp47;
{
task:
ok  - get argument from command line;
ok  - read file;
ok  - to bring out on display; 
}
procedure get_argument(var namefile: string);
begin
    {$I-}
    if paramcount < 1 then
    begin
        writeln('Please specify the file name...');
        halt(1)
    end;
    namefile := paramstr(1)
end;

function get_text(var filename: string): string;
var
    f        : text;
    cur_line : string;
    full_text: string;
begin
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    full_text := ''; 
    while not SeekEOf(f) do
    begin
        readln(f, cur_line);
        if length(full_text) > 1 then
        begin
            full_text := full_text + #10 + cur_line;
        end
        else
        begin
            full_text := cur_line;
        end
    end;
    close(f);
    get_text := full_text;
end;

var
    filename : string;
    current_text : string;
begin
    get_argument(filename);
    current_text := get_text(filename);
    writeln(current_text)
end.
