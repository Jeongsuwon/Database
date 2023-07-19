set serveroutput on;

declare
v_Str varchar2(100); --변수선언

begin
    v_Str := '값 할당 ㅎㅇ';

    if 1= 2 then
        dbms_output.put_line('조건이 트루입니다' || v_Str);
    end if;
end;