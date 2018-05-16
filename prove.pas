unit prove;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  TIncodeMes = array of Integer;
  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    procedure Decode(Sender: TObject);
    procedure Crypt(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    FMes: TIncodeMes;
  public

  end;

var
  Form2: TForm2;
  i,n:Integer;

implementation

{$R *.lfm}

{ TForm2 }

function Encrypt(s: string; e:integer): TIncodeMes;
var
  res,j: Integer;
begin
  SetLength(result, length(s));
  for i := 0 to Length(s) - 1 do
  begin
    res:=1;
    for j:=1 to e do  // возведение в степень
      res:=(res*ord(s[i + 1])) mod n;
    result[i] := res;
  end;
end;

procedure TForm2.Crypt(Sender: TObject);
var
  e: Integer;
begin
  n := StrToIntDef(Edit3.Text, 697);
  e := StrToIntDef(Edit2.Text, 7);
  FMes := Encrypt(Memo1.Lines.Text, e);
  for i := 0 to High(FMes) do
    Memo2.Lines.Append(IntToStr(FMes[i]));
end;

procedure TForm2.Memo1Change(Sender: TObject);
begin

end;


function Decrypt(Arr: array of integer; e:Integer): string;
var
  res,j:Integer;
begin
  SetLength(Result, Length(Arr));
  for i := 0 to Length(Arr) - 1 do
  begin
    res:=1;
    for j:=1 to e do  // возведение в степень
      res:=(res*arr[i]) mod n;
    result[i + 1] := chr(res);
  end;
end;

//Дешифровка сообщения

procedure TForm2.Decode(Sender: TObject);
var
  d: Integer;
  s: String;
begin
  d := StrToIntDef(Edit1.Text, 183);
  n := StrToIntDef(Edit3.Text, 697);
  s := Decrypt(FMes,d);
  Memo3.Lines.Add(s)
end;

end.

