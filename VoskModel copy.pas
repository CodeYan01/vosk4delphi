unit VoskModel;

interface

uses
  SysUtils, Classes, vosk_api;

type
  TVoskModel = class(TComponent)
  private
    { Private declarations }
    FModel: PVoskModel;
    FModelPath: String;
    procedure InitializeModel;
    procedure FreeModel;
    procedure SetModelPath(Value: String);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AModelPath: String); reintroduce; overload;

    destructor Destroy; override;
  published
    { Published declarations }
    property ModelPath: String read FModelPath write SetModelPath;
  end;

procedure Register;

implementation

constructor TVoskModel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
end;

constructor TVoskModel.Create(AOwner: TComponent; AModelPath: String);
begin
  inherited Create(AOwner);
  FModelPath := AModelPath;
end;

procedure TVoskModel.InitializeModel;
begin
  if FModelPath = '' then exit;

  if FModel <> nil then
    FreeModel;
  
  FModel := vosk_model_new(PAnsiChar(FModelPath));
end;

procedure TVoskModel.FreeModel;
begin
  if FModel = nil then exit;

  vosk_model_free(FModel);
  FModel := nil;
end;

procedure TVoskModel.SetModelPath(Value: String);
begin
  FreeModel;
  FModelPath := Value;
  InitializeModel;
end;

destructor TVoskModel.Destroy;
begin
  FreeModel;
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Vosk', [TVoskModel]);
end;

end.
 