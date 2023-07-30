program exp32;
{
  задача(простоя консольная игра):
ok    - очистить экран;
ok    - изобразить *;
ok    - * движется с задержкой 1/10;
ok    - каждые 10 шагов меняет направ. движения;
ok    - при пересечение границы экрана перемежается \
      на противоположную сторону;
ok    - escape выход;
ok    - направление движения меняется под прямым углом;
ok    - изменение направления при нажатии клавиш;
      - добавить очередь для изменения направления, если \
        очередб пуста менять радномно;
}

uses
    crt;

procedure get_key(var code: integer);
var
    symbol : char;
begin
    symbol := readkey;
    if symbol = #0 then
    begin
        symbol := readkey;
        code := -(ord(symbol));
    end
    else
    begin
        code := ord(symbol)
    end
end;

type
    object_game = record
        x, y     : integer;
        symbol   : char;
        count    : integer;
        direction: integer;
    end;

    queue_dir = record
        state : boolean;
        count : integer;
        pos   : integer;
        dirs  : array [0..999] of integer;
    end;

procedure show_object(var obj: object_game);
begin
    gotoxy(obj.x, obj.y);
    write(obj.symbol);
    gotoxy(1, 1);
end;

procedure hide_symbol(x, y: integer);
begin
    delay(100);
    gotoxy(x, y);
    write(' ');
    gotoxy(1, 1);
end;

procedure move_object(var obj: object_game);
begin
    case obj.direction of
        0: obj.x := obj.x - 1;
        1: obj.x := obj.x + 1;
        2: obj.y := obj.y - 1;
        3: obj.y := obj.y + 1;
        end;
    if obj.x > screenwidth - 2 then
    begin
        obj.x := 2;
    end;
    if obj.x < 2  then
    begin
        obj.x := screenwidth - 2;
    end;
    if obj.y > screenheight - 2 then
    begin
        obj.y := 2;
    end;
    if obj.y < 2 then
    begin
        obj.y := screenheight - 2;   
    end;
    show_object(obj);
    hide_symbol(obj.x, obj.y);
end;

procedure update_xy(var obj: object_game; x, y: integer);
begin
    obj.x := obj.x + x;
    obj.y := obj.y + y;
end;

procedure turn(var obj: object_game);
begin
    case obj.direction of
        0: update_xy(obj, 1, 1);
        1: update_xy(obj, -1, 1);
        2: update_xy(obj, 1, 1 );
        3: update_xy(obj, 1, -1);
    end; 
end;

procedure random_move(var obj: object_game; var dirs: queue_dir);
var
    cur : integer;
begin
    obj.count:= obj.count + 1;
    if obj.count > 9 then
    begin
        obj.count := 0;
        if dirs.state then
        begin
            cur := dirs.pos;
            dirs.pos := dirs.pos + 1;
            obj.direction := dirs.dirs[cur];
            turn(obj);
            move_object(obj);
        end
        else
        begin
            obj.direction := random(4);
            turn(obj);
            move_object(obj);
        end;
    end
    else
    begin
        move_object(obj);
    end; 
end;

procedure set_direction(var obj : object_game; delta: integer);
begin
    obj.direction := delta;
    turn(obj);
end;

procedure add_dir(var queue: queue_dir; delta: integer);
var
    cur: integer;
begin
    cur := queue.count;
    queue.count := queue.count + 1;
    if queue.count + 1 > 999 then
    begin
        queue.state := False;
    end
    else
    begin
        queue.dirs[cur] := delta;
        queue.state := True;
    end;
end;

var
    star : object_game;
    code : integer;
    dirs : queue_dir;
begin
    clrscr;
    randomize;
    star.x := screenwidth div 2;
    star.y := screenheight div 2;
    star.symbol := '*';
    star.count := 0;
    star.direction := 1;
    while True do
    begin
       while not keypressed do
       begin
           gotoxy(1, 1);
           write(star.count);
           write(' | ходов осталось [ ',999 - dirs.count ,' ]');
           gotoxy(1, 1);
           random_move(star, dirs);
           if dirs.count = dirs.pos then
           begin
               dirs.state := False;
           end;
       end;
       get_key(code);
       case code of
           27 : break;
           -75: add_dir(dirs, 0);
           -77: add_dir(dirs, 1);
           -72: add_dir(dirs, 2);
           -80: add_dir(dirs, 3);
       end
    end;
    clrscr;
end.
