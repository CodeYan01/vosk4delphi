unit VoskRecognizer;

interface

uses
  SysUtils, Classes, vosk_api, VoskModel;

type
  TVoskRecognizer = class(TComponent)
  private
    { Private declarations }
    FModel: TVoskModel;
    FRecognizer: PVoskRecognizer;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AVoskModel: TVoskModel); reintroduce;
    destructor Destroy; override;
    procedure SetMaxAlternatives(AMAxAlternatives: Integer);
    procedure SetWords(AWords: Integer);
    procedure SetPartialWords(APartialWords: Integer);
    procedure SetNlsml(ANlsml: Integer);
    function AcceptWaveform(const data: PAnsiChar; length: Integer): Integer; overload;
    function AcceptWaveform(const data: PSmallInt; length: Integer): Integer; overload;
    function AcceptWaveform(const data: PSingle; length: Integer): Integer; overload;
    function GetResult(): String;
    function GetPartialResult(): String;
    function GetFinalResult(): String;
    procedure Reset();

    procedure SetModel(AVoskModel: TVoskModel);
  published
    { Published declarations }
    property Model: TVoskModel read FModel write SetModel;
  end;

procedure Register;

implementation

constructor TVoskRecognizer.Create(AOwner: TComponent; AVoskModel: TVoskModel);
begin
  inherited Create(AOwner);
  if AVoskModel.Model = nil then
    raise Exception.Create('VoskModel not yet initialized');
  FRecognizer := vosk_recognizer_new(AVoskModel.Model, 16000.0);
  FModel := AVoskModel;
end;

destructor TVoskRecognizer.Destroy;
begin
  if FRecognizer <> nil then vosk_recognizer_free(FRecognizer);
  inherited Destroy;
end;

(** Configures recognizer to output n-best results
 *
 * <pre>
 *   {
 *      "alternatives": [
 *          { "text": "one two three four five", "confidence": 0.97 },
 *          { "text": "one two three for five", "confidence": 0.03 },
 *      ]
 *   }
 * </pre>
 *
 * @param max_alternatives - maximum alternatives to return from recognition results
 *)
procedure TVoskRecognizer.SetMaxAlternatives(AMAxAlternatives: Integer);
begin
  vosk_recognizer_set_max_alternatives(FRecognizer, AMAxAlternatives);
end;

(** Enables words with times in the output
 *
 * <pre>
 *   "result" : [{
 *       "conf" : 1.000000,
 *       "end" : 1.110000,
 *       "start" : 0.870000,
 *       "word" : "what"
 *     }, {
 *       "conf" : 1.000000,
 *       "end" : 1.530000,
 *       "start" : 1.110000,
 *       "word" : "zero"
 *     }, {
 *       "conf" : 1.000000,
 *       "end" : 1.950000,
 *       "start" : 1.530000,
 *       "word" : "zero"
 *     }, {
 *       "conf" : 1.000000,
 *       "end" : 2.340000,
 *       "start" : 1.950000,
 *       "word" : "zero"
 *     }, {
 *       "conf" : 1.000000,
 *       "end" : 2.610000,
 *       "start" : 2.340000,
 *       "word" : "one"
 *     }],
 * </pre>
 *
 * @param words - boolean value
 *)
procedure TVoskRecognizer.SetWords(AWords: Integer);
begin
  vosk_recognizer_set_words(FRecognizer, AWords);
end;

(** Like above return words and confidences in partial results
 *
 * @param partial_words - boolean value
 *)
procedure TVoskRecognizer.SetPartialWords(APartialWords: Integer);
begin
  vosk_recognizer_set_partial_words(FRecognizer, APartialWords);
end;

(** Set NLSML output
 * @param nlsml - boolean value
 *)
procedure TVoskRecognizer.SetNlsml(ANlsml: Integer);
begin
  vosk_recognizer_set_nlsml(FRecognizer, ANlsml);
end;

(** Accept voice data
 *
 *  accept and process new chunk of voice data
 *
 *  @param data - audio data in PCM 16-bit mono format
 *  @param length - length of the audio data
 *  @returns 1 if silence is occured and you can retrieve a new utterance with result method
 *           0 if decoding continues
 *           -1 if exception occured *)
function TVoskRecognizer.AcceptWaveform(const data: PAnsiChar; length: Integer): Integer;
begin
  Result := vosk_recognizer_accept_waveform(FRecognizer, data, length);
end;

function TVoskRecognizer.AcceptWaveform(const data: PSmallInt; length: Integer): Integer;
begin
  Result := vosk_recognizer_accept_waveform_s(FRecognizer, data, length);
end;

function TVoskRecognizer.AcceptWaveform(const data: PSingle; length: Integer): Integer;
begin
  Result := vosk_recognizer_accept_waveform_f(FRecognizer, data, length);
end;

(** Returns speech recognition result
 *
 * @returns the result in JSON format which contains decoded line, decoded
 *          words, times in seconds and confidences. You can parse this result
 *          with any json parser
 *
 * <pre>
 *  {
 *    "text" : "what zero zero zero one"
 *  }
 * </pre>
 *
 * If alternatives enabled it returns result with alternatives, see also vosk_recognizer_set_alternatives().
 *
 * If word times enabled returns word time, see also vosk_recognizer_set_word_times().
 *)
function TVoskRecognizer.GetResult(): String;
begin
  Result := vosk_recognizer_result(FRecognizer);
end;

(** Returns partial speech recognition
 *
 * @returns partial speech recognition text which is not yet finalized.
 *          result may change as recognizer process more data.
 *
 * <pre>
 * {
 *    "partial" : "cyril one eight zero"
 * }
 * </pre>
 *)
function TVoskRecognizer.GetPartialResult(): String;
begin
  Result := vosk_recognizer_partial_result(FRecognizer);
end;

(** Returns speech recognition result. Same as result, but doesn't wait for silence
 *  You usually call it in the end of the stream to get final bits of audio. It
 *  flushes the feature pipeline, so all remaining audio chunks got processed.
 *
 *  @returns speech result in JSON format.
 *)
function TVoskRecognizer.GetFinalResult(): String;
begin
  Result := vosk_recognizer_final_result(FRecognizer);
end;

(** Resets the recognizer
 *
 *  Resets current results so the recognition can continue from scratch *)
procedure TVoskRecognizer.Reset();
begin
  vosk_recognizer_reset(FRecognizer);
end;

procedure TVoskRecognizer.SetModel(AVoskModel: TVoskModel);
begin
  FModel := AVoskModel;
end;

procedure Register;
begin
  RegisterComponents('Vosk', [TVoskRecognizer]);
end;

end.
 