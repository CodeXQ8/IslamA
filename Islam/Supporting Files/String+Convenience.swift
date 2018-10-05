//
//  String+Convenience.swift
//  WP
//
//  Created by Pierre Marty on 23/05/2017.
//  Copyright © 2017 alpeslog. All rights reserved.
//

import UIKit


extension String {

    init(htmlEncodedString: String) {
                    self.init()
        if let attributedString = htmlEncodedString.htmlToAttributedString(using: UIFont(name: "Helvetica", size: 21)) {
                        self = attributedString.string
                    }
                    else {
                        self = htmlEncodedString
                    }
                }
    
        func htmlToAttributedString(using font: UIFont?) -> NSAttributedString? {
        
             
                let htmlCSSString = "<style>" +
                    "html *" +
                    "{" +
                    "font-size: \(font?.pointSize)pt !important;" +
                    "font-family: \(font?.familyName), Helvetica !important;" +
                "}</style> \(self)"
    
    
                if let data = htmlCSSString.data(using: String.Encoding.utf8) {
                // pm171004 converted to Swift 4
                let options:[NSAttributedString.DocumentReadingOptionKey : Any] =
                    [NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
                     NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue]
    
    
                if let attributedString = try? NSAttributedString(data:data, options:options, documentAttributes:nil) {
                    return attributedString
                }
            }
            return nil
        }
    }


    func loadHtml(using htmlContent: String) {
        do {
            do {
            let style = try String(contentsOfFile: Bundle.main.path(forResource: "style", ofType: "css")!)
                let htmlStyling = String(format: "<html>" +
                    "<head>" +
                    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0\" />" +
                    "<style type=\"text/css\">",
                    "%@",
                    "</style>" ,
                    "</head>" ,
                    "<body>" ,
                    "<p>%@</p>" ,
                    "</body></html>", style, htmlContent)
                    
//                    [String(format: "<html>"
//                    "<head>"
//                    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0\" />"
//                    "<style type=\"text/css\">"
//                    "%@"
//                    "</style>"
//                    "</head>"
//                    "<body>"
//                    "<p>%@</p>"
//                    "</body></html>", style, htmlContent)];
            } catch {
                print(error)
            }
}
}

            
            //            let htmlCSSString = "<style>" +
            //                "html *" +
            //                "{" +
            //                "font-size: \(font?.pointSize)pt !important;" +
            //                "font-family: \(font?.familyName), Helvetica !important;" +
            //            "}</style> \(self)"
            
            
//            if let data = htmlStyling.data(using: String.Encoding.utf8) {
//                // pm171004 converted to Swift 4
//                let options:[NSAttributedString.DocumentReadingOptionKey : Any] =
//                    [NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
//                     NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue]
//
//
//                if let attributedString = try? NSAttributedString(data:data, options:options, documentAttributes:nil) {
//                    return attributedString
//                }
//            }
//            return nil
//        }

    
    
    
    





















//extension String {
//        init(htmlEncodedString: String) {
//            self.init()
//            if let attributedString = htmlEncodedString.htmlAttributedString(fontSize: 18) {
//                self = attributedString.string
//            }
//            else {
//                self = htmlEncodedString
//            }
//        }
//
//    func htmlAttributedString(fontSize: CGFloat = 17.0) -> NSAttributedString? {
//        let fontName = UIFont.systemFont(ofSize: fontSize).fontName
//        let string = self.appending(String(format: "<style>body{font-family: '%@'; font-size:%fpx;}</style>", fontName, fontSize))
//        guard let data = string.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
//
//        guard let html = try? NSMutableAttributedString (
//            data: data,
//            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil) else { return nil }
//        return html
//    }
//}




