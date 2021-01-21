
LOCAL lcTestDomain
lcTestDomain = "abæcdöef.de"
lcTestDomainPunny = "xn--abcdef-qua4k.de"
lcTestMail = "test@abæcdöef.de"
lcTestMailPunny = "test@xn--abcdef-qua4k.de"



? "Domain", lcTestDomain , " --> ", PunnyCodeEncode(lcTestDomain )
? "Domain", lcTestDomainPunny , " --> ", PunnyCodeDecode(lcTestDomainPunny )

? "Mail", lcTestMail , " --> ", PunnyCodeEncode(lcTestMail )
? "Mail", lcTestMailPunny , " --> ", PunnyCodeDecode(lcTestMailPunny )



*==============================================================================
* Function:			PunnyCodeEncode
* Purpose:			Encodes a Domain or Email into its punnycode equivalent
* Author:			Bernhard Reiter
* Last Revision:	01/21/2020
* Parameters:		tcDomain - The Domain or Email to convert to punnycode
* Returns:			PunnyCode of the given domain or email
* References:       https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-idntoascii
*==============================================================================

Function PunnyCodeEncode
	LPARAMETERS tcDomain
	DECLARE integer IdnToAscii IN Normaliz.dll integer dwFlags, string lpUnicodeCharStr, integer ccUnicodeChar, string @lpAsciiChar, integer ccAsciiChar
	
	LOCAL lcDomainPart
	LOCAL lcLocalPart
	lcDomainPart = SplitDomainParts(tcDomain, @lcLocalPart)
		
	LOCAL lnResultLen
	LOCAL lcBuffer
	lcBuffer = REPLICATE(" ",5000)
	lnResultLen = IdnToAscii(0, EncodeLPCWString(lcDomainPart ), -1, @lcBuffer, LEN(lcBuffer))
	
	
	LOCAL lcResult
	lcResult = ""
	
	IF lnResultLen > 0 THEN
		lcResult =  lcLocalPart  + DecodeLPCWBuffer(lcBuffer, lnResultLen)
	ENDIF
	
	RETURN lcResult
ENDFUNC

*==============================================================================
* Function:			PunnyCodeDecode
* Purpose:			Encodes a punnycode to a readable domainname
* Author:			Bernhard Reiter
* Last Revision:	01/21/2020
* Parameters:		tcDomain - punnycode
* Returns:			Readable domain or email
* References:       https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-idntounicode
*==============================================================================
Function PunnyCodeDecode
	LPARAMETERS tcDomain
	DECLARE integer IdnToUnicode IN Normaliz.dll integer dwFlags, string @lpASCIICharStr, integer cchASCIIChar, string @lpUnicodeCharStr, integer cchUnicodeChar
	
	LOCAL lcDomainPart
	LOCAL lcLocalPart
	lcDomainPart = SplitDomainParts(tcDomain, @lcLocalPart)
		
	LOCAL lnResultLen
	LOCAL lcBuffer
	lcBuffer = REPLICATE(" ",5000)
	lnResultLen = IdnToUnicode (0, EncodeLPCWString(lcDomainPart ), -1, @lcBuffer, LEN(lcBuffer))

	
	LOCAL lcResult
	lcResult = ""
	
	IF lnResultLen > 0 THEN
		lcResult =  lcLocalPart  + DecodeLPCWBuffer(lcBuffer, lnResultLen)
	ENDIF
	
	RETURN lcResult
ENDFUNC

FUNCTION SplitDomainParts 
	LPARAMETERS tcDomain, tcLocalPart
	tcLocalPart = ""
	
	LOCAL lcDomainPart
	LOCAL lnDomainPartStart
	lnDomainPartStart = AT("@", tcDomain)
	
	lcDomainPart = SUBSTR(tcDomain,lnDomainPartStart +1)
	tcLocalPart =  SUBSTR(tcDomain, 1, lnDomainPartStart )
	
	RETURN lcDomainPart 
ENDFUNC

FUNCTION EncodeLPCWString
	LPARAMETERS tcString
	RETURN STRCONV(tcString,5) + CHR(0)
ENDFUNC

FUNCTION DecodeLPCWBuffer
	LPARAMETERS tcBufferString, tnBufferLen
	
	RETURN LEFT(STRCONV(tcBufferString,6), tnBufferLen)
ENDFUNC

