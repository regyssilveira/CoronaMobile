unit helper.field;

interface

uses
  Data.DB, FMX.Forms, FMX.StdCtrls, FMX.Objects;

type
  TFieldHelper = class helper for TField
    function AsNumFormatado: string;
  end;

implementation

uses
  System.SysUtils;

function TFieldHelper.AsNumFormatado: string;
begin
  if Self.AsString.Trim.IsEmpty then
    Result := ''
  else
  begin
    try
      if Frac(Self.AsFloat) = 0.00 then
        Result := FormatFloat(',#0', Self.AsFloat)
      else
        Result:= FormatFloat(',#0.00', Self.AsFloat);
    except
      Result := Self.AsString;
    end;
  end;
end;

end.
