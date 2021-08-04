# vfpPunyCode

## Description
A short helper function to convert strings into its punycode or to convert punycode back using Windows API in Visual FoxPro.

Punycode is used to translate non-ascii compilant (or unicode) domainnames into ascii compilant names to the RFC-3492

### Some examples
|Unicode      |Punycode    |
|-------------|------------|
|schön        |xn-schn-7qa |
|☺            |xn-4h       |

### About this Program
This program has some Windows API Calls wrapped to use the encode and decode function of these in Visual FoxPro.  
**Advice: It is using the API Calls to normalize.dll (See [MSDN Documentation](https://docs.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-idntounicode))  
Minimum requirement is Windows Vista or Windows Server 2008 !**

#### Function **PunnyCodeEncode**  

Takes a string as parameter, the domain or email which you want to convert from Unicode to a valid Punycode.  
Return: Punycode domain or email.

Usage:  
```xBase
 ** abæcdöef.de --> xn--abcdef-qua4k.de
 ? PunnyCodeEncode("abæcdöef.de")
```
#### Function **PunnyCodeDecode**  

Takes a string as parameter, the domain or email which is in valid Punycode and converts it to a Unicode / readable domain or email.  
Return: Punycode domain or email.

Usage:  
```xBase
 ** xn--abcdef-qua4k.de --> abæcdöef.de    
 ? PunnyCodeDecode("xn--abcdef-qua4k.de")
```

## If you like this...  
..i would be happy, if you give this repository a star if it was helping you! Thanks.


## License
The MIT License (MIT)

Copyright © 2015 Adam Pritchard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
© 2021 GitHub, Inc.

