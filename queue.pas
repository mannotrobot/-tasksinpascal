program queueone;
{
    реализация очереди на освнове односвязного списка
}

type
    qpointer = ^item;
    item = record
        data: longint;
        next: qpointer;
    end;
    queue = record
        first, last: qpointer;
    end;
procedure qinit(var q: queue);
{процедура инициализации очереди}
begin
    q.first := nil;
    q.last := nil;
end;

procedure qput(var q: queue; n: longint);
{процедура добавления нового элемента в очеред}
begin
    if q.first = nil then
    begin
        new(q.first);
        q.last := q.first
    end
    else
    begin
        new(q.last^.next);
        q.last := q.last^.next
    end;
    q.last^.data := n;
    q.last^.next := nil;
end;

procedure qget(var q: queue; var n: longint);
{процедура изъятия элемента из очереди}
var
    tmp : qpointer;
begin
    n := q.first^.data;
    tmp := q.first;
    q.first := q.first^.next;
    if q.first = nil then
        q.last := nil;
    dispose(tmp);
end;

function isempty(var q: queue): boolean;
{функция проверки очереди}
begin
    isempty := q.first = nil;
end;

var
    q : queue;
    n : longint;
begin
    qinit(q);
    while not seekeof do
    begin
        read(n);
        qput(q, n);
    end;
    while not isempty(q) do
    begin
        qget(q, n);
        writeln(n);
    end;
end.





