unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VoskModel, VoskRecognizer, StdCtrls, Grids, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    VoskModel1: TVoskModel;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape3: TShape;
    VoskRecognizer1: TVoskRecognizer;
    Label2: TLabel;
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    FModel: TVoskModel;
    FRecognizer: TVoskRecognizer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormPaint(Sender: TObject);
begin
inherited;
Label2.Canvas.Rectangle(0, 0, Label2.Width, label2.Height);
end;

end.
