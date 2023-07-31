program exp46;
{
  задача:
    - получить аргумент командной строки;
    - создать файл с именем аргумента;
    - записать в файл текст;
}
const
    humpty =  'Humpty-Dumpty sat on a wall,' + #10 + 
              'Humpty-Dumpty had a great fall;'+ #10 +
              'All the kings horses, and all the kings men' + #10 +
              'Cannot put Humpty-Dumpty together again.';
begin
    writeln(humpty);
end.
