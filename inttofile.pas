program inttofile;
var
    f    : file of integer;
    digit: integer;
    name : string;
begin
    {$I-}
    name := paramstr(1);
    assign(f, name);
    rewrite(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', name);
        halt(1);
    end;
    while not seekeof do
    begin
        read(digit);
        write(f, digit);
    end;
    close(f);
    writeln('Close...');
end.
