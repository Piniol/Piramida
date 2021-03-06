unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, INIFiles, StdCtrls, MMSystem;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    NowaGra1: TMenuItem;
    Pauza1: TMenuItem;
    NajlepszeWyniki1: TMenuItem;
    N1: TMenuItem;
    Wyjcie1: TMenuItem;
    Ustawienia1: TMenuItem;
    OdtwarzajDwiki1: TMenuItem;
    Pomoc1: TMenuItem;
    Informacje1: TMenuItem;
    OProgramie1: TMenuItem;
    Podzikowania1: TMenuItem;
    Pole: TImage;
    Poziom1: TMenuItem;
    atwy1: TMenuItem;
    redni1: TMenuItem;
    Trudny1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    N2: TMenuItem;
    Zakocz1: TMenuItem;
    procedure FormPaint(Sender: TObject);
    procedure NowaGra1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure atwy1Click(Sender: TObject);
    procedure redni1Click(Sender: TObject);
    procedure Trudny1Click(Sender: TObject);
    procedure OdtwarzajDwiki1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Wyjcie1Click(Sender: TObject);
    procedure Pauza1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Koniec(Sender: TObject);
    procedure Zakocz1Click(Sender: TObject);
    procedure NajlepszeWyniki1Click(Sender: TObject);
    procedure Informacje1Click(Sender: TObject);
    procedure Podzikowania1Click(Sender: TObject);
    procedure OProgramie1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tablica: array[1..9,1..3] of integer;
  pion: array[1..9] of integer = (100,125,150,175,200,225,250,275,300);
  poziom: array[1..3] of integer = (6,151,295);
  ruchy,slupek,pozx,level,sound,sek0,sek,min,godz,a,b: integer;
  chwycony,pauza: boolean;

const nazwa='Piramida Faraona 1.0 - Freeware';

implementation

uses Unit3, Unit2, Unit4, Unit5;

{$R *.DFM}

procedure TForm1.FormPaint(Sender: TObject);
var y,x:integer;
    bmp:tbitmap;
begin
canvas.brush.style:=bssolid;
canvas.pen.color:=$003CBADF;
canvas.brush.color:=$003CBADF;
bmp:=TBitmap.Create;
for x:=1 to 3 do begin
 for y:=1 to 9 do begin
 case tablica[y,x] of
 0: form1.canvas.rectangle(poziom[x],pion[y],poziom[x]+140,pion[y]+25);
 1: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'1');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 2: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'2');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 3: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'3');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 4: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'4');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 5: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'5');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 6: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'6');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 7: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'7');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 8: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'8');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 9: begin bmp.Loadfromfile(ExtractFilePath(Paramstr(0))+'9');
          form1.canvas.draw(poziom[x],pion[y],bmp);
    end;
 end;
 end;
 end;
 bmp.free;
end;

procedure TForm1.NowaGra1Click(Sender: TObject);
var i,j:integer;
begin
for i:=1 to 3 do begin
 for j:=1 to 9 do
 tablica[j,i]:=0;
 end;
randomize;
slupek:=random(3)+1;
case level of
1: begin
   for i:=9 downto 7 do
   tablica[i,slupek]:=i-2;
   end;
2: begin
   for i:=9 downto 5 do
   tablica[i,slupek]:=i-2;
   end;
3: begin
   for i:=9 downto 3 do
   tablica[i,slupek]:=i-2;
   end;
