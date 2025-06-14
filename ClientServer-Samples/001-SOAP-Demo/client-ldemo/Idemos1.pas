(* C2PP
  ***************************************************************************

  Delphi Sample Projects

  Copyright 1995-2025 Patrick Pr�martin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Set of projects demonstrating the features of the Delphi development
  environment, its libraries and its programming language.

  Some of the projects have been presented at conferences, on training
  courses or online coding sessions.

  The programs are up to date with the Community Edition and the commercial
  version of Delphi or RAD Studio.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://samples.developpeur-pascal.fr

  Project site :
  https://github.com/DeveloppeurPascal/Delphi-samples

  ***************************************************************************
  File last update : 2025-02-09T11:12:20.753+01:00
  Signature : e76477e90dab01027709c594a506abfb564c21c3
  ***************************************************************************
*)

// ************************************************************************ //
// Les types d�clar�s dans ce fichier ont �t� g�n�r�s � partir de donn�es lues
// depuis le fichier WSDL d�crit ci-dessous :
// WSDL     : D:\Documents\Embarcadero\Studio\Projets\rennes - paris\17-web-soap\Idemos.xml
//  >Importer : D:\Documents\Embarcadero\Studio\Projets\rennes - paris\17-web-soap\Idemos.xml>0
// Version  : 1.0
// (23/03/2018 10:08:09 - - $Rev: 90173 $)
// ************************************************************************ //

unit Idemos1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // Les types suivants mentionn�s dans le document WSDL ne sont pas repr�sent�s
  // dans ce fichier. Ce sont des alias[@] d'autres types repr�sent�s ou alors ils �taient r�f�renc�s
  // mais jamais[!] d�clar�s dans le document. Les types de la derni�re cat�gorie
  // sont en principe mapp�s sur des types Embarcadero ou XML pr�d�finis/connus. Toutefois, ils peuvent aussi 
  // signaler des documents WSDL incorrects n'ayant pas r�ussi � d�clarer ou importer un type de sch�ma.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TMyEmployee          = class;                 { "urn:udemosIntf"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "urn:udemosIntf"[GblSmpl] }
  TEnumTest = (etNone, etAFew, etSome, etAlot);

  {$SCOPEDENUMS OFF}

  TDoubleArray = array of Double;               { "urn:udemosIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : TMyEmployee, global, <complexType>
  // Espace de nommage : urn:udemosIntf
  // ************************************************************************ //
  TMyEmployee = class(TRemotable)
  private
    FLastName: string;
    FFirstName: string;
    FSalary: Double;
  published
    property LastName:  string  read FLastName write FLastName;
    property FirstName: string  read FFirstName write FFirstName;
    property Salary:    Double  read FSalary write FSalary;
  end;


  // ************************************************************************ //
  // Espace de nommage : urn:udemosIntf-Idemos
  // soapAction : urn:udemosIntf-Idemos#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // utiliser   : encoded
  // Liaison : Idemosbinding
  // service   : Idemosservice
  // port      : IdemosPort
  // URL       : http://localhost:8080/soap/Idemos
  // ************************************************************************ //
  Idemos = interface(IInvokable)
  ['{969D57A0-EF51-3F60-38CB-E9A441755A18}']
    function  echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function  echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function  echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function  echoDouble(const Value: Double): Double; stdcall;
  end;

function GetIdemos(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Idemos;


implementation
  uses System.SysUtils;

function GetIdemos(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Idemos;
const
  defWSDL = 'D:\Documents\Embarcadero\Studio\Projets\rennes - paris\17-web-soap\Idemos.xml';
  defURL  = 'http://localhost:8080/soap/Idemos';
  defSvc  = 'Idemosservice';
  defPrt  = 'IdemosPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as Idemos);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { Idemos }
  InvRegistry.RegisterInterface(TypeInfo(Idemos), 'urn:udemosIntf-Idemos', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Idemos), 'urn:udemosIntf-Idemos#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TEnumTest), 'urn:udemosIntf', 'TEnumTest');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TDoubleArray), 'urn:udemosIntf', 'TDoubleArray');
  RemClassRegistry.RegisterXSClass(TMyEmployee, 'urn:udemosIntf', 'TMyEmployee');

end.
