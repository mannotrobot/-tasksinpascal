program exp44;
{
  задача:
  - принять из stdin строку;
  - обработать сроку выбрав самую длинную последдовательность цифр;
  - вывести на экран последовальность;
}

type
    ptr = ^node;
    node = record
        data: char;
        next: ptr;
    end;

procedure init_queue(var head: ptr);
begin
    head := nil;
end;

procedure push_back(var head: ptr; n: char);
var
    tmp: ptr;
begin
    if head <> nil then
    begin
        tmp := @head^;
        while tmp^.next <> nil do
        begin
            tmp := tmp^.next;
        end;
        new(tmp^.next);
        tmp^.next^.data := n;
        tmp^.next^.next := nil
    end
    else
    begin
        new(head);
        head^.data := n;
        head^.next := nil
    end;
end;

function is_max(var max_len: integer; var j: integer): integer;
var
    choice : integer;
begin
    if j = max_len then
         choice := 1 
    else
    begin
         if j > max_len then
         begin
             choice := 2;
         end
         else
         begin
             choice := -1;
         end;
    end;
    is_max := choice;
end;

function is_digit(i: integer): boolean;
begin
     is_digit := (i >= 48) and (i <= 57)
end;

procedure add_new_seq(var head: ptr; j: integer; c: char);
begin
    while j > 0 do
    begin
        push_back(head, c);
        j := j - 1;
    end;
    push_back(head, ' ');
    j := 1;
end;

procedure create_new_queue(var head: ptr; j: integer; c: char);
begin
    init_queue(head);
    add_new_seq(head, j, c);
end;

procedure handler_stdin_line(var head: ptr);
var
    c: char;
    i: integer;
    j: integer;
    max_len : integer;
    prev_char: char;
    choice : integer;
begin
    max_len := 0;
    j := 1;
    prev_char := '*';
    flag := False;
    while not eoln do
    begin
        read(c);
        i := ord(c);
        if is_digit(i) and (prev_char = c) then
        begin
            j := j + 1;
        end;
        if (c <> prev_char) or eoln then
        begin
            choice := is_max(max_len, j);
            i := ord(prev_char);
            if is_digit(i) then
            begin
                case choice of
                    2: begin
                           max_len:= j;
                           create_new_queue(head, j, prev_char);
                       end;
                    1: begin
                           add_new_seq(head, j, prev_char);
                       end;
                    -1: continue
                end;
            end;
            j := 1;
        end;
        prev_char := c;
    end;
end;

var
    head: ptr;
begin
    handler_stdin_line(head);
    while head <> nil do
    begin
        write(head^.data);
        head := head^.next;
    end;
end.
