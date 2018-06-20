unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.DFM}

procedure TForm5.FormShow(Sender: TObject);
begin
label2.caption:='Autor:'+#13+'Przemys³aw Wiecheæ'+#13#13+'Adres:'+#13+
'os. Or³a Bia³ego 52/11'+#13+'61-251 Poznañ'+#13+'Polska'+#13#13+'Wykonane w Delphi 2.0';
end;

procedure TForm5.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if (Button= mbRight) and (ssShift in Shift) then
Application.MessageBox(PChar('Piramida Faraona'+#13#13+'Pomys³'+#13+'Przemys³aw Wiecheæ'+#13#13+
'Programowanie'+#13+'Przemys³aw Wiecheæ'+#13#13+'Grafika'+#13+'Przemys³aw Wiecheæ'+#13+'Nieznani mi ludzie'+#13#13+
'DŸwiêki'+#13+'Przemys³aw Wiecheæ'+#13#13'Adres'+#13+'Przemys³aw Wiecheæ'+#13+
'os. Or³a Bia³ego 52/11'+#13+'61-251 Poznañ'+#13+'Polska'),'Autorzy',mb_OK+mb_iconinformation);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
form5.close;
end;

end.
 