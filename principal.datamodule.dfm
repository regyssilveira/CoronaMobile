object DtmPrincipal: TDtmPrincipal
  OldCreateOrder = False
  Height = 443
  Width = 377
  object RESTCli: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://corona.lmao.ninja/v2'
    Params = <>
    Left = 80
    Top = 35
  end
  object ReqResumo: TRESTRequest
    Client = RESTCli
    Params = <>
    Resource = 'all'
    Response = RESTResp
    SynchronizedEvents = False
    Left = 80
    Top = 95
  end
  object ReqPaises: TRESTRequest
    Client = RESTCli
    Params = <>
    Resource = 'countries'
    Response = RESTResp
    SynchronizedEvents = False
    Left = 170
    Top = 95
  end
  object RESTResp: TRESTResponse
    ContentType = 'application/json'
    Left = 80
    Top = 160
  end
  object ReqPais: TRESTRequest
    Client = RESTCli
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'pais'
        Options = [poAutoCreated]
        Value = 'brazil'
      end>
    Resource = 'countries/{pais}'
    Response = RESTResp
    SynchronizedEvents = False
    Left = 260
    Top = 95
  end
  object TbResumo: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 75
    Top = 350
    object TbResumoupdated: TWideStringField
      FieldName = 'updated'
      Size = 255
    end
    object TbResumocases: TWideStringField
      FieldName = 'cases'
      Size = 255
    end
    object TbResumotodayCases: TWideStringField
      FieldName = 'todayCases'
      Size = 255
    end
    object TbResumodeaths: TWideStringField
      FieldName = 'deaths'
      Size = 255
    end
    object TbResumotodayDeaths: TWideStringField
      FieldName = 'todayDeaths'
      Size = 255
    end
    object TbResumorecovered: TWideStringField
      FieldName = 'recovered'
      Size = 255
    end
    object TbResumoactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object TbResumocritical: TWideStringField
      FieldName = 'critical'
      Size = 255
    end
    object TbResumocasesPerOneMillion: TWideStringField
      FieldName = 'casesPerOneMillion'
      Size = 255
    end
    object TbResumodeathsPerOneMillion: TWideStringField
      FieldName = 'deathsPerOneMillion'
      Size = 255
    end
    object TbResumotests: TWideStringField
      FieldName = 'tests'
      Size = 255
    end
    object TbResumotestsPerOneMillion: TWideStringField
      FieldName = 'testsPerOneMillion'
      Size = 255
    end
    object TbResumoaffectedCountries: TWideStringField
      FieldName = 'affectedCountries'
      Size = 255
    end
  end
  object DtsAdpResumo: TRESTResponseDataSetAdapter
    Dataset = TbResumo
    FieldDefs = <>
    Response = RESTResp
    Left = 75
    Top = 300
  end
  object DtsAdpPaises: TRESTResponseDataSetAdapter
    Dataset = TbPaises
    FieldDefs = <>
    Response = RESTResp
    NestedElements = True
    Left = 185
    Top = 300
  end
  object DtsAdpPais: TRESTResponseDataSetAdapter
    Dataset = TbPais
    FieldDefs = <>
    Response = RESTResp
    NestedElements = True
    Left = 295
    Top = 300
  end
  object TbPaises: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 185
    Top = 350
    object TbPaisesupdated: TWideStringField
      FieldName = 'updated'
      Size = 255
    end
    object TbPaisescountry: TWideStringField
      FieldName = 'country'
      Size = 255
    end
    object TbPaisescountryInfo: TWideStringField
      FieldName = 'countryInfo'
      Size = 255
    end
    object TbPaisescountryInfo_id: TWideStringField
      FieldName = 'countryInfo._id'
      Size = 255
    end
    object TbPaisescountryInfoiso2: TWideStringField
      FieldName = 'countryInfo.iso2'
      Size = 255
    end
    object TbPaisescountryInfoiso3: TWideStringField
      FieldName = 'countryInfo.iso3'
      Size = 255
    end
    object TbPaisescountryInfolat: TWideStringField
      FieldName = 'countryInfo.lat'
      Size = 255
    end
    object TbPaisescountryInfolong: TWideStringField
      FieldName = 'countryInfo.long'
      Size = 255
    end
    object TbPaisescountryInfoflag: TWideStringField
      FieldName = 'countryInfo.flag'
      Size = 255
    end
    object TbPaisescases: TWideStringField
      FieldName = 'cases'
      Size = 255
    end
    object TbPaisestodayCases: TWideStringField
      FieldName = 'todayCases'
      Size = 255
    end
    object TbPaisesdeaths: TWideStringField
      FieldName = 'deaths'
      Size = 255
    end
    object TbPaisestodayDeaths: TWideStringField
      FieldName = 'todayDeaths'
      Size = 255
    end
    object TbPaisesrecovered: TWideStringField
      FieldName = 'recovered'
      Size = 255
    end
    object TbPaisesactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object TbPaisescritical: TWideStringField
      FieldName = 'critical'
      Size = 255
    end
    object TbPaisescasesPerOneMillion: TWideStringField
      FieldName = 'casesPerOneMillion'
      Size = 255
    end
    object TbPaisesdeathsPerOneMillion: TWideStringField
      FieldName = 'deathsPerOneMillion'
      Size = 255
    end
    object TbPaisestests: TWideStringField
      FieldName = 'tests'
      Size = 255
    end
    object TbPaisestestsPerOneMillion: TWideStringField
      FieldName = 'testsPerOneMillion'
      Size = 255
    end
    object TbPaisescontinent: TWideStringField
      FieldName = 'continent'
      Size = 255
    end
  end
  object TbPais: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 295
    Top = 350
    object TbPaisupdated: TWideStringField
      FieldName = 'updated'
      Size = 255
    end
    object TbPaiscountry: TWideStringField
      FieldName = 'country'
      Size = 255
    end
    object TbPaiscountryInfo: TWideStringField
      FieldName = 'countryInfo'
      Size = 255
    end
    object TbPaiscountryInfo_id: TWideStringField
      FieldName = 'countryInfo._id'
      Size = 255
    end
    object TbPaiscountryInfoiso2: TWideStringField
      FieldName = 'countryInfo.iso2'
      Size = 255
    end
    object TbPaiscountryInfoiso3: TWideStringField
      FieldName = 'countryInfo.iso3'
      Size = 255
    end
    object TbPaiscountryInfolat: TWideStringField
      FieldName = 'countryInfo.lat'
      Size = 255
    end
    object TbPaiscountryInfolong: TWideStringField
      FieldName = 'countryInfo.long'
      Size = 255
    end
    object TbPaiscountryInfoflag: TWideStringField
      FieldName = 'countryInfo.flag'
      Size = 255
    end
    object TbPaiscases: TWideStringField
      FieldName = 'cases'
      Size = 255
    end
    object TbPaistodayCases: TWideStringField
      FieldName = 'todayCases'
      Size = 255
    end
    object TbPaisdeaths: TWideStringField
      FieldName = 'deaths'
      Size = 255
    end
    object TbPaistodayDeaths: TWideStringField
      FieldName = 'todayDeaths'
      Size = 255
    end
    object TbPaisrecovered: TWideStringField
      FieldName = 'recovered'
      Size = 255
    end
    object TbPaisactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object TbPaiscritical: TWideStringField
      FieldName = 'critical'
      Size = 255
    end
    object TbPaiscasesPerOneMillion: TWideStringField
      FieldName = 'casesPerOneMillion'
      Size = 255
    end
    object TbPaisdeathsPerOneMillion: TWideStringField
      FieldName = 'deathsPerOneMillion'
      Size = 255
    end
    object TbPaistests: TWideStringField
      FieldName = 'tests'
      Size = 255
    end
    object TbPaistestsPerOneMillion: TWideStringField
      FieldName = 'testsPerOneMillion'
      Size = 255
    end
    object TbPaiscontinent: TWideStringField
      FieldName = 'continent'
      Size = 255
    end
  end
end
