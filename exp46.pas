program exp46;
{
  задача:
ok  - получить аргумент командной строки;
ok  - создать файл с именем аргумента;
ok  - записать в файл текст;
}
const
    humpty =  'Humpty-Dumpty sat on a wall,' + #10 + 
              'Humpty-Dumpty had a great fall;'+ #10 +
              'All the kings horses, and all the kings men' + #10 +
              'Cannot put Humpty-Dumpty together again.'+#10;

var
    namefile : string;
    f        : text;
begin
    if paramcount = 1 then
    begin
        namefile := paramstr(1)+'.txt';
        assign(f, namefile);
        rewrite(f);
        write(f, humpty);
        close(f);
    end
    else
    begin
        writeln('sorry...write line name');
        writeln(paramcount);
    end;
end.
