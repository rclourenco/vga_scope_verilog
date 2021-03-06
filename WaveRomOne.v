module WaveRomOne(
	input wire [9:0] address,
	output reg [8:0] data
	);

always @(address)
begin
    case (address)
            0: data = 9'h0FF;
            1: data = 9'h105;
            2: data = 9'h10B;
            3: data = 9'h111;
            4: data = 9'h117;
            5: data = 9'h11E;
            6: data = 9'h124;
            7: data = 9'h12A;
            8: data = 9'h130;
            9: data = 9'h136;
           10: data = 9'h13C;
           11: data = 9'h143;
           12: data = 9'h149;
           13: data = 9'h14E;
           14: data = 9'h154;
           15: data = 9'h15A;
           16: data = 9'h160;
           17: data = 9'h166;
           18: data = 9'h16C;
           19: data = 9'h171;
           20: data = 9'h177;
           21: data = 9'h17C;
           22: data = 9'h182;
           23: data = 9'h187;
           24: data = 9'h18C;
           25: data = 9'h191;
           26: data = 9'h196;
           27: data = 9'h19B;
           28: data = 9'h1A0;
           29: data = 9'h1A5;
           30: data = 9'h1AA;
           31: data = 9'h1AE;
           32: data = 9'h1B3;
           33: data = 9'h1B7;
           34: data = 9'h1BB;
           35: data = 9'h1C0;
           36: data = 9'h1C4;
           37: data = 9'h1C8;
           38: data = 9'h1CB;
           39: data = 9'h1CF;
           40: data = 9'h1D3;
           41: data = 9'h1D6;
           42: data = 9'h1D9;
           43: data = 9'h1DC;
           44: data = 9'h1DF;
           45: data = 9'h1E2;
           46: data = 9'h1E5;
           47: data = 9'h1E8;
           48: data = 9'h1EA;
           49: data = 9'h1EC;
           50: data = 9'h1EF;
           51: data = 9'h1F1;
           52: data = 9'h1F3;
           53: data = 9'h1F4;
           54: data = 9'h1F6;
           55: data = 9'h1F7;
           56: data = 9'h1F9;
           57: data = 9'h1FA;
           58: data = 9'h1FB;
           59: data = 9'h1FC;
           60: data = 9'h1FC;
           61: data = 9'h1FD;
           62: data = 9'h1FD;
           63: data = 9'h1FD;
           64: data = 9'h1FE;
           65: data = 9'h1FD;
           66: data = 9'h1FD;
           67: data = 9'h1FD;
           68: data = 9'h1FC;
           69: data = 9'h1FC;
           70: data = 9'h1FB;
           71: data = 9'h1FA;
           72: data = 9'h1F9;
           73: data = 9'h1F7;
           74: data = 9'h1F6;
           75: data = 9'h1F4;
           76: data = 9'h1F3;
           77: data = 9'h1F1;
           78: data = 9'h1EF;
           79: data = 9'h1EC;
           80: data = 9'h1EA;
           81: data = 9'h1E8;
           82: data = 9'h1E5;
           83: data = 9'h1E2;
           84: data = 9'h1DF;
           85: data = 9'h1DC;
           86: data = 9'h1D9;
           87: data = 9'h1D6;
           88: data = 9'h1D3;
           89: data = 9'h1CF;
           90: data = 9'h1CB;
           91: data = 9'h1C8;
           92: data = 9'h1C4;
           93: data = 9'h1C0;
           94: data = 9'h1BB;
           95: data = 9'h1B7;
           96: data = 9'h1B3;
           97: data = 9'h1AE;
           98: data = 9'h1AA;
           99: data = 9'h1A5;
          100: data = 9'h1A0;
          101: data = 9'h19B;
          102: data = 9'h196;
          103: data = 9'h191;
          104: data = 9'h18C;
          105: data = 9'h187;
          106: data = 9'h182;
          107: data = 9'h17C;
          108: data = 9'h177;
          109: data = 9'h171;
          110: data = 9'h16C;
          111: data = 9'h166;
          112: data = 9'h160;
          113: data = 9'h15A;
          114: data = 9'h154;
          115: data = 9'h14E;
          116: data = 9'h149;
          117: data = 9'h143;
          118: data = 9'h13C;
          119: data = 9'h136;
          120: data = 9'h130;
          121: data = 9'h12A;
          122: data = 9'h124;
          123: data = 9'h11E;
          124: data = 9'h117;
          125: data = 9'h111;
          126: data = 9'h10B;
          127: data = 9'h105;
          128: data = 9'h0FF;
          129: data = 9'h0F8;
          130: data = 9'h0F2;
          131: data = 9'h0EC;
          132: data = 9'h0E6;
          133: data = 9'h0DF;
          134: data = 9'h0D9;
          135: data = 9'h0D3;
          136: data = 9'h0CD;
          137: data = 9'h0C7;
          138: data = 9'h0C1;
          139: data = 9'h0BA;
          140: data = 9'h0B4;
          141: data = 9'h0AF;
          142: data = 9'h0A9;
          143: data = 9'h0A3;
          144: data = 9'h09D;
          145: data = 9'h097;
          146: data = 9'h091;
          147: data = 9'h08C;
          148: data = 9'h086;
          149: data = 9'h081;
          150: data = 9'h07B;
          151: data = 9'h076;
          152: data = 9'h071;
          153: data = 9'h06C;
          154: data = 9'h067;
          155: data = 9'h062;
          156: data = 9'h05D;
          157: data = 9'h058;
          158: data = 9'h053;
          159: data = 9'h04F;
          160: data = 9'h04A;
          161: data = 9'h046;
          162: data = 9'h042;
          163: data = 9'h03D;
          164: data = 9'h039;
          165: data = 9'h035;
          166: data = 9'h032;
          167: data = 9'h02E;
          168: data = 9'h02A;
          169: data = 9'h027;
          170: data = 9'h024;
          171: data = 9'h021;
          172: data = 9'h01E;
          173: data = 9'h01B;
          174: data = 9'h018;
          175: data = 9'h015;
          176: data = 9'h013;
          177: data = 9'h011;
          178: data = 9'h00E;
          179: data = 9'h00C;
          180: data = 9'h00A;
          181: data = 9'h009;
          182: data = 9'h007;
          183: data = 9'h006;
          184: data = 9'h004;
          185: data = 9'h003;
          186: data = 9'h002;
          187: data = 9'h001;
          188: data = 9'h001;
          189: data = 9'h000;
          190: data = 9'h000;
          191: data = 9'h000;
          192: data = 9'h000;
          193: data = 9'h000;
          194: data = 9'h000;
          195: data = 9'h000;
          196: data = 9'h001;
          197: data = 9'h001;
          198: data = 9'h002;
          199: data = 9'h003;
          200: data = 9'h004;
          201: data = 9'h006;
          202: data = 9'h007;
          203: data = 9'h009;
          204: data = 9'h00A;
          205: data = 9'h00C;
          206: data = 9'h00E;
          207: data = 9'h011;
          208: data = 9'h013;
          209: data = 9'h015;
          210: data = 9'h018;
          211: data = 9'h01B;
          212: data = 9'h01E;
          213: data = 9'h021;
          214: data = 9'h024;
          215: data = 9'h027;
          216: data = 9'h02A;
          217: data = 9'h02E;
          218: data = 9'h032;
          219: data = 9'h035;
          220: data = 9'h039;
          221: data = 9'h03D;
          222: data = 9'h042;
          223: data = 9'h046;
          224: data = 9'h04A;
          225: data = 9'h04F;
          226: data = 9'h053;
          227: data = 9'h058;
          228: data = 9'h05D;
          229: data = 9'h062;
          230: data = 9'h067;
          231: data = 9'h06C;
          232: data = 9'h071;
          233: data = 9'h076;
          234: data = 9'h07B;
          235: data = 9'h081;
          236: data = 9'h086;
          237: data = 9'h08C;
          238: data = 9'h091;
          239: data = 9'h097;
          240: data = 9'h09D;
          241: data = 9'h0A3;
          242: data = 9'h0A9;
          243: data = 9'h0AF;
          244: data = 9'h0B4;
          245: data = 9'h0BA;
          246: data = 9'h0C1;
          247: data = 9'h0C7;
          248: data = 9'h0CD;
          249: data = 9'h0D3;
          250: data = 9'h0D9;
          251: data = 9'h0DF;
          252: data = 9'h0E6;
          253: data = 9'h0EC;
          254: data = 9'h0F2;
          255: data = 9'h0F8;
          256: data = 9'h0FE;
          257: data = 9'h105;
          258: data = 9'h10B;
          259: data = 9'h111;
          260: data = 9'h117;
          261: data = 9'h11E;
          262: data = 9'h124;
          263: data = 9'h12A;
          264: data = 9'h130;
          265: data = 9'h136;
          266: data = 9'h13C;
          267: data = 9'h143;
          268: data = 9'h149;
          269: data = 9'h14E;
          270: data = 9'h154;
          271: data = 9'h15A;
          272: data = 9'h160;
          273: data = 9'h166;
          274: data = 9'h16C;
          275: data = 9'h171;
          276: data = 9'h177;
          277: data = 9'h17C;
          278: data = 9'h182;
          279: data = 9'h187;
          280: data = 9'h18C;
          281: data = 9'h191;
          282: data = 9'h196;
          283: data = 9'h19B;
          284: data = 9'h1A0;
          285: data = 9'h1A5;
          286: data = 9'h1AA;
          287: data = 9'h1AE;
          288: data = 9'h1B3;
          289: data = 9'h1B7;
          290: data = 9'h1BB;
          291: data = 9'h1C0;
          292: data = 9'h1C4;
          293: data = 9'h1C8;
          294: data = 9'h1CB;
          295: data = 9'h1CF;
          296: data = 9'h1D3;
          297: data = 9'h1D6;
          298: data = 9'h1D9;
          299: data = 9'h1DC;
          300: data = 9'h1DF;
          301: data = 9'h1E2;
          302: data = 9'h1E5;
          303: data = 9'h1E8;
          304: data = 9'h1EA;
          305: data = 9'h1EC;
          306: data = 9'h1EF;
          307: data = 9'h1F1;
          308: data = 9'h1F3;
          309: data = 9'h1F4;
          310: data = 9'h1F6;
          311: data = 9'h1F7;
          312: data = 9'h1F9;
          313: data = 9'h1FA;
          314: data = 9'h1FB;
          315: data = 9'h1FC;
          316: data = 9'h1FC;
          317: data = 9'h1FD;
          318: data = 9'h1FD;
          319: data = 9'h1FD;
          320: data = 9'h1FE;
          321: data = 9'h1FD;
          322: data = 9'h1FD;
          323: data = 9'h1FD;
          324: data = 9'h1FC;
          325: data = 9'h1FC;
          326: data = 9'h1FB;
          327: data = 9'h1FA;
          328: data = 9'h1F9;
          329: data = 9'h1F7;
          330: data = 9'h1F6;
          331: data = 9'h1F4;
          332: data = 9'h1F3;
          333: data = 9'h1F1;
          334: data = 9'h1EF;
          335: data = 9'h1EC;
          336: data = 9'h1EA;
          337: data = 9'h1E8;
          338: data = 9'h1E5;
          339: data = 9'h1E2;
          340: data = 9'h1DF;
          341: data = 9'h1DC;
          342: data = 9'h1D9;
          343: data = 9'h1D6;
          344: data = 9'h1D3;
          345: data = 9'h1CF;
          346: data = 9'h1CB;
          347: data = 9'h1C8;
          348: data = 9'h1C4;
          349: data = 9'h1C0;
          350: data = 9'h1BB;
          351: data = 9'h1B7;
          352: data = 9'h1B3;
          353: data = 9'h1AE;
          354: data = 9'h1AA;
          355: data = 9'h1A5;
          356: data = 9'h1A0;
          357: data = 9'h19B;
          358: data = 9'h196;
          359: data = 9'h191;
          360: data = 9'h18C;
          361: data = 9'h187;
          362: data = 9'h182;
          363: data = 9'h17C;
          364: data = 9'h177;
          365: data = 9'h171;
          366: data = 9'h16C;
          367: data = 9'h166;
          368: data = 9'h160;
          369: data = 9'h15A;
          370: data = 9'h154;
          371: data = 9'h14E;
          372: data = 9'h149;
          373: data = 9'h143;
          374: data = 9'h13C;
          375: data = 9'h136;
          376: data = 9'h130;
          377: data = 9'h12A;
          378: data = 9'h124;
          379: data = 9'h11E;
          380: data = 9'h117;
          381: data = 9'h111;
          382: data = 9'h10B;
          383: data = 9'h105;
          384: data = 9'h0FF;
          385: data = 9'h0F8;
          386: data = 9'h0F2;
          387: data = 9'h0EC;
          388: data = 9'h0E6;
          389: data = 9'h0DF;
          390: data = 9'h0D9;
          391: data = 9'h0D3;
          392: data = 9'h0CD;
          393: data = 9'h0C7;
          394: data = 9'h0C1;
          395: data = 9'h0BA;
          396: data = 9'h0B4;
          397: data = 9'h0AF;
          398: data = 9'h0A9;
          399: data = 9'h0A3;
          400: data = 9'h09D;
          401: data = 9'h097;
          402: data = 9'h091;
          403: data = 9'h08C;
          404: data = 9'h086;
          405: data = 9'h081;
          406: data = 9'h07B;
          407: data = 9'h076;
          408: data = 9'h071;
          409: data = 9'h06C;
          410: data = 9'h067;
          411: data = 9'h062;
          412: data = 9'h05D;
          413: data = 9'h058;
          414: data = 9'h053;
          415: data = 9'h04F;
          416: data = 9'h04A;
          417: data = 9'h046;
          418: data = 9'h042;
          419: data = 9'h03D;
          420: data = 9'h039;
          421: data = 9'h035;
          422: data = 9'h032;
          423: data = 9'h02E;
          424: data = 9'h02A;
          425: data = 9'h027;
          426: data = 9'h024;
          427: data = 9'h021;
          428: data = 9'h01E;
          429: data = 9'h01B;
          430: data = 9'h018;
          431: data = 9'h015;
          432: data = 9'h013;
          433: data = 9'h011;
          434: data = 9'h00E;
          435: data = 9'h00C;
          436: data = 9'h00A;
          437: data = 9'h009;
          438: data = 9'h007;
          439: data = 9'h006;
          440: data = 9'h004;
          441: data = 9'h003;
          442: data = 9'h002;
          443: data = 9'h001;
          444: data = 9'h001;
          445: data = 9'h000;
          446: data = 9'h000;
          447: data = 9'h000;
          448: data = 9'h000;
          449: data = 9'h000;
          450: data = 9'h000;
          451: data = 9'h000;
          452: data = 9'h001;
          453: data = 9'h001;
          454: data = 9'h002;
          455: data = 9'h003;
          456: data = 9'h004;
          457: data = 9'h006;
          458: data = 9'h007;
          459: data = 9'h009;
          460: data = 9'h00A;
          461: data = 9'h00C;
          462: data = 9'h00E;
          463: data = 9'h011;
          464: data = 9'h013;
          465: data = 9'h015;
          466: data = 9'h018;
          467: data = 9'h01B;
          468: data = 9'h01E;
          469: data = 9'h021;
          470: data = 9'h024;
          471: data = 9'h027;
          472: data = 9'h02A;
          473: data = 9'h02E;
          474: data = 9'h032;
          475: data = 9'h035;
          476: data = 9'h039;
          477: data = 9'h03D;
          478: data = 9'h042;
          479: data = 9'h046;
          480: data = 9'h04A;
          481: data = 9'h04F;
          482: data = 9'h053;
          483: data = 9'h058;
          484: data = 9'h05D;
          485: data = 9'h062;
          486: data = 9'h067;
          487: data = 9'h06C;
          488: data = 9'h071;
          489: data = 9'h076;
          490: data = 9'h07B;
          491: data = 9'h081;
          492: data = 9'h086;
          493: data = 9'h08C;
          494: data = 9'h091;
          495: data = 9'h097;
          496: data = 9'h09D;
          497: data = 9'h0A3;
          498: data = 9'h0A9;
          499: data = 9'h0AF;
          500: data = 9'h0B4;
          501: data = 9'h0BA;
          502: data = 9'h0C1;
          503: data = 9'h0C7;
          504: data = 9'h0CD;
          505: data = 9'h0D3;
          506: data = 9'h0D9;
          507: data = 9'h0DF;
          508: data = 9'h0E6;
          509: data = 9'h0EC;
          510: data = 9'h0F2;
          511: data = 9'h0F8;
          512: data = 9'h0FE;
          513: data = 9'h105;
          514: data = 9'h10B;
          515: data = 9'h111;
          516: data = 9'h117;
          517: data = 9'h11E;
          518: data = 9'h124;
          519: data = 9'h12A;
          520: data = 9'h130;
          521: data = 9'h136;
          522: data = 9'h13C;
          523: data = 9'h143;
          524: data = 9'h149;
          525: data = 9'h14E;
          526: data = 9'h154;
          527: data = 9'h15A;
          528: data = 9'h160;
          529: data = 9'h166;
          530: data = 9'h16C;
          531: data = 9'h171;
          532: data = 9'h177;
          533: data = 9'h17C;
          534: data = 9'h182;
          535: data = 9'h187;
          536: data = 9'h18C;
          537: data = 9'h191;
          538: data = 9'h196;
          539: data = 9'h19B;
          540: data = 9'h1A0;
          541: data = 9'h1A5;
          542: data = 9'h1AA;
          543: data = 9'h1AE;
          544: data = 9'h1B3;
          545: data = 9'h1B7;
          546: data = 9'h1BB;
          547: data = 9'h1C0;
          548: data = 9'h1C4;
          549: data = 9'h1C8;
          550: data = 9'h1CB;
          551: data = 9'h1CF;
          552: data = 9'h1D3;
          553: data = 9'h1D6;
          554: data = 9'h1D9;
          555: data = 9'h1DC;
          556: data = 9'h1DF;
          557: data = 9'h1E2;
          558: data = 9'h1E5;
          559: data = 9'h1E8;
          560: data = 9'h1EA;
          561: data = 9'h1EC;
          562: data = 9'h1EF;
          563: data = 9'h1F1;
          564: data = 9'h1F3;
          565: data = 9'h1F4;
          566: data = 9'h1F6;
          567: data = 9'h1F7;
          568: data = 9'h1F9;
          569: data = 9'h1FA;
          570: data = 9'h1FB;
          571: data = 9'h1FC;
          572: data = 9'h1FC;
          573: data = 9'h1FD;
          574: data = 9'h1FD;
          575: data = 9'h1FD;
          576: data = 9'h1FE;
          577: data = 9'h1FD;
          578: data = 9'h1FD;
          579: data = 9'h1FD;
          580: data = 9'h1FC;
          581: data = 9'h1FC;
          582: data = 9'h1FB;
          583: data = 9'h1FA;
          584: data = 9'h1F9;
          585: data = 9'h1F7;
          586: data = 9'h1F6;
          587: data = 9'h1F4;
          588: data = 9'h1F3;
          589: data = 9'h1F1;
          590: data = 9'h1EF;
          591: data = 9'h1EC;
          592: data = 9'h1EA;
          593: data = 9'h1E8;
          594: data = 9'h1E5;
          595: data = 9'h1E2;
          596: data = 9'h1DF;
          597: data = 9'h1DC;
          598: data = 9'h1D9;
          599: data = 9'h1D6;
          600: data = 9'h1D3;
          601: data = 9'h1CF;
          602: data = 9'h1CB;
          603: data = 9'h1C8;
          604: data = 9'h1C4;
          605: data = 9'h1C0;
          606: data = 9'h1BB;
          607: data = 9'h1B7;
          608: data = 9'h1B3;
          609: data = 9'h1AE;
          610: data = 9'h1AA;
          611: data = 9'h1A5;
          612: data = 9'h1A0;
          613: data = 9'h19B;
          614: data = 9'h196;
          615: data = 9'h191;
          616: data = 9'h18C;
          617: data = 9'h187;
          618: data = 9'h182;
          619: data = 9'h17C;
          620: data = 9'h177;
          621: data = 9'h171;
          622: data = 9'h16C;
          623: data = 9'h166;
          624: data = 9'h160;
          625: data = 9'h15A;
          626: data = 9'h154;
          627: data = 9'h14E;
          628: data = 9'h149;
          629: data = 9'h143;
          630: data = 9'h13C;
          631: data = 9'h136;
          632: data = 9'h130;
          633: data = 9'h12A;
          634: data = 9'h124;
          635: data = 9'h11E;
          636: data = 9'h117;
          637: data = 9'h111;
          638: data = 9'h10B;
          639: data = 9'h105;
          640: data = 9'h0FF;
          641: data = 9'h0F8;
          642: data = 9'h0F2;
          643: data = 9'h0EC;
          644: data = 9'h0E6;
          645: data = 9'h0DF;
          646: data = 9'h0D9;
          647: data = 9'h0D3;
          648: data = 9'h0CD;
          649: data = 9'h0C7;
          650: data = 9'h0C1;
          651: data = 9'h0BA;
          652: data = 9'h0B4;
          653: data = 9'h0AF;
          654: data = 9'h0A9;
          655: data = 9'h0A3;
          656: data = 9'h09D;
          657: data = 9'h097;
          658: data = 9'h091;
          659: data = 9'h08C;
          660: data = 9'h086;
          661: data = 9'h081;
          662: data = 9'h07B;
          663: data = 9'h076;
          664: data = 9'h071;
          665: data = 9'h06C;
          666: data = 9'h067;
          667: data = 9'h062;
          668: data = 9'h05D;
          669: data = 9'h058;
          670: data = 9'h053;
          671: data = 9'h04F;
          672: data = 9'h04A;
          673: data = 9'h046;
          674: data = 9'h042;
          675: data = 9'h03D;
          676: data = 9'h039;
          677: data = 9'h035;
          678: data = 9'h032;
          679: data = 9'h02E;
          680: data = 9'h02A;
          681: data = 9'h027;
          682: data = 9'h024;
          683: data = 9'h021;
          684: data = 9'h01E;
          685: data = 9'h01B;
          686: data = 9'h018;
          687: data = 9'h015;
          688: data = 9'h013;
          689: data = 9'h011;
          690: data = 9'h00E;
          691: data = 9'h00C;
          692: data = 9'h00A;
          693: data = 9'h009;
          694: data = 9'h007;
          695: data = 9'h006;
          696: data = 9'h004;
          697: data = 9'h003;
          698: data = 9'h002;
          699: data = 9'h001;
          700: data = 9'h001;
          701: data = 9'h000;
          702: data = 9'h000;
          703: data = 9'h000;
          704: data = 9'h000;
          705: data = 9'h000;
          706: data = 9'h000;
          707: data = 9'h000;
          708: data = 9'h001;
          709: data = 9'h001;
          710: data = 9'h002;
          711: data = 9'h003;
          712: data = 9'h004;
          713: data = 9'h006;
          714: data = 9'h007;
          715: data = 9'h009;
          716: data = 9'h00A;
          717: data = 9'h00C;
          718: data = 9'h00E;
          719: data = 9'h011;
          720: data = 9'h013;
          721: data = 9'h015;
          722: data = 9'h018;
          723: data = 9'h01B;
          724: data = 9'h01E;
          725: data = 9'h021;
          726: data = 9'h024;
          727: data = 9'h027;
          728: data = 9'h02A;
          729: data = 9'h02E;
          730: data = 9'h032;
          731: data = 9'h035;
          732: data = 9'h039;
          733: data = 9'h03D;
          734: data = 9'h042;
          735: data = 9'h046;
          736: data = 9'h04A;
          737: data = 9'h04F;
          738: data = 9'h053;
          739: data = 9'h058;
          740: data = 9'h05D;
          741: data = 9'h062;
          742: data = 9'h067;
          743: data = 9'h06C;
          744: data = 9'h071;
          745: data = 9'h076;
          746: data = 9'h07B;
          747: data = 9'h081;
          748: data = 9'h086;
          749: data = 9'h08C;
          750: data = 9'h091;
          751: data = 9'h097;
          752: data = 9'h09D;
          753: data = 9'h0A3;
          754: data = 9'h0A9;
          755: data = 9'h0AF;
          756: data = 9'h0B4;
          757: data = 9'h0BA;
          758: data = 9'h0C1;
          759: data = 9'h0C7;
          760: data = 9'h0CD;
          761: data = 9'h0D3;
          762: data = 9'h0D9;
          763: data = 9'h0DF;
          764: data = 9'h0E6;
          765: data = 9'h0EC;
          766: data = 9'h0F2;
          767: data = 9'h0F8;
          768: data = 9'h0FE;
          769: data = 9'h105;
          770: data = 9'h10B;
          771: data = 9'h111;
          772: data = 9'h117;
          773: data = 9'h11E;
          774: data = 9'h124;
          775: data = 9'h12A;
          776: data = 9'h130;
          777: data = 9'h136;
          778: data = 9'h13C;
          779: data = 9'h143;
          780: data = 9'h149;
          781: data = 9'h14E;
          782: data = 9'h154;
          783: data = 9'h15A;
          784: data = 9'h160;
          785: data = 9'h166;
          786: data = 9'h16C;
          787: data = 9'h171;
          788: data = 9'h177;
          789: data = 9'h17C;
          790: data = 9'h182;
          791: data = 9'h187;
          792: data = 9'h18C;
          793: data = 9'h191;
          794: data = 9'h196;
          795: data = 9'h19B;
          796: data = 9'h1A0;
          797: data = 9'h1A5;
          798: data = 9'h1AA;
          799: data = 9'h1AE;
          800: data = 9'h1B3;
          801: data = 9'h1B7;
          802: data = 9'h1BB;
          803: data = 9'h1C0;
          804: data = 9'h1C4;
          805: data = 9'h1C8;
          806: data = 9'h1CB;
          807: data = 9'h1CF;
          808: data = 9'h1D3;
          809: data = 9'h1D6;
          810: data = 9'h1D9;
          811: data = 9'h1DC;
          812: data = 9'h1DF;
          813: data = 9'h1E2;
          814: data = 9'h1E5;
          815: data = 9'h1E8;
          816: data = 9'h1EA;
          817: data = 9'h1EC;
          818: data = 9'h1EF;
          819: data = 9'h1F1;
          820: data = 9'h1F3;
          821: data = 9'h1F4;
          822: data = 9'h1F6;
          823: data = 9'h1F7;
          824: data = 9'h1F9;
          825: data = 9'h1FA;
          826: data = 9'h1FB;
          827: data = 9'h1FC;
          828: data = 9'h1FC;
          829: data = 9'h1FD;
          830: data = 9'h1FD;
          831: data = 9'h1FD;
          832: data = 9'h1FE;
          833: data = 9'h1FD;
          834: data = 9'h1FD;
          835: data = 9'h1FD;
          836: data = 9'h1FC;
          837: data = 9'h1FC;
          838: data = 9'h1FB;
          839: data = 9'h1FA;
          840: data = 9'h1F9;
          841: data = 9'h1F7;
          842: data = 9'h1F6;
          843: data = 9'h1F4;
          844: data = 9'h1F3;
          845: data = 9'h1F1;
          846: data = 9'h1EF;
          847: data = 9'h1EC;
          848: data = 9'h1EA;
          849: data = 9'h1E8;
          850: data = 9'h1E5;
          851: data = 9'h1E2;
          852: data = 9'h1DF;
          853: data = 9'h1DC;
          854: data = 9'h1D9;
          855: data = 9'h1D6;
          856: data = 9'h1D3;
          857: data = 9'h1CF;
          858: data = 9'h1CB;
          859: data = 9'h1C8;
          860: data = 9'h1C4;
          861: data = 9'h1C0;
          862: data = 9'h1BB;
          863: data = 9'h1B7;
          864: data = 9'h1B3;
          865: data = 9'h1AE;
          866: data = 9'h1AA;
          867: data = 9'h1A5;
          868: data = 9'h1A0;
          869: data = 9'h19B;
          870: data = 9'h196;
          871: data = 9'h191;
          872: data = 9'h18C;
          873: data = 9'h187;
          874: data = 9'h182;
          875: data = 9'h17C;
          876: data = 9'h177;
          877: data = 9'h171;
          878: data = 9'h16C;
          879: data = 9'h166;
          880: data = 9'h160;
          881: data = 9'h15A;
          882: data = 9'h154;
          883: data = 9'h14E;
          884: data = 9'h149;
          885: data = 9'h143;
          886: data = 9'h13C;
          887: data = 9'h136;
          888: data = 9'h130;
          889: data = 9'h12A;
          890: data = 9'h124;
          891: data = 9'h11E;
          892: data = 9'h117;
          893: data = 9'h111;
          894: data = 9'h10B;
          895: data = 9'h105;
          896: data = 9'h0FF;
          897: data = 9'h0F8;
          898: data = 9'h0F2;
          899: data = 9'h0EC;
          900: data = 9'h0E6;
          901: data = 9'h0DF;
          902: data = 9'h0D9;
          903: data = 9'h0D3;
          904: data = 9'h0CD;
          905: data = 9'h0C7;
          906: data = 9'h0C1;
          907: data = 9'h0BA;
          908: data = 9'h0B4;
          909: data = 9'h0AF;
          910: data = 9'h0A9;
          911: data = 9'h0A3;
          912: data = 9'h09D;
          913: data = 9'h097;
          914: data = 9'h091;
          915: data = 9'h08C;
          916: data = 9'h086;
          917: data = 9'h081;
          918: data = 9'h07B;
          919: data = 9'h076;
          920: data = 9'h071;
          921: data = 9'h06C;
          922: data = 9'h067;
          923: data = 9'h062;
          924: data = 9'h05D;
          925: data = 9'h058;
          926: data = 9'h053;
          927: data = 9'h04F;
          928: data = 9'h04A;
          929: data = 9'h046;
          930: data = 9'h042;
          931: data = 9'h03D;
          932: data = 9'h039;
          933: data = 9'h035;
          934: data = 9'h032;
          935: data = 9'h02E;
          936: data = 9'h02A;
          937: data = 9'h027;
          938: data = 9'h024;
          939: data = 9'h021;
          940: data = 9'h01E;
          941: data = 9'h01B;
          942: data = 9'h018;
          943: data = 9'h015;
          944: data = 9'h013;
          945: data = 9'h011;
          946: data = 9'h00E;
          947: data = 9'h00C;
          948: data = 9'h00A;
          949: data = 9'h009;
          950: data = 9'h007;
          951: data = 9'h006;
          952: data = 9'h004;
          953: data = 9'h003;
          954: data = 9'h002;
          955: data = 9'h001;
          956: data = 9'h001;
          957: data = 9'h000;
          958: data = 9'h000;
          959: data = 9'h000;
          960: data = 9'h000;
          961: data = 9'h000;
          962: data = 9'h000;
          963: data = 9'h000;
          964: data = 9'h001;
          965: data = 9'h001;
          966: data = 9'h002;
          967: data = 9'h003;
          968: data = 9'h004;
          969: data = 9'h006;
          970: data = 9'h007;
          971: data = 9'h009;
          972: data = 9'h00A;
          973: data = 9'h00C;
          974: data = 9'h00E;
          975: data = 9'h011;
          976: data = 9'h013;
          977: data = 9'h015;
          978: data = 9'h018;
          979: data = 9'h01B;
          980: data = 9'h01E;
          981: data = 9'h021;
          982: data = 9'h024;
          983: data = 9'h027;
          984: data = 9'h02A;
          985: data = 9'h02E;
          986: data = 9'h032;
          987: data = 9'h035;
          988: data = 9'h039;
          989: data = 9'h03D;
          990: data = 9'h042;
          991: data = 9'h046;
          992: data = 9'h04A;
          993: data = 9'h04F;
          994: data = 9'h053;
          995: data = 9'h058;
          996: data = 9'h05D;
          997: data = 9'h062;
          998: data = 9'h067;
          999: data = 9'h06C;
         1000: data = 9'h071;
         1001: data = 9'h076;
         1002: data = 9'h07B;
         1003: data = 9'h081;
         1004: data = 9'h086;
         1005: data = 9'h08C;
         1006: data = 9'h091;
         1007: data = 9'h097;
         1008: data = 9'h09D;
         1009: data = 9'h0A3;
         1010: data = 9'h0A9;
         1011: data = 9'h0AF;
         1012: data = 9'h0B4;
         1013: data = 9'h0BA;
         1014: data = 9'h0C1;
         1015: data = 9'h0C7;
         1016: data = 9'h0CD;
         1017: data = 9'h0D3;
         1018: data = 9'h0D9;
         1019: data = 9'h0DF;
         1020: data = 9'h0E6;
         1021: data = 9'h0EC;
         1022: data = 9'h0F2;
         1023: data = 9'h0F8;
    endcase
end

endmodule