//extension String{
//    func convertHtml() -> NSAttributedString{
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do{
//            let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//        }catch{
//            return NSAttributedString()
//        }
//    }
//}







//
//extension String {
//    // MARK: - Instance Methods
//    func stringByConvertingHTMLToPlainText() -> String? {
//        autoreleasepool { () -> String? in
//            // Character sets
//            let stopCharacters = CharacterSet(charactersIn: "< \t\n\r\(unichar(0x0085))\(unichar(0x000c))\(unichar(0x2028))\(unichar(0x2029))")
//            let newLineAndWhitespaceCharacters = CharacterSet(charactersIn: " \t\n\r\(unichar(0x0085))\(unichar(0x000c))\(unichar(0x2028))\(unichar(0x2029))")
//            let tagNameCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
//            // Scan and find all tags
//            var result = String(repeating: "\0", count: count)
//            let scanner = Scanner(string: self as String)
//            scanner.charactersToBeSkipped = nil
//            scanner.caseSensitive = true
//            var str: NSString? = nil
//            var tagName: NSString? = nil
//            var dontReplaceTagWithSpace = false
//            repeat {
//                // Scan up to the start of a tag or whitespace
//                if scanner.scanUpToCharacters(from: stopCharacters, into: &str) {
//                    result += (str ?? "") as String
//                    str = nil // reset
//                }
//                // Check if we've stopped at a tag/comment or whitespace
//                if scanner.scanString("<", into: nil) {
//                    // Stopped at a comment, script tag, or other tag
//                    if scanner.scanString("!--", into: nil) {
//                        // Comment
//                        scanner.scanUpTo("-->", into: nil)
//                        scanner.scanString("-->", into: nil)
//                    } else if scanner.scanString("script", into: nil) {
//                        // Script tag where things don't need escaping!
//                        scanner.scanUpTo("</script>", into: nil)
//                        scanner.scanString("</script>", into: nil)
//                    } else {
//                        // Tag - remove and replace with space unless it's
//                        // a closing inline tag then dont replace with a space
//                        if scanner.scanString("/", into: nil) {
//                            // Closing tag - replace with space unless it's inline
//                            tagName = nil
//                            dontReplaceTagWithSpace = false
//                            if scanner.scanCharacters(from: tagNameCharacters, into: &tagName) {
//                                tagName = tagName?.lowercased as! NSString
//                                dontReplaceTagWithSpace = (tagName == "a") || (tagName == "b") || (tagName == "i") || (tagName == "q") || (tagName == "span") || (tagName == "em") || (tagName == "strong") || (tagName == "cite") || (tagName == "abbr") || (tagName == "acronym") || (tagName == "label")
//                            }
//                            // Replace tag with string unless it was an inline
//                            if !dontReplaceTagWithSpace && result.count > 0 && !scanner.isAtEnd {
//                                result += " "
//                            }
//                        }
//                        // Scan past tag
//                        scanner.scanUpTo(">", into: nil)
//                        scanner.scanString(">", into: nil)
//                    }
//                } else {
//                    // Stopped at whitespace - replace all whitespace and newlines with a space
//                    if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
//                        if result.count > 0 && !scanner.isAtEnd {
//                            result += " " // Dont append space to beginning or end of result
//                        }
//                    }
//                }
//            } while !scanner.isAtEnd
//            // Cleanup
//            // Decode HTML entities and return
//            let retString = result.stringByDecodingHTMLEntities()
//            // Return
//            return retString
//        }
//    }
//    func stringByDecodingHTMLEntities() -> String? {
//        // Can return self so create new string if we're a mutable string
//        return gtm_stringByUnescapingFromHTML()
//    }
//    func stringByEncodingHTMLEntities() -> String? {
//        // Can return self so create new string if we're a mutable string
//        return gtm_stringByEscapingForAsciiHTML()
//    }
//    func string(byEncodingHTMLEntities isUnicode: Bool) -> String? {
//        // Can return self so create new string if we're a mutable string
//        return isUnicode ? gtm_stringByEscapingForHTML() : gtm_stringByEscapingForAsciiHTML()
//    }
//    func stringWithNewLinesAsBRs() -> String? {
//        autoreleasepool { () -> String in
//            // Strange New lines:
//            //Next Line, U+0085
//            //Form Feed, U+000C
//            //Line Separator, U+2028
//            //Paragraph Separator, U+2029
//            // Scanner
//            let scanner = Scanner(string: self as String)
//            scanner.charactersToBeSkipped = nil
//            var result = ""
//            var temp: String
//            let newLineCharacters = CharacterSet(charactersIn: "\n\r\(unichar(0x0085))\(unichar(0x000c))\(unichar(0x2028))\(unichar(0x2029))")
//            // Scan
//            repeat {
//                // Get non new line characters
//                temp = " "
//                scanner.scanUpToCharacters(from: newLineCharacters, into: &temp)
//                if temp != "" {
//                    result += temp
//                }
//                temp = ""
//                // Add <br /> s
//                if scanner.scanString("\r\n", into: nil) {
//                    // Combine \r\n into just 1 <br />
//                    result += "<br />"
//                } else if scanner.scanCharacters(from: newLineCharacters, into: &temp) {
//                    // Scan other new line characters and add <br /> s
//                    if temp != "" {
//                        for i in 0..<temp.count {
//                            result += "<br />"
//                        }
//                    }
//                }
//            } while !scanner.isAtEnd
//            // Cleanup & return
//            let retString = result
//            // Return
//            return retString
//        }
//    }
//    func stringByRemovingNewLinesAndWhitespace() -> String? {
//        autoreleasepool { () -> String in
//            // Strange New lines:
//            //Next Line, U+0085
//            //Form Feed, U+000C
//            //Line Separator, U+2028
//            //Paragraph Separator, U+2029
//            // Scanner
//            let scanner = Scanner(string: self as String)
//            scanner.charactersToBeSkipped = nil
//            var result = ""
//            var temp: String
//            let newLineAndWhitespaceCharacters = CharacterSet(charactersIn: " \t\n\r\(unichar(0x0085))\(unichar(0x000c))\(unichar(0x2028))\(unichar(0x2029))")
//            // Scan
//            while !scanner.isAtEnd {
//                // Get non new line or whitespace characters
//                temp = ""
//                scanner.scanUpToCharacters(from: newLineAndWhitespaceCharacters, into: temp as NSString)
//                if temp != "" {
//                    result += temp
//                }
//                // Replace with a space
//                if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
//                    if result.count > 0 && !scanner.isAtEnd {
//                        result += " "
//                    }
//                }
//            }
//            // Cleanup
//            // Return
//            let retString = result
//            // Return
//            return retString
//        }
//    }
//    func stringByLinkifyingURLs() -> String? {
//        if NSClassFromString("NSRegularExpression") == nil {
//            return self as String
//        }
//        autoreleasepool { () -> String? in
//            let pattern = "(?<!=\")\\b((http|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%%&amp;:/~\\+#]*[\\w\\-\\@?^=%%&amp;/~\\+#])?)"
//            let regex = try? NSRegularExpression(pattern: pattern, options: [])
//            let modifiedString = regex?.stringByReplacingMatches(in: self as String, options: [], range: NSRange(location: 0, length: count), withTemplate: "<a href=\"$1\" class=\"linkified\">$1</a>")
//            return modifiedString
//        }
//    }
//
//    func stringByStrippingTags() -> String? {
//        autoreleasepool { () -> String in
//            // Find first & and short-cut if we can
//            let ampIndex = Int((self as NSString).range(of: "<", options: .literal).location)
//            if ampIndex == NSNotFound {
//                return self as String // return copy of string as no tags found
//            }
//            // Scan and find all tags
//            let scanner = Scanner(string: self as String)
//            scanner.charactersToBeSkipped = nil
//            var tags: Set<AnyHashable> = []
//            var tag: String
//            repeat {
//                // Scan up to <
//                tag = ""
//                scanner.scanUpTo("<", into: nil)
//                scanner.scanUpTo(">", into: tag as NSString)
//                // Add to set
//                if tag != "" {
//                    let t = "\(tag)>"
//                    tags.insert(t)
//                }
//            } while !scanner.isAtEnd
//            // Strings
//            var result = self as String
//            var finalString: String
//            // Replace tags
//            var replacement: String
//            for t: String? in tags as? [String?] ?? [] {
//                // Replace tag with space unless it's an inline element
//                replacement = " "
//                if (t == "<a>") || (t == "</a>") || (t == "<span>") || (t == "</span>") || (t == "<strong>") || (t == "</strong>") || (t == "<em>") || (t == "</em>") {
//                    replacement = ""
//                }
//                // Replace
//                if let subRange = Range<String.Index>(NSRange(location: 0, length: result.count), in: result) { result = result.replacingOccurrences(of: t ?? "", with: replacement, options: .literal, range: subRange) }
//            }
//            // Remove multi-spaces and line breaks
//            finalString = result.stringByRemovingNewLinesAndWhitespace() ?? ""
//            // Cleanup
//            // Return
//            return finalString
//        }
//    }
//}
//
//    typealias HTMLEscapeMap = (escapeSequence: String, uchar: unichar)
//    // Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
//    // Ordered by uchar lowest to highest for bsearching
//    private var gAsciiHTMLEscapeMap = [
//        // A.2.2. Special characters
//        ("&quot;", 34),
//        ("&amp;", 38),
//        ("&apos;", 39),
//        ("&lt;", 60),
//        ("&gt;", 62),
//        // A.2.1. Latin-1 characters
//        ("&nbsp;", 160),
//        ("&iexcl;", 161),
//        ("&cent;", 162),
//        ("&pound;", 163),
//        ("&curren;", 164),
//        ("&yen;", 165),
//        ("&brvbar;", 166),
//        ("&sect;", 167),
//        ("&uml;", 168),
//        ("&copy;", 169),
//        ("&ordf;", 170),
//        ("&laquo;", 171),
//        ("&not;", 172),
//        ("&shy;", 173),
//        ("&reg;", 174),
//        ("&macr;", 175),
//        ("&deg;", 176),
//        ("&plusmn;", 177),
//        ("&sup2;", 178),
//        ("&sup3;", 179),
//        ("&acute;", 180),
//        ("&micro;", 181),
//        ("&para;", 182),
//        ("&middot;", 183),
//        ("&cedil;", 184),
//        ("&sup1;", 185),
//        ("&ordm;", 186),
//        ("&raquo;", 187),
//        ("&frac14;", 188),
//        ("&frac12;", 189),
//        ("&frac34;", 190),
//        ("&iquest;", 191),
//        ("&Agrave;", 192),
//        ("&Aacute;", 193),
//        ("&Acirc;", 194),
//        ("&Atilde;", 195),
//        ("&Auml;", 196),
//        ("&Aring;", 197),
//        ("&AElig;", 198),
//        ("&Ccedil;", 199),
//        ("&Egrave;", 200),
//        ("&Eacute;", 201),
//        ("&Ecirc;", 202),
//        ("&Euml;", 203),
//        ("&Igrave;", 204),
//        ("&Iacute;", 205),
//        ("&Icirc;", 206),
//        ("&Iuml;", 207),
//        ("&ETH;", 208),
//        ("&Ntilde;", 209),
//        ("&Ograve;", 210),
//        ("&Oacute;", 211),
//        ("&Ocirc;", 212),
//        ("&Otilde;", 213),
//        ("&Ouml;", 214),
//        ("&times;", 215),
//        ("&Oslash;", 216),
//        ("&Ugrave;", 217),
//        ("&Uacute;", 218),
//        ("&Ucirc;", 219),
//        ("&Uuml;", 220),
//        ("&Yacute;", 221),
//        ("&THORN;", 222),
//        ("&szlig;", 223),
//        ("&agrave;", 224),
//        ("&aacute;", 225),
//        ("&acirc;", 226),
//        ("&atilde;", 227),
//        ("&auml;", 228),
//        ("&aring;", 229),
//        ("&aelig;", 230),
//        ("&ccedil;", 231),
//        ("&egrave;", 232),
//        ("&eacute;", 233),
//        ("&ecirc;", 234),
//        ("&euml;", 235),
//        ("&igrave;", 236),
//        ("&iacute;", 237),
//        ("&icirc;", 238),
//        ("&iuml;", 239),
//        ("&eth;", 240),
//        ("&ntilde;", 241),
//        ("&ograve;", 242),
//        ("&oacute;", 243),
//        ("&ocirc;", 244),
//        ("&otilde;", 245),
//        ("&ouml;", 246),
//        ("&divide;", 247),
//        ("&oslash;", 248),
//        ("&ugrave;", 249),
//        ("&uacute;", 250),
//        ("&ucirc;", 251),
//        ("&uuml;", 252),
//        ("&yacute;", 253),
//        ("&thorn;", 254),
//        ("&yuml;", 255),
//        // A.2.2. Special characters cont'd
//        ("&OElig;", 338),
//        ("&oelig;", 339),
//        ("&Scaron;", 352),
//        ("&scaron;", 353),
//        ("&Yuml;", 376),
//        // A.2.3. Symbols
//        ("&fnof;", 402),
//        // A.2.2. Special characters cont'd
//        ("&circ;", 710),
//        ("&tilde;", 732),
//        // A.2.3. Symbols cont'd
//        ("&Alpha;", 913),
//        ("&Beta;", 914),
//        ("&Gamma;", 915),
//        ("&Delta;", 916),
//        ("&Epsilon;", 917),
//        ("&Zeta;", 918),
//        ("&Eta;", 919),
//        ("&Theta;", 920),
//        ("&Iota;", 921),
//        ("&Kappa;", 922),
//        ("&Lambda;", 923),
//        ("&Mu;", 924),
//        ("&Nu;", 925),
//        ("&Xi;", 926),
//        ("&Omicron;", 927),
//        ("&Pi;", 928),
//        ("&Rho;", 929),
//        ("&Sigma;", 931),
//        ("&Tau;", 932),
//        ("&Upsilon;", 933),
//        ("&Phi;", 934),
//        ("&Chi;", 935),
//        ("&Psi;", 936),
//        ("&Omega;", 937),
//        ("&alpha;", 945),
//        ("&beta;", 946),
//        ("&gamma;", 947),
//        ("&delta;", 948),
//        ("&epsilon;", 949),
//        ("&zeta;", 950),
//        ("&eta;", 951),
//        ("&theta;", 952),
//        ("&iota;", 953),
//        ("&kappa;", 954),
//        ("&lambda;", 955),
//        ("&mu;", 956),
//        ("&nu;", 957),
//        ("&xi;", 958),
//        ("&omicron;", 959),
//        ("&pi;", 960),
//        ("&rho;", 961),
//        ("&sigmaf;", 962),
//        ("&sigma;", 963),
//        ("&tau;", 964),
//        ("&upsilon;", 965),
//        ("&phi;", 966),
//        ("&chi;", 967),
//        ("&psi;", 968),
//        ("&omega;", 969),
//        ("&thetasym;", 977),
//        ("&upsih;", 978),
//        ("&piv;", 982),
//        // A.2.2. Special characters cont'd
//        ("&ensp;", 8194),
//        ("&emsp;", 8195),
//        ("&thinsp;", 8201),
//        ("&zwnj;", 8204),
//        ("&zwj;", 8205),
//        ("&lrm;", 8206),
//        ("&rlm;", 8207),
//        ("&ndash;", 8211),
//        ("&mdash;", 8212),
//        ("&lsquo;", 8216),
//        ("&rsquo;", 8217),
//        ("&sbquo;", 8218),
//        ("&ldquo;", 8220),
//        ("&rdquo;", 8221),
//        ("&bdquo;", 8222),
//        ("&dagger;", 8224),
//        ("&Dagger;", 8225),
//        // A.2.3. Symbols cont'd
//        ("&bull;", 8226),
//        ("&hellip;", 8230),
//        // A.2.2. Special characters cont'd
//        ("&permil;", 8240),
//        // A.2.3. Symbols cont'd
//        ("&prime;", 8242),
//        ("&Prime;", 8243),
//        // A.2.2. Special characters cont'd
//        ("&lsaquo;", 8249),
//        ("&rsaquo;", 8250),
//        // A.2.3. Symbols cont'd
//        ("&oline;", 8254),
//        ("&frasl;", 8260),
//        // A.2.2. Special characters cont'd
//        ("&euro;", 8364),
//        // A.2.3. Symbols cont'd
//        ("&image;", 8465),
//        ("&weierp;", 8472),
//        ("&real;", 8476),
//        ("&trade;", 8482),
//        ("&alefsym;", 8501),
//        ("&larr;", 8592),
//        ("&uarr;", 8593),
//        ("&rarr;", 8594),
//        ("&darr;", 8595),
//        ("&harr;", 8596),
//        ("&crarr;", 8629),
//        ("&lArr;", 8656),
//        ("&uArr;", 8657),
//        ("&rArr;", 8658),
//        ("&dArr;", 8659),
//        ("&hArr;", 8660),
//        ("&forall;", 8704),
//        ("&part;", 8706),
//        ("&exist;", 8707),
//        ("&empty;", 8709),
//        ("&nabla;", 8711),
//        ("&isin;", 8712),
//        ("&notin;", 8713),
//        ("&ni;", 8715),
//        ("&prod;", 8719),
//        ("&sum;", 8721),
//        ("&minus;", 8722),
//        ("&lowast;", 8727),
//        ("&radic;", 8730),
//        ("&prop;", 8733),
//        ("&infin;", 8734),
//        ("&ang;", 8736),
//        ("&and;", 8743),
//        ("&or;", 8744),
//        ("&cap;", 8745),
//        ("&cup;", 8746),
//        ("&int;", 8747),
//        ("&there4;", 8756),
//        ("&sim;", 8764),
//        ("&cong;", 8773),
//        ("&asymp;", 8776),
//        ("&ne;", 8800),
//        ("&equiv;", 8801),
//        ("&le;", 8804),
//        ("&ge;", 8805),
//        ("&sub;", 8834),
//        ("&sup;", 8835),
//        ("&nsub;", 8836),
//        ("&sube;", 8838),
//        ("&supe;", 8839),
//        ("&oplus;", 8853),
//        ("&otimes;", 8855),
//        ("&perp;", 8869),
//        ("&sdot;", 8901),
//        ("&lceil;", 8968),
//        ("&rceil;", 8969),
//        ("&lfloor;", 8970),
//        ("&rfloor;", 8971),
//        ("&lang;", 9001),
//        ("&rang;", 9002),
//        ("&loz;", 9674),
//        ("&spades;", 9824),
//        ("&clubs;", 9827),
//        ("&hearts;", 9829),
//        ("&diams;", 9830)
//    ]
//    // Taken from http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
//    // This is table A.2.2 Special Characters
//    private var gUnicodeHTMLEscapeMap = [
//        // C0 Controls and Basic Latin
//        ("&quot;", 34),
//        ("&amp;", 38),
//        ("&apos;", 39),
//        ("&lt;", 60),
//        ("&gt;", 62),
//        // Latin Extended-A
//        ("&OElig;", 338),
//        ("&oelig;", 339),
//        ("&Scaron;", 352),
//        ("&scaron;", 353),
//        ("&Yuml;", 376),
//        // Spacing Modifier Letters
//        ("&circ;", 710),
//        ("&tilde;", 732),
//        // General Punctuation
//        ("&ensp;", 8194),
//        ("&emsp;", 8195),
//        ("&thinsp;", 8201),
//        ("&zwnj;", 8204),
//        ("&zwj;", 8205),
//        ("&lrm;", 8206),
//        ("&rlm;", 8207),
//        ("&ndash;", 8211),
//        ("&mdash;", 8212),
//        ("&lsquo;", 8216),
//        ("&rsquo;", 8217),
//        ("&sbquo;", 8218),
//        ("&ldquo;", 8220),
//        ("&rdquo;", 8221),
//        ("&bdquo;", 8222),
//        ("&dagger;", 8224),
//        ("&Dagger;", 8225),
//        ("&permil;", 8240),
//        ("&lsaquo;", 8249),
//        ("&rsaquo;", 8250),
//        ("&euro;", 8364)
//    ]
//
//
//        func gtm_stringByEscapingHTML(usingTable table: HTMLEscapeMap?, ofSize size: Int, escapingUnicode escapeUnicode: Bool) -> String? {
//            let length: Int = count
//            if length == 0 {
//                return self as String
//            }
//            var finalString = ""
//            var data2 = Data(capacity: MemoryLayout<unichar>.size * length)
//            // this block is common between GTMNSString+HTML and GTMNSString+XML but
//            // it's so short that it isn't really worth trying to share.
//            let buffer = CFStringGetCharactersPtr(self as CFString?)
//            #if false
//            if !buffer {
//                // We want this buffer to be autoreleased.
//                var data = Data(length: length * MemoryLayout<UniChar>.size)
//                if data == nil {
//                    // COV_NF_START  - Memory fail case
//                    //_GTMDevLog(@"couldn't alloc buffer");
//                    return nil
//                    // COV_NF_END
//                }
//                (self as NSString).getCharacters(data?.mutableBytes)
//                if let aBytes = data?.bytes {
//                    buffer = aBytes
//                }
//            }
//            #endif
//            if data2 == nil {
//                // COV_NF_START
//                //_GTMDevLog(@"Unable to allocate buffer or data2");
//                return nil
//                // COV_NF_END
//            }
//            let buffer2 = unichar(data2.mutableBytes ?? 0) as? [unichar]
//            var buffer2Length: Int = 0
//            for i in 0..<length {
//                let val: HTMLEscapeMap? = bsearch(&buffer![i], table, size / MemoryLayout<HTMLEscapeMap>.size, MemoryLayout<HTMLEscapeMap>.size, EscapeMapCompare)
//                if val != nil || (escapeUnicode && buffer![i] > 127) {
//                    if buffer2Length != 0 {
//                        CFStringAppendCharacters(finalString as? CFMutableString?, buffer2, buffer2Length)
//                        buffer2Length = 0
//                    }
//                    if val != nil {
//                        finalString += val?.escapeSequence ?? ""
//                    } else {
//                        //_GTMDevAssert(escapeUnicode && buffer[i] > 127, @"Illegal Character");
//                        finalString += "&#\(buffer![i]);"
//                    }
//                } else {
//                    buffer2?[buffer2Length] = buffer[i]
//                    buffer2Length += 1
//                }
//            }
//            if buffer2Length != 0 {
//                CFStringAppendCharacters(finalString as? CFMutableString?, buffer2, buffer2Length)
//            }
//            return finalString
//        }
//        func gtm_stringByEscapingForHTML() -> String? {
//            return gtm_stringByEscapingHTML(usingTable: gUnicodeHTMLEscapeMap, ofSize: MemoryLayout<gUnicodeHTMLEscapeMap>.size, escapingUnicode: false)
//            // gtm_stringByEscapingHTML
//        }
//        func gtm_stringByEscapingForAsciiHTML() -> String? {
//            return gtm_stringByEscapingHTML(usingTable: gAsciiHTMLEscapeMap, ofSize: MemoryLayout<gAsciiHTMLEscapeMap>.size, escapingUnicode: true)
//            // gtm_stringByEscapingAsciiHTML
//        }
//        func gtm_stringByUnescapingFromHTML() -> String? {
//            var range = NSRange(location: 0, length: count)
//            var subrange: NSRange = (self as NSString).range(of: "&", options: .backwards, range: range)
//            // if no ampersands, we've got a quick way out
//            if Int(subrange.length) == 0 {
//                return self as String
//            }
//            var finalString = self as String
//            repeat {
//                var semiColonRange = NSRange(location: Int(subrange.location), length: Int(NSMaxRange(range) - subrange.location))
//                semiColonRange = (self as NSString).range(of: ";", options: [], range: semiColonRange)
//                range = NSRange(location: 0, length: Int(subrange.location))
//                // if we don't find a semicolon in the range, we don't have a sequence
//                if Int(semiColonRange.location) == NSNotFound {
//                    continue
//                }
//                let escapeRange = NSRange(location: Int(subrange.location), length: Int(semiColonRange.location - subrange.location) + 1)
//                let escapeString = (self as NSString).substring(with: escapeRange)
//                let length: Int = escapeString.count
//                // a squence must be longer than 3 (&lt;) and less than 11 (&thetasym;)
//                if length > 3 && length < 11 {
//                    if escapeString[escapeString.index(escapeString.startIndex, offsetBy: 1)] == "#" {
//                        let char2 = unichar(escapeString[escapeString.index(escapeString.startIndex, offsetBy: 2)])
//                        if char2 == "x" || char2 == "X" {
//                            // Hex escape squences &#xa3;
//                            let hexSequence = (escapeString as NSString).substring(with: NSRange(location: 3, length: length - 4))
//                            let scanner = Scanner(string: hexSequence)
//                            var value: UInt
//                            if scanner.scanHexInt32(&value) && value < USHRT_MAX && Int(value) > 0 && scanner.scanLocation == length - 4 {
//                                var uchar = unichar(value)
//                                let charString = String(characters: &uchar)
//                                if let subRange = Range<String.Index>(escapeRange, in: finalString) { finalString.replaceSubrange(subRange, with: charString) }
//                            }
//                        } else {
//                            // Decimal Sequences &#123;
//                            let numberSequence = (escapeString as NSString).substring(with: NSRange(location: 2, length: length - 3))
//                            let scanner = Scanner(string: numberSequence)
//                            var value: Int
//                            if scanner.scanInt32(&value) && value < USHRT_MAX && value > 0 && scanner.scanLocation == length - 3 {
//                                var uchar = unichar(value)
//                                let charString = String(characters: &uchar)
//                                if let subRange = Range<String.Index>(escapeRange, in: finalString) { finalString.replaceSubrange(subRange, with: charString) }
//                            }
//                        }
//                    } else {
//                        // "standard" sequences
//                        for i in 0..<MemoryLayout<gAsciiHTMLEscapeMap>.size / MemoryLayout<HTMLEscapeMap>.size {
//                            if (escapeString == gAsciiHTMLEscapeMap[i].escapeSequence) {
//                                if let subRange = Range<String.Index>(escapeRange, in: finalString) { finalString.replaceSubrange(subRange, with: String(characters: &gAsciiHTMLEscapeMap[i].uchar)) }
//                                break
//                            }
//                        }
//                    }
//                }
//            } while Int((subrange = (self as NSString).range(of: "&", options: .backwards, range: range)).length) != 0
//            return finalString
//            // gtm_stringByUnescapingHTML
//        }
//}
//}
////    }
////    // Utility function for Bsearching table above
////    private func EscapeMapCompare(ucharVoid: UnsafeRawPointer?, mapVoid: UnsafeRawPointer?) -> Int {
////        let uchar = unichar(ucharVoid ?? 0) as? [unichar]
////        let map = mapVoid as? HTMLEscapeMap
////        var val: Int
////        if let anUchar = uchar, let anUchar1 = map?.uchar {
////            if anUchar > anUchar1 {
////                val = 1
////            } else if anUchar < anUchar {
////                val = -1
////            } else {
////                val = 0
////            }
////        }
////        return val
////}
////
////}
