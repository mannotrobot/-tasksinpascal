program exp48;
{
 task:
   - get argument(namefile) command line;
   - read file and calc count string;
   - display number of lines;
}
function get_argument(): string;
begin
    {$I-}
    if paramcount < 1 then
    begin
        writeln('Please specify the file name...');
        halt(1);
    end;
    get_argument := paramstr(1)
end;

function get_read_text(var filename: string): integer;
var
    f    : text;
    count: integer;
     current_line : string;
begin
    {$I-}
    assign(f, filename);
    reset(f);
    count := 0;
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    while not seekeof(f) do
    begin
        readln(f, current_line);
        count := count + 1;
    end;
    close(f);
    get_read_text := count;
end;


var
    namefile : string;
begin;
    namefile := get_argument;
    writeln(get_read_text(namefile))
end.
