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
  protected
    { Protected declarations }
  public
    { Public declarations }
    //constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AModelPath: String); reintroduce;
    destructor Destroy; override;
    function FindWord(AWord: String): Integer;
    property Model: PVoskModel read FModel;
  published
    { Published declarations }
    property ModelPath: String read FModelPath;
  end;

procedure Register;

implementation

constructor TVoskModel.Create(AOwner: TComponent; AModelPath: String);
begin
  inherited Create(AOwner);
  FModelPath := AModelPath;
  FModel := vosk_model_new(PAnsiChar(FModelPath));
end;

(** Check if a word can be recognized by the model
 * @param word: the word
 * @returns the word symbol if @param word exists inside the model
 * or -1 otherwise.
 * Reminding that word symbol 0 is for <epsilon> 
 * Will return -2 if model is not initialized yet. *)
function TVoskModel.FindWord(AWord: String): Integer;
begin
  if FModel = nil then
  begin
    Result := -2;
    Exit;
  end;
  Result := vosk_model_find_word(FModel, PAnsiChar(AWord));
end;

destructor TVoskModel.Destroy;
begin
  vosk_model_free(FModel);
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Vosk', [TVoskModel]);
end;

end.