end;
tablica[1,slupek]:=8;
pozx:=slupek;
chwycony:=false;
ruchy:=0;
sek0:=0;
sek:=0;
min:=0;
godz:=0;
pauza:=false;
case slupek of
1:begin a:=2; b:=3; end;
2:begin a:=1; b:=3; end;
3:begin a:=1; b:=2; end;
end;
Label1.Caption:='0';
Label2.Caption:='00:00:00:0';
Timer1.Enabled:=True;
Poziom1.Enabled:=False;
FormPaint(Sender);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var y,y1,y2:integer;
begin
if pauza=false then begin
if key=vk_left then begin
if pozx>1 then begin
if chwycony=false then begin
tablica[1,pozx-1]:=8;
tablica[1,pozx]:=0;
pozx:=pozx-1;
if sound=1 then
PlaySound(PChar(ExtractFilePath(Paramstr(0))+'ruch'),0,snd_Async); end else begin
tablica[1,pozx-1]:=9;
tablica[1,pozx]:=0;
tablica[2,pozx-1]:=tablica[2,pozx];
tablica[2,pozx]:=0;
pozx:=pozx-1;
if sound=1 then
PlaySound(PChar(ExtractFilePath(Paramstr(0))+'ruch'),0,snd_Async);end;
FormPaint(Sender);
end;
end;

if key=vk_right then begin
if pozx<3 then begin
if chwycony=false then begin
tablica[1,pozx+1]:=8;
tablica[1,pozx]:=0;
pozx:=pozx+1;
if sound=1 then
PlaySound(PChar(ExtractFilePath(Paramstr(0))+'ruch'),0,snd_Async);end else begin
tablica[1,pozx+1]:=9;
tablica[1,pozx]:=0;
tablica[2,pozx+1]:=tablica[2,pozx];
tablica[2,pozx]:=0;
pozx:=pozx+1;
if sound=1 then
PlaySound(PChar(ExtractFilePath(Paramstr(0))+'ruch'),0,snd_Async);end;
FormPaint(Sender);
end;
end;

if key=vk_up then begin
 if chwycony=false then begin
 for y:=9 downto 3 do begin
   if (tablica[y,pozx]>0) and (tablica[y-1,pozx]=0) then begin
   tablica[1,pozx]:=9;
   tablica[2,pozx]:=tablica[y,pozx];
   tablica[y,pozx]:=0;
   chwycony:=true;
   FormPaint(Sender);
   if sound=1 then
   PlaySound(PChar(ExtractFilePath(Paramstr(0))+'up'),0,snd_Async);
   end;
   end;
 end;
end;

