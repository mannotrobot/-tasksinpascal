program exp41;
{
    задача:
    - считать из stdin до eof числа типа longint;
    - вывести на экран те числа которые встречаются 3 раза;
}

type
    ptr = ^node;
    node = record
        data : longint;
        count: integer;
        next : ptr;
    end;
    linked_list = ptr;

procedure push(var lst: linked_list; n: longint);
var
    tmp  : ptr;
    count: integer; 
begin
    count := 1;
    if lst <> nil then
    begin
        tmp := @lst^;
        while tmp^.next <> nil do
        begin
            if tmp^.data = n then
            begin
                tmp^.count := tmp^.count + 1;
                count := tmp^.count;
            end;
            tmp := tmp^.next;
        end;
        if tmp^.data = n then
        begin
            tmp^.count := tmp^.count + 1;
            count := tmp^.count; 
        end;
        new(tmp^.next);
        tmp^.next^.next := nil;
        tmp^.next^.data := n;
        tmp^.next^.count:= count;
    end
    else
    begin
        new(lst);
        lst^.data := n;
        lst^.count:= 1;
    end
end;

procedure read_list(var lst: linked_list);
var
    tmp: ptr;
begin
    tmp := @lst^;
    while tmp <> nil do
    beginb
        if tmp^.count = 3 then
        begin
             writeln(tmp^.data)
        end;
        tmp := tmp^.next;
    end;
end;

var
    n: longint;
    lst : linked_list;
begin
    while not eof do
    begin
        read(n);
        push(lst, n);
    end;
    read_list(lst);
end.
