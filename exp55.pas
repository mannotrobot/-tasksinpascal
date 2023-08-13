program exp55;
{
  -задача:
    - принять три агрумента --
          имя файла  команда  [ иденфикатор ];
    - команды:
      - add    -> добавить в таблицу либо увеличить 
      - query  -> найти в таблице, вывести на экран;
      - list   -> вывести на экран всю таблицу;
    - формат записи:
          иденфикатор кол-во;
    - если файла, создать базу данных;
}

type
    item = record
        name : string;
        count: longint;
    end;

function get_params() : string;
var
    command : string;
begin
   if (paramcount < 2) or (paramcount > 3) then
   begin
       command := 'ERROR'; 
   end
   else
   begin
       command := paramstr(2);
       case command of
         'add'  : if paramcount < 3 then
                    command := 'ERROR';
         'query': if paramcount < 3 then
                    command := 'ERROR';
         'list':  if paramcount > 2 then
                    command := 'ERROR';
       else command:= 'WRONG COMMAND';
       end
   end;
   get_params := command;
end;

function get_pos(var filename, value: string; var new_item : item): integer;
var
    cur : item;
    f   : file of item;
    position : integer;
begin
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn0''t open file ', filename);
        halt(1);
    end;
    position := 0;
    while not eof(f) do
    begin
        read(f, cur);
        if cur.name = value then
        begin
            new_item.count := cur.count + 1;
            break
        end;
        position := position + 1;
    end;
    close(f);
    get_pos := position;
end;

procedure find_item(var arg : string);
var
   cur : item;
   pos : integer;
   filename : string;
   f : file of item;
begin
    filename := paramstr(1);
    pos := get_pos(filename, arg, cur);
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    seek(f, pos);
    read(f, cur);
    writeln(cur.name,' - ', cur.count);
    close(f);
end;

procedure get_list(var arg: string);
var
    cur : item;
    f   : file of item;
    filename : string;
begin
    {$I-}
    filename := arg;
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    while not eof(f) do
    begin
        read(f, cur);
        writeln(cur.name,' - ', cur.count);
    end;
    close(f);
end;

procedure add_item(var value: string);
var
    new_item : item;
    pos      : integer;
    f        : file of item;
    filename : string;
begin
    filename := paramstr(1);
    new_item.name := value;
    new_item.count := 1;
    pos := get_pos(filename, value, new_item);
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    seek(f, pos);
    write(f, new_item);
    close(f);
end;


procedure handler_command;
var
    command : string;
    arg     : string;
begin
    command := get_params;
    case command of
        'ERROR' : begin
                      writeln('Wrong count params...');
                      exit;
                  end;
        'WRONG COMMAND': begin
                             writeln('Wrong command...');
                             exit;   
                         end;
        'add'          : begin
                             arg := paramstr(3);
                             add_item(arg);
                         end;
        'query'        : begin
                             arg := paramstr(3);
                             find_item(arg);
                         end;
        'list'         : begin
                             arg := paramstr(1);
                             get_list(arg);
                         end;
    end;
end;

begin
    handler_command;
end.
