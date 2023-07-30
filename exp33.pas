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
ok    - добавить очередь для изменения направления, если \
        очередь пуста менять радномно;
ok    - ограничить число перемещения 1000;
ok    - ограничить число ходов 10;
ok    - разместить в центре квадрат 3*3;
ok    - припопадание  * в квадрат, закончить игру.
ok    - вывести на экран YOU WIN;
ok    - в случаи оканчания ходов или перемещения закончить игру;
ok    - вывести на экран GAME OVER; 
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
        dirs  : array [0..9] of integer;
    end;

    coord = record
        x, y : integer;
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
    if queue.count + 1 > 10 then
    begin
        if queue.pos > 9 then
        begin
            queue.state := False;
        end
        else
        begin
            queue.state := True;
        end;
    end
    else
    begin
        queue.dirs[cur] := delta;
        queue.state := True;
        queue.count := queue.count + 1;
    end;
end;

procedure show_cube(var cube: object_game; var cubec: array of coord);
var
    i  : integer;
    j  : integer;
    obj: object_game;
    pos: integer;
begin
    pos := 0;
    obj := cube;
    for i:= 0 to 2 do
    begin
        for j:= 0 to 2 do
        begin
            cubec[pos].x := cube.x;
            cubec[pos].y := cube.y;
            show_object(cube);
            cube.x := cube.x + 1;
            pos := pos + 1; 
        end;
        cube.y := cube.y + 1;
        cube.x := cube.x - 3; 
    end;
    cube:= obj;
end;

function check(var obj: object_game;var cubec: array of coord ): boolean;
var
    cur  : coord;
    flag : boolean;
begin
    flag := False;
    for cur in cubec do
    begin
        if (cur.x = obj.x) and (cur.y = obj.y) then
            flag := True;
    end;
    check := flag;
end;

var
    star : object_game;
    code : integer;
    dirs : queue_dir;
    count: integer;
    flag : boolean;
    win  : boolean;
    cube : object_game;
    cubec: array [0..9] of coord;
begin
    clrscr;
    randomize;
    count := 0;
    cube.x := screenwidth div 2 - 2;
    cube.y := screenheight div 2 - 2;
    cube.symbol := '@';  
    star.x := 2;
    star.y := 2;
    star.symbol := '*';
    star.count := 0;
    star.direction := 1;
    flag := True;
    win := False;
    dirs.state := False;
    show_cube(cube, cubec);
    while flag do
    begin
       while not keypressed do
       begin
           if (count > 1000) or ((dirs.pos > 9) and dirs.state)  then
           begin
               flag := false;
               break;
           end;
           if check(star, cubec) then
           begin
               win := True;
               flag := False;
               break;
           end;
           gotoxy(1, 1);
           write('pos ', dirs.pos, ' ');
           write('шаги: ',1000 - count, ' ');
           write('ходы: ',10 - dirs.count, ' ');
           write('xy cube: ', cube.x , '|', cube.y, ' ');
           write('xy star: ', star.x, '|', star.y, ' ');
           gotoxy(1, 1);
           random_move(star, dirs);
           count := count + 1;
           if dirs.count = dirs.pos then
           begin
               dirs.state := False;
           end;
       end;
       if not flag then
       begin
           break;
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
    if win then
    begin
        clrscr;
        gotoxy(screenwidth div 2 - 7, screenheight div 2);
        textcolor(blue);
        write('YOU WIN');
        delay(3000);
    end
    else
    begin
        clrscr;
        gotoxy(screenwidth div 2 - 8, screenheight div 2);
        textcolor(red);
        write('GAME OVER');
        delay(3000);
    end;
    clrscr;
end.
