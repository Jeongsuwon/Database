set serveroutput on;

declare
v_Str varchar2(100); --��������

begin
    v_Str := '�� �Ҵ� ����';

    if 1= 2 then
        dbms_output.put_line('������ Ʈ���Դϴ�' || v_Str);
    end if;
end;