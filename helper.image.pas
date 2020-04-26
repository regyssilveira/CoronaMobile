unit helper.image;

interface

uses
  FMX.Forms, FMX.StdCtrls, FMX.Objects;

type
  TImageHelper = class helper for TImage
    procedure DownloadPNG(const AURL: string);
  end;

implementation

uses
  System.Classes,
  System.Threading,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

procedure TImageHelper.DownloadPNG(const AURL: string);
begin
  Self.Bitmap := nil;

  TThread.CreateAnonymousThread(
    procedure
    var
      Ms: TMemoryStream;
      HttpClient: TNetHTTPClient;
    begin
      HttpClient := TNetHTTPClient.Create(nil);
      try
        Ms := TMemoryStream.Create;
        try
          HttpClient.Get(AURL, Ms);

          TThread.Synchronize(nil,
            procedure
            begin
              Self.Bitmap.LoadFromStream(Ms);
            end
          );
        finally
          Ms.DisposeOf;
        end;
      finally
        HttpClient.DisposeOf;
      end;
    end
  ).Start;
end;

end.