if key=vk_down then begin
 if chwycony=true then begin
 if tablica[9,pozx]=0 then begin
    tablica[1,pozx]:=8;
    tablica[9,pozx]:=tablica[2,pozx];
    tablica[2,pozx]:=0;
    chwycony:=false;
    ruchy:=ruchy+1;
    Label1.Caption:=inttostr(ruchy);
    FormPaint(Sender);
    if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
    end else
   if (tablica[9,pozx]>tablica[2,pozx]) and (tablica[8,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[8,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end else
   if (tablica[8,pozx]>tablica[2,pozx]) and (tablica[7,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[7,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end else
   if (tablica[7,pozx]>tablica[2,pozx]) and (tablica[6,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[6,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end else
   if (tablica[6,pozx]>tablica[2,pozx]) and (tablica[5,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[5,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end else
   if (tablica[5,pozx]>tablica[2,pozx]) and (tablica[4,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[4,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end else
   if (tablica[4,pozx]>tablica[2,pozx]) and (tablica[3,pozx]=0) then begin
   tablica[1,pozx]:=8;
   tablica[3,pozx]:=tablica[2,pozx];
   tablica[2,pozx]:=0;
   chwycony:=false;
   ruchy:=ruchy+1;
   Label1.Caption:=inttostr(ruchy);
   FormPaint(Sender);
   if sound=1 then
    PlaySound(PChar(ExtractFilePath(Paramstr(0))+'down'),0,snd_Async);
   end;
  end;
  case level of
  1: begin
        y1:=0;
        y2:=0;
        for y:=9 downto 7 do begin
        if tablica[y,a]<>0 then
        y1:=y1+1 else
        if tablica[y,b]<>0 then
        y2:=y2+1;
        end;
        if (y1=3) or (y2=3) then
        Koniec(Sender);
     end;
  2: begin
        y1:=0;
        y2:=0;
        for y:=9 downto 5 do begin
        if tablica[y,a]<>0 then
        y1:=y1+1 else
        if tablica[y,b]<>0 then
        y2:=y2+1;
        end;
        if (y1=5) or (y2=5) then
        Koniec(Sender);
     end;
  3: begin
        y1:=0;
        y2:=0;
        for y:=9 downto 3 do begin
        if tablica[y,a]<>0 then
        y1:=y1+1 else
        if tablica[y,b]<>0 then
        y2:=y2+1;
        end;
        if (y1=7) or (y2=7) then
        Koniec(Sender);
     end;
  end;
  end;

end;
end;

procedure TForm1.atwy1Click(Sender: TObject);
begin
redni1.Checked:=False;
Trudny1.Checked:=False;
atwy1.Checked:=True;
level:=1;
end;

procedure TForm1.redni1Click(Sender: TObject);
begin
redni1.Checked:=True;
Trudny1.Checked:=False;
atwy1.Checked:=False;
level:=2;
end;

procedure TForm1.Trudny1Click(Sender: TObject);
begin
redni1.Checked:=False;
Trudny1.Checked:=True;
atwy1.Checked:=False;
level:=3;
end;

procedure TForm1.OdtwarzajDwiki1Click(Sender: TObject);
begin
 If OdtwarzajDwiki1.Checked=True then
    begin
    OdtwarzajDwiki1.Checked:=False;
    Sound:=0;
    end else
       begin
       OdtwarzajDwiki1.Checked:=True;
       Sound:=1;
       end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var Plik: TINIFile;
begin
Plik:=TINIFile.Create(ExtractFilePath(ParamStr(0))+'ustawienia');
Plik.WriteInteger('POZIOM','p',level);
Plik.WriteInteger('SOUND','s',Sound);
Plik.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var Plik: TINIFile;
    I: Byte;
begin
 try
 Plik:=TINIFile.Create(ExtractFilePath(ParamStr(0))+'ustawienia');
  case Plik.ReadInteger('POZIOM','p',2) of
   1: begin atwy1.Checked:=True; level:=1; end;
   2: begin redni1.Checked:=True; level:=2; end;
   3: begin Trudny1.Checked:=True; level:=3; end;
  end;
  case Plik.ReadInteger('SOUND','s',1) of
   0: begin OdtwarzajDwiki1.Checked:=False; Sound:=0; end;
   1: begin OdtwarzajDwiki1.Checked:=True; Sound:=1; end;
  end;
 finally
 Plik.Free;
 end;
end;

procedure TForm1.Wyjcie1Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.Pauza1Click(Sender: TObject);
begin
if pauza=false then begin
pauza:=true;
form1.caption:=nazwa+' Pauza';
Timer1.Enabled:=False;
end else begin
pauza:=false;
form1.caption:=nazwa;
Timer1.Enabled:=True;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var s0,s,m,g:string;
begin
sek0:=sek0+1;
if sek0=10 then begin
sek0:=0;
sek:=sek+1;
end;
if sek=60 then begin
sek:=0;
min:=min+1; end;
if min=60 then begin
min:=0;
godz:=godz+1;
end;
if sek0<10 then
s0:=inttostr(sek0);
if sek<10 then
s:='0'+inttostr(sek) else
s:=inttostr(sek);
if min<10 then
m:='0'+inttostr(min) else
m:=inttostr(min);
if godz<10 then
g:='0'+inttostr(godz) else
g:=inttostr(godz);
Label2.Caption:=g+':'+m+':'+s+':'+s0;
end;

procedure TForm1.Koniec(Sender: TObject);
var i,j:integer;
    plik:tinifile;
begin
for i:=1 to 3 do begin
 for j:=1 to 9 do
 tablica[j,i]:=0;
 end;
Timer1.Enabled:=False;
chwycony:=false;
Poziom1.Enabled:=True;
FormPaint(Sender);
try
Plik:=TINIFile.Create(ExtractFilePath(ParamStr(0))+'ustawienia');
case level of
1:  begin
      if ruchy<Plik.ReadInteger('Wyniki','1a',400) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if ruchy=Plik.ReadInteger('Wyniki','1a',400) then begin
      if godz<Plik.ReadInteger('Wyniki','1b',400) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','1b',400)) and (min<Plik.ReadInteger('Wyniki','1c',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','1b',400)) and (min=Plik.ReadInteger('Wyniki','1c',400)) and
      (sek<Plik.ReadInteger('Wyniki','1d',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','1b',400)) and (min=Plik.ReadInteger('Wyniki','1c',400)) and
      (sek=Plik.ReadInteger('Wyniki','1d',400)) and (sek0<Plik.ReadInteger('Wyniki','1e',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end;
      end;
   end;
2: begin
      if ruchy<Plik.ReadInteger('Wyniki','2a',500) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if ruchy=Plik.ReadInteger('Wyniki','2a',400) then begin
      if godz<Plik.ReadInteger('Wyniki','2b',400) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','2b',400)) and (min<Plik.ReadInteger('Wyniki','2c',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','2b',400)) and (min=Plik.ReadInteger('Wyniki','2c',400)) and
      (sek<Plik.ReadInteger('Wyniki','2d',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','2b',400)) and (min=Plik.ReadInteger('Wyniki','2c',400)) and
      (sek=Plik.ReadInteger('Wyniki','2d',400)) and (sek0<Plik.ReadInteger('Wyniki','2e',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end;
      end;
   end;
3: begin
      if ruchy<Plik.ReadInteger('Wyniki','3a',600) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if ruchy=Plik.ReadInteger('Wyniki','3a',400) then begin
      if godz<Plik.ReadInteger('Wyniki','3b',6) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','3b',400)) and (min<Plik.ReadInteger('Wyniki','3c',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','3b',400)) and (min=Plik.ReadInteger('Wyniki','3c',400)) and
      (sek<Plik.ReadInteger('Wyniki','3d',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end else
      if (godz=Plik.ReadInteger('Wyniki','3b',400)) and (min=Plik.ReadInteger('Wyniki','3c',400)) and
      (sek=Plik.ReadInteger('Wyniki','3d',400)) and (sek0<Plik.ReadInteger('Wyniki','3e',400)) then begin
      Form2.Showmodal;
      Form3.ShowModal;
      end;
      end;
   end;
end;
finally
Plik.Free;
end;
end;

procedure TForm1.Zakocz1Click(Sender: TObject);
var i,j:integer;
begin
for i:=1 to 3 do begin
 for j:=1 to 9 do
 tablica[j,i]:=0;
 end;
Timer1.Enabled:=False;
chwycony:=false;
Poziom1.Enabled:=True;
FormPaint(Sender);
end;

procedure TForm1.NajlepszeWyniki1Click(Sender: TObject);
begin
 if Timer1.Enabled=True then
    begin
    Pauza1Click(Sender);
    end;
Form3.ShowModal;
end;

procedure TForm1.Informacje1Click(Sender: TObject);
begin
if Timer1.Enabled=True then
    begin
    Pauza1Click(Sender);
    end;
Form4.ShowModal;
end;

procedure TForm1.Podzikowania1Click(Sender: TObject);
var P: PChar;
begin
 if Timer1.Enabled=True then
    begin
    Pauza1Click(Sender);
    end;
P:=PChar('Pozdrowienia:'+#13+'Tasak'+#13+'Pi�kny'+#13+'Piela'+#13+'Harry'+#13#13+
'TDFWLightEdites'+#13+'(c) Erol S. Uzuner'+#13+'Version: 1.0, 26.03.99');
Application.MessageBox(P,'Podzi�kowania...',MB_OK);
end;

procedure TForm1.OProgramie1Click(Sender: TObject);
begin
if Timer1.Enabled=True then
    begin
    Pauza1Click(Sender);
    end;
Form5.ShowModal;
end;

end.
