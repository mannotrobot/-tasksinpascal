program exp56;
{
  -задача:
    - написать программу, которая анализирует \
     два файла из задачи 255;
    - создать третий файл с обощенными данными; 
}

type
    item = record
        name : string;
        count: longint;
    end;
    cursor = ^node;
    node = record
        data: item;
        next: cursor;
    end;


procedure push(var head: cursor; var value: item);
var
    tmp : cursor;
begin
    new(tmp);
    tmp^.data := value;
    tmp^.next := head;
    head := tmp;
end;

function create_linked_list(var filename: string) : cursor;
var
    value  : item;
    head   : cursor;
    f      : file of item;
begin
    head := nil;
    {$I-}
    assign(f, filename);
    reset(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    while not eof(f) do
    begin
        read(f, value);
        push(head, value);
    end;
    close(f);
    create_linked_list := head; 
end;

function check_and_update(var value: item; var cur : cursor): boolean;
var
    current : item;
    flag    : boolean;
begin
    flag := False;
    while cur <> nil do
    begin
        current := cur^.data;
        if current.name = value.name then
        begin
             flag := True;
             value.count := value.count + current.count;
             break;
        end;
        cur := cur^.next;
    end;
    check_and_update := flag;
end;

function union_linked_list(var first, second: cursor) : cursor;
var
    new_list : cursor;
    item_one : item;
    item_two : item;
    flag     : boolean;
    c        : cursor;
    o        : cursor;
begin
    new_list := nil;
    o := first;
    while first <> nil do
    begin
        c := second;
        item_one := first^.data;
        check_and_update(item_one, c);
        push(new_list, item_one);
        first := first^.next;
    end;

    while second <> nil do
    begin
        item_two := second^.data;
        c := o;
        flag := check_and_update(item_two, c);
        if not flag then
        begin
            push(new_list, item_two);
        end;
        second := second^.next;
    end;
    union_linked_list := new_list;
end;

procedure create_file(var head: cursor);
var
    f       : file of item;
    value   : item;
    filename: string;
begin
    filename := paramstr(3);
    {$I-}
    assign(f, filename);
    rewrite(f);
    if IOResult <> 0 then
    begin
        writeln('Couldn''t open file ', filename);
        halt(1);
    end;
    while head <> nil do
    begin
        value := head^.data;
        write(f, value);
        head := head^.next;
    end;
    close(f);
end;

var
    one      : string;
    two      : string;
    first    : cursor;
    second   : cursor;
    head     : cursor;
  
begin 
    one := paramstr(1);
    two := paramstr(2);
    first := create_linked_list(one);
    second := create_linked_list(two);
    head := union_linked_list(first, second);
    create_file(head);
end.
