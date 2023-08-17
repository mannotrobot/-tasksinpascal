program p;
{
    задача написать двусвязный список;
}

type
     pp = ^node;
     node = record
         data: integer;
         prev, next: pp;
     end;
     linked_lst = pp;

procedure init_linked(var lst: linked_lst);
begin
    lst := nil;
end;

procedure frontpush(var lst: linked_lst; n: integer);
var
    tmp: pp;
begin
    new(tmp);
    tmp^.data := n;
    tmp^.next := lst;
    tmp^.prev := nil;
    if lst <> nil then
    begin
        lst^.prev := tmp;
    end;
    lst := tmp;
end;

procedure backpush(var lst: linked_lst; n: integer);
var
    tmp : pp;
begin
    if lst <> nil then
    begin
        tmp := @lst^;
        while tmp^.next <> nil do
        begin
            tmp := tmp^.next;
        end;
        new(tmp^.next);
        tmp^.next^.data := n;
        tmp^.next^.next := nil;
        tmp^.next^.prev := tmp;
    end
    else
    begin
        new(lst);
        lst^.data := n;
        lst^.next := nil;
        lst^.prev  := nil;
    end;
end;

procedure list_pass(var lst: linked_lst);
var
    head : pp;
begin
    head := @lst^;
    while head <> nil do
    begin
        writeln(head^.data);
        head := head^.next;
        if head^.next = nil then
        begin
            writeln(head^.data);
            break;
        end;
    end;
    while head <> nil do
    begin
        writeln(head^.data);
        head := head^.prev;
    end;
    dispose(head);
end;

var
    lst : linked_lst;
    n   : integer; 
begin
    init_linked(lst);
    while not seekeof do
    begin
        read(n);
        if n < 0 then
        begin
            frontpush(lst, n)
        end
        else
        begin
            backpush(lst, n)
        end
    end;
    list_pass(lst);
end.

