0 ' minimal fixes made for GW-BASIC, PC-BASIC, QBASIC, QB45, PTBASIC, PTBASCOM, QB64 & QB64PE
1 ' CLEAR ,,2048:KEY OFF: ' comment out this line for PB35 and mybasic
2 Clear
3 Cls: Color 0, 3: Locate 1, 6: Print Space$(68)
4 Locate 2, 6: Print " ********* Chess *********   By: M. C. Rakaska, Ides of March, 1980 "
5 Locate 3, 6: Print Space$(68): Locate 4, 6: Print "      Adapted for the IBM PC by  S. W. Huggins, December, 1981      "
6 Locate 5, 6: Print " Fixed for GW-BASIC, QBASIC, QB45, PTBASIC, PTBASCOM, QB64 & QB64PE "
7 Locate 6, 6: Print "                       by Peter McGavin, 2025                       "
8 Locate 7, 6: Print Space$(68): Locate 8, 6: Print "                 Chess example for MiniVMDOS PTBasic                "
9 Locate 9, 6: Print "                        www.wiki.ptsource.eu                        "
12 Locate 10, 6: Print Space$(68): Locate 11, 6: Print "          +++++++++++Enjoy and happy coding++++++++++++++           "
13 Locate 12, 6: Print Space$(68)
20 DefInt A-Z: A = 0: B = 0: X = 0: Y = 0: S = 0: A0 = 0: T = 0: A8 = 0: A1 = 0: A2 = 0: A3 = 0: A4 = 0: B1 = 0: B6! = 0: H = 0: M = 0: N = 0: P = 0: W = 0: A5 = 0: I = 1
22 Dim C(64), A(10, 10), B(10, 10), T(10, 10), S(8, 8)
25 Color 7, 0: Locate 18, 1: Print "Important:  Use Caps Lock key to shift to UPPER CASE before continuing...."
30 Locate 21, 1: Input "DO YOU WANT INSTRUCTIONS "; I$: I$ = Left$(I$, 1): If I$ = "Y" Then GoSub 2220
40 CL$ = "N"
50 Cls: Input "YOUR NAME IS "; B$: If B$ = "" Then B$ = " HUMAN " Else B$ = Left$(B$, 9)
60 Cls: Print "LEVEL OF PLAY";: Input B8!: If B8! = 0 Then B8! = 1: B7! = 1 + Rnd(1) / 2: Else B7! = (B8! + 1) / 2 + Rnd(1) / 2
70 Cls: Print "DO YOU WANT WHITE "; B$; " ";: Input C$: GoSub 790: If Left$(C$, 1) <> "N" Then GoSub 900: GoTo 190
80 GoSub 890: If CL$ = "Y" Then Locate 25, 6, 0: Print "START "; Time$;
100 F! = -99: A0 = 0: For J = 1 To 8: For K = 1 To 8: If A(J, K) = 99 Then A6 = J: A7 = K
110 Next: Next
120 For X = 1 To 8: For Y = 1 To 8: If A(X, Y) < 0 Then GoSub 270: If F! >= B7! Then GoTo 150
130 Next: Next: If F! >= -9 Then GoTo 150 Else GoSub 900
140 Locate 25, 62, 0: Print "I CONCEED    ";: GoTo 2190
150 A(R, U) = A(E, Q): A(E, Q) = 1: If A(R, U) = -2 And U = 1 Then A(R, U) = -9
160 X = R: Y = U: A0 = 4: GoSub 270: Locate 25, 62, 0: Print "IS MY MOVE    ";: Locate 25, 51, 0: Print Chr$(E + 64); Q; "- "; Chr$(R + 64); U;
170 If CL$ = "Y" Then Locate 25, 31, 0: Print "STOP "; Time$;
180 X = E: Y = Q: GoSub 910: X = R: Y = U: GoSub 910: If C = 1 Then Locate 24, 1, 1: Print "CHECK ";: C = 0 Else Locate 24, 1, 1: Print "      ";
190 If X$ = "S" Then GoSub 1830: B7! = 3 * Rnd(1): Locate 25, 1, 1: Print "SELF-PLAYING";: GoSub 2480: GoTo 100
195 Locate 25, 1, 1: Print "MOVE " + Chr$(7); B$;: GoSub 1590: D = 0: B4 = A: B9 = B: B5 = 0: If A(X, Y) = 2 And Y = 5 And B = 6 And A(A, B) = 1 And Abs(A - X) = 1 Then B5 = 1: GoTo 220
200 If X$ = "K" Or X$ = "Q" Then GoSub 900: Locate 25, 1, 0: Print String$(14, " ");: GoTo 100
210 If X$ = "S" Then CL$ = "N": GoTo 190: Else A0 = 3: GoSub 250: If D = 0 Then Locate 25, 31, 0: Print "ILLEGAL       ";: GoTo 190
220 Locate 25, 31, 1: Print "OK            ";: A = B4: B = B9: A(A, B) = A(X, Y): A(X, Y) = 1: GoSub 910: X = A: Y = B: GoSub 910: If N$ = "N" Then GoSub 900: N$ = " "
230 If A(A, B) = 2 And B = 8 Then Locate 25, 31, 1: Print "WHAT PIECE";: GoSub 2100: X = A: Y = B: GoSub 910: Locate 25, 31, 1: Print "              ";
240 If B5 = 1 Then A(A, B - 1) = 1: X = A: Y = B - 1: GoSub 910: GoTo 100: Else GoTo 100
250 Locate 1, 78, 0: Print "$ ";: If A(X, Y) > 0 And A(X, Y) <= 9 Then On A(X, Y) GOTO 0, 480, 0, 380, 330, 0, 280, 0, 330 Else GoTo 460
270 If A(X, Y) < 0 And A(X, Y) >= -9 Then On -A(X, Y) GOTO 0, 530, 0, 380, 330, 0, 280, 0, 330 Else GoTo 460
280 B = Y: For A = X + 1 To 8: GoSub 640: If S <> 0 Then GoTo 290
281 Next A
290 For A = X - 1 To 1 Step -1: GoSub 640: If S <> 0 Then GoTo 300
291 Next A
300 A = X: For B = Y + 1 To 8: GoSub 640: If S <> 0 Then GoTo 310
301 Next B
310 For B = Y - 1 To 1 Step -1: GoSub 640: If S <> 0 Then Return
311 Next B: Return
330 B = Y: For A = X + 1 To 8: B = B + 1: GoSub 640: If S <> 0 Then GoTo 340
331 Next A
340 B = Y: For A = X - 1 To 1 Step -1: B = B - 1: GoSub 640: If S <> 0 Then GoTo 350
341 Next A
350 B = Y: For A = X - 1 To 1 Step -1: B = B + 1: GoSub 640: If S <> 0 Then GoTo 360
351 Next A
360 B = Y: For A = X + 1 To 8: B = B - 1: GoSub 640: If S <> 0 Then GoTo 370
361 Next A
370 If Abs(A(X, Y)) = 9 Then GoTo 280: Else Return
380 A = X + 2: B = Y + 1: If A < 9 And B < 9 Then GoSub 650 Else GoTo 390
390 B = B - 2: If B > 0 And A < 9 Then GoSub 650 Else GoTo 400
400 A = A - 4: If A > 0 And B > 0 Then GoSub 650 Else GoTo 410
410 B = B + 2: If B < 9 And A > 0 Then GoSub 650 Else GoTo 420
420 A = A + 1: B = B + 1: If A > 0 And A < 9 And B < 9 Then GoSub 650 Else GoTo 430
430 B = B - 4: If B > 0 And A > 0 And A < 9 Then GoSub 650 Else GoTo 440
440 A = A + 2: If A > 0 And A < 9 And B > 0 Then GoSub 650 Else GoTo 450
450 B = B + 4: If B < 9 And A > 0 And A < 9 Then GoSub 650: Return Else Return
460 A = X - 1: B = Y - 1: If A(A, B) <> 0 Then GoSub 650
461 A = X - 1: B = Y: If A(A, B) <> 0 Then GoSub 650
462 A = X - 1: B = Y + 1: If A(A, B) <> 0 Then GoSub 650
463 A = X: B = Y - 1: If A(A, B) <> 0 Then GoSub 650
464 A = X: B = Y + 1: If A(A, B) <> 0 Then GoSub 650
465 A = X + 1: B = Y - 1: If A(A, B) <> 0 Then GoSub 650
466 A = X + 1: B = Y: If A(A, B) <> 0 Then GoSub 650
467 A = X + 1: B = Y + 1: If A(A, B) <> 0 Then GoSub 650
470 Return
480 A = X: If Y > 2 Then GoTo 500 Else GoTo 490
490 B = Y + 1: If A(A, B) = 1 Then GoSub 660: B = B + 1: If A(A, B) = 1 Then GoSub 660: GoTo 510: Else GoTo 510: Else GoTo 510
500 B = Y + 1: If A(A, B) = 1 Then GoSub 660 Else GoTo 510
510 A = X + 1: B = Y + 1: If A(A, B) < 0 Then GoSub 660 Else GoTo 520
520 A = A - 2: If A(A, B) < 0 Then GoSub 660: Return: Else Return
530 A = X: If Y < 7 Then GoTo 550 Else GoTo 540
540 B = Y - 1: If A(A, B) = 1 Then GoSub 660: B = B - 1: If A(A, B) = 1 Then GoSub 660: GoTo 560: Else GoTo 560: Else GoTo 560
550 B = Y - 1: If A(A, B) = 1 Then GoSub 660 Else GoTo 560
560 A = X - 1: B = Y - 1: If A(A, B) > 1 Then GoSub 660 Else GoTo 570
570 A = A + 2: If A(A, B) > 1 Then GoSub 660: Return: Else GoTo 590
580 T = A(A, B): If T = -99 Then B1 = T: Return: Else GoTo 590
590 A5 = S: If Abs(T) <= A(X, Y) Then A(A, B) = A(X, Y): A(X, Y) = 1: GoTo 610: Else GoTo 600
600 If T < B1 Then B1 = T: S = A5: Return: Else S = A5: Return
610 A1 = X: A2 = Y: A3 = A: A4 = B: A8 = T: A0 = 2: For X = 1 To 8: For Y = 1 To 8: If A(X, Y) < 0 Then GoSub 270: If T = 0 Then GoTo 630
620 Next: Next
630 X = A1: Y = A2: A = A3: B = A4: A0 = 5: A(X, Y) = A(A, B): A(A, B) = A8: GoTo 600
640 S = 0: If A(A, B) = 1 Then GoTo 660 Else If A(A, B) = 0 Then S = 1: Return: Else If Sgn(A(A, B)) = Sgn(A(X, Y)) Then S = 1: Return: Else S = 1: GoTo 660
650 If A(A, B) = 1 Then GoTo 660 Else If Sgn(A(A, B)) = Sgn(A(X, Y)) Then Return: Else GoTo 660
660 Locate 1, 78, 0: Print "  ";: If A0 > 0 And A0 <= 5 Then On A0 GOTO 670, 680, 690, 700, 710 Else GoTo 720
670 If A6 = A And A7 = B Then B1 = B1 + 1: Return: Else Return
680 If A3 = A And A4 = B Then T = 0: Return: Else Return
690 If B4 = A And B9 = B Then D = 1: Return: Else Return
700 If A6 = A And A7 = B Then C = 1: Return: Else Return
710 If A(A, B) < 0 Then GoTo 580 Else Return
720 B3 = S: W = X: M = Y: N = A: H = B: P = A(A, B): A(A, B) = A(X, Y): A(X, Y) = 1: B1 = 0
730 A0 = 5: For X = 1 To 8: For Y = 1 To 8: If A(X, Y) > 1 Then GoSub 250
740 Next: Next: X = N: Y = H: A0 = 1: GoSub 270: A0 = 0: S = B3: X = W: Y = M: A = N: B = H: A(X, Y) = A(A, B): A(A, B) = P
750 B6! = 1 / (Abs(4.5 - A) + Abs(4.5 - B) + 1): If A(X, Y) < -2 And A(X, Y) > -9 Then B6! = B6! + 1 / (Abs(A6 - A) + Abs(A7 - B) + 5) + Rnd(1) / 15
760 G! = P + B1 + B6!: If P = 99 Then GoSub 900: Locate 25, 1, 1: Print "MATE "; B$;: GoTo 2190
770 If G! <= F! Then Return
780 F! = G!: E = X: Q = Y: R = A: U = B: Return
790 Cls
800 Y = 0: For J = 896 To 0 Step -128: Y = Y + 1: X = 0: For K = J To 42 + J Step 6: X = X + 1: T(X, Y) = K: Next: Next
810 Y = 0: For J = 960 To 64 Step -128: Y = Y + 1: X = 0: For K = J To 42 + J Step 6: X = X + 1: B(X, Y) = K: Next: Next
820 Data -7,-4,-5,-9,-99,-5,-4,-7
830 Data -2,-2,-2,-2,-2,-2,-2,-2
840 Data 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
850 Data 2,2,2,2,2,2,2,2
860 Data 7,4,5,9,99,5,4,7
870 For Y = 8 To 1 Step -1: For X = 1 To 7 Step 2: S(X, Y) = I: S(X + 1, Y) = -I: Next: I = -I: Next
880 For Y = 8 To 1 Step -1: For X = 1 To 8: Read A(X, Y): Next: Next: Return
890 I = -I: A(4, 1) = 99: A(5, 1) = 9: A(4, 8) = -99: A(5, 8) = -9
900 For Y = 1 To 8: For X = 1 To 8: GoSub 910: Next: Next: Return
910 If S(X, Y) > 0 Then GoTo 940
920 If Abs(A(X, Y)) > 0 And Abs(A(X, Y)) <= 9 Then On Abs(A(X, Y)) GOSUB 980, 1040, 0, 1340, 1440, 0, 1540, 0, 1140
921 If Abs(A(X, Y)) = 99 Then GoSub 1240
922 Return
940 If Abs(A(X, Y)) > 0 And Abs(A(X, Y)) <= 9 Then On Abs(A(X, Y)) GOSUB 960, 990, 0, 1290, 1390, 0, 1490, 0, 1090
941 If Abs(A(X, Y)) = 99 Then GoSub 1190
942 Return
960 If S(X, Y) < 0 Then GoTo 980
970 Locate 25 - Y * 3, X * 8 + 1, 0
971 Print String$(8, Chr$(219));
972 Locate 26 - Y * 3, X * 8 + 1, 0
973 Print String$(8, Chr$(219));
974 Locate 27 - Y * 3, X * 8 + 1, 0
975 Print String$(8, Chr$(219));: Return
980 Locate 25 - Y * 3, X * 8 + 1, 0
981 Print String$(8, " ");
982 Locate 26 - Y * 3, X * 8 + 1, 0
983 Print String$(8, " ");
984 Locate 27 - Y * 3, X * 8 + 1, 0
985 Print String$(8, " ");: Return
990 If I * A(X, Y) < 0 Then GoTo 1020
1000 Locate 25 - Y * 3, X * 8 + 1, 0
1001 Print String$(8, Chr$(219));
1010 Locate 26 - Y * 3, X * 8 + 1, 0
1011 Print String$(3, Chr$(219)); Chr$(2); String$(4, Chr$(219));
1012 Locate 27 - Y * 3, X * 8 + 1, 0
1013 Print String$(8, Chr$(219)): Return
1020 Locate 25 - Y * 3, X * 8 + 1, 0
1021 Print String$(8, Chr$(219));
1030 Locate 26 - Y * 3, X * 8 + 1, 0
1031 Print String$(3, Chr$(219)); Chr$(1); String$(4, Chr$(219));
1032 Locate 27 - Y * 3, X * 8 + 1, 0
1033 Print String$(8, Chr$(219));: Return
1040 If I * A(X, Y) < 0 Then GoTo 1070
1050 Locate 25 - Y * 3, X * 8 + 1, 0
1051 Print String$(8, Chr$(32));
1060 Locate 26 - Y * 3, X * 8 + 1, 0
1061 Print String$(3, Chr$(32)); Chr$(2); String$(4, Chr$(32));
1062 Locate 27 - Y * 3, X * 8 + 1, 0
1063 Print String$(8, Chr$(32)): Return
1070 Locate 25 - Y * 3, X * 8 + 1, 0
1071 Print String$(8, Chr$(32));
1080 Locate 26 - Y * 3, X * 8 + 1, 0
1081 Print String$(3, Chr$(32)); Chr$(1); String$(4, Chr$(32));
1082 Locate 27 - Y * 3, X * 8 + 1, 0
1083 Print String$(8, Chr$(32));: Return
1090 If I * A(X, Y) < 0 Then GoTo 1120
1100 Locate 25 - Y * 3, X * 8 + 1, 0
1101 Print String$(2, Chr$(219)); String$(3, Chr$(178)); String$(3, Chr$(219));
1110 Locate 26 - Y * 3, X * 8 + 1, 0
1111 Print Chr$(219) + "QUEEN" + Chr$(219); Chr$(219);
1112 Locate 27 - Y * 3, X * 8 + 1, 0
1113 Print String$(2, Chr$(219)); String$(3, Chr$(178)); String$(3, Chr$(219));: Return
1120 Locate 25 - Y * 3, X * 8 + 1, 0
1121 Print String$(2, Chr$(219)); String$(3, Chr$(176)); String$(3, Chr$(219));
1130 Locate 26 - Y * 3, X * 8 + 1, 0
1131 Print Chr$(219) + "QUEEN" + Chr$(219); Chr$(219);
1132 Locate 27 - Y * 3, X * 8 + 1, 0
1133 Print String$(2, Chr$(219)); String$(3, Chr$(176)); String$(3, Chr$(219));: Return
1140 If I * A(X, Y) < 0 Then GoTo 1170
1150 Locate 25 - Y * 3, X * 8 + 1, 0
1151 Print String$(2, Chr$(32)); String$(3, Chr$(178)); String$(3, Chr$(32));
1160 Locate 26 - Y * 3, X * 8 + 1, 0
1161 Print Chr$(32) + "QUEEN" + Chr$(32); Chr$(32);
1162 Locate 27 - Y * 3, X * 8 + 1, 0
1163 Print String$(2, Chr$(32)); String$(3, Chr$(178)); String$(3, Chr$(32));: Return
1170 Locate 25 - Y * 3, X * 8 + 1, 0
1171 Print String$(2, Chr$(32)); String$(3, Chr$(176)); String$(3, Chr$(32));
1180 Locate 26 - Y * 3, X * 8 + 1, 0
1181 Print Chr$(32) + "QUEEN" + Chr$(32); Chr$(32);
1182 Locate 27 - Y * 3, X * 8 + 1, 0
1183 Print String$(2, Chr$(32)); String$(3, Chr$(176)); String$(3, Chr$(32));: Return
1190 If I * A(X, Y) < 0 Then GoTo 1220
1200 Locate 25 - Y * 3, X * 8 + 1, 0
1201 Print String$(2, Chr$(219)); String$(4, Chr$(178)); String$(2, Chr$(219));
1210 Locate 26 - Y * 3, X * 8 + 1, 0
1211 Print Chr$(219); Chr$(178) + "KING" + Chr$(178); Chr$(219);
1212 Locate 27 - Y * 3, X * 8 + 1, 0
1213 Print String$(2, Chr$(219)); String$(4, Chr$(178)); String$(2, Chr$(219));: Return
1220 Locate 25 - Y * 3, X * 8 + 1, 0
1221 Print String$(2, Chr$(219)); String$(4, Chr$(176)); String$(2, Chr$(219));
1230 Locate 26 - Y * 3, X * 8 + 1, 0
1231 Print Chr$(219); Chr$(176) + "KING" + Chr$(176); Chr$(219);
1232 Locate 27 - Y * 3, X * 8 + 1, 0
1233 Print String$(2, Chr$(219)); String$(4, Chr$(176)); String$(2, Chr$(219));: Return
1240 If I * A(X, Y) < 0 Then GoTo 1270
1250 Locate 25 - Y * 3, X * 8 + 1, 0
1251 Print String$(2, Chr$(32)); String$(4, Chr$(178)); String$(2, Chr$(32));
1260 Locate 26 - Y * 3, X * 8 + 1, 0
1261 Print Chr$(32); Chr$(178) + "KING" + Chr$(178); Chr$(32);
1262 Locate 27 - Y * 3, X * 8 + 1, 0
1263 Print String$(2, Chr$(32)); String$(4, Chr$(178)); String$(2, Chr$(32));: Return
1270 Locate 25 - Y * 3, X * 8 + 1, 0
1271 Print String$(2, Chr$(32)); String$(4, Chr$(176)); String$(2, Chr$(32));
1280 Locate 26 - Y * 3, X * 8 + 1, 0
1281 Print Chr$(32); Chr$(176) + "KING" + Chr$(176); Chr$(32);
1282 Locate 27 - Y * 3, X * 8 + 1, 0
1283 Print String$(2, Chr$(32)); String$(4, Chr$(176)); String$(2, Chr$(32));: Return
1290 If I * A(X, Y) < 0 Then GoTo 1320
1300 Locate 25 - Y * 3, X * 8 + 1, 0
1301 Print String$(3, Chr$(219)); String$(2, Chr$(178)); String$(3, Chr$(219));
1310 Locate 26 - Y * 3, X * 8 + 1, 0
1311 Print Chr$(219) + "KNIGHT" + Chr$(219);
1312 Locate 27 - Y * 3, X * 8 + 1, 0
1313 Print String$(3, Chr$(219)); String$(2, Chr$(178)); String$(3, Chr$(219));: Return
1320 Locate 25 - Y * 3, X * 8 + 1, 0
1321 Print String$(3, Chr$(219)); String$(2, Chr$(176)); String$(3, Chr$(219));
1330 Locate 26 - Y * 3, X * 8 + 1, 0
1331 Print Chr$(219) + "KNIGHT" + Chr$(219);
1332 Locate 27 - Y * 3, X * 8 + 1, 0
1333 Print String$(3, Chr$(219)); String$(2, Chr$(176)); String$(3, Chr$(219));: Return
1340 If I * A(X, Y) < 0 Then GoTo 1370
1350 Locate 25 - Y * 3, X * 8 + 1, 0
1351 Print String$(3, Chr$(32)); String$(2, Chr$(178)); String$(3, Chr$(32));
1360 Locate 26 - Y * 3, X * 8 + 1, 0
1361 Print Chr$(32) + "KNIGHT" + Chr$(32);
1362 Locate 27 - Y * 3, X * 8 + 1, 0
1363 Print String$(3, Chr$(32)); String$(2, Chr$(178)); String$(3, Chr$(32));: Return
1370 Locate 25 - Y * 3, X * 8 + 1, 0
1371 Print String$(3, Chr$(32)); String$(2, Chr$(176)); String$(3, Chr$(32));
1380 Locate 26 - Y * 3, X * 8 + 1, 0
1381 Print Chr$(32) + "KNIGHT" + Chr$(32);
1382 Locate 27 - Y * 3, X * 8 + 1, 0
1383 Print String$(3, Chr$(32)); String$(2, Chr$(176)); String$(3, Chr$(32));: Return
1390 If I * A(X, Y) < 0 Then GoTo 1420
1400 Locate 25 - Y * 3, X * 8 + 1, 0
1401 Print String$(3, Chr$(219)); String$(2, Chr$(178)); String$(3, Chr$(219));
1410 Locate 26 - Y * 3, X * 8 + 1, 0
1411 Print Chr$(219) + "BISHOP" + Chr$(219);
1412 Locate 27 - Y * 3, X * 8 + 1, 0
1413 Print String$(3, Chr$(219)); String$(2, Chr$(178)); String$(3, Chr$(219));: Return
1420 Locate 25 - Y * 3, X * 8 + 1, 0
1421 Print String$(3, Chr$(219)); String$(2, Chr$(176)); String$(3, Chr$(219));
1430 Locate 26 - Y * 3, X * 8 + 1, 0
1431 Print Chr$(219) + "BISHOP" + Chr$(219);
1432 Locate 27 - Y * 3, X * 8 + 1, 0
1433 Print String$(3, Chr$(219)); String$(2, Chr$(176)); String$(3, Chr$(219));: Return
1440 If I * A(X, Y) < 0 Then GoTo 1470
1450 Locate 25 - Y * 3, X * 8 + 1, 0
1451 Print String$(3, Chr$(32)); String$(2, Chr$(178)); String$(3, Chr$(32));
1460 Locate 26 - Y * 3, X * 8 + 1, 0
1461 Print Chr$(32) + "BISHOP" + Chr$(32);
1462 Locate 27 - Y * 3, X * 8 + 1, 0
1463 Print String$(3, Chr$(32)); String$(2, Chr$(178)); String$(3, Chr$(32));: Return
1470 Locate 25 - Y * 3, X * 8 + 1, 0
1471 Print String$(3, Chr$(32)); String$(2, Chr$(176)); String$(3, Chr$(32));
1480 Locate 26 - Y * 3, X * 8 + 1, 0
1481 Print Chr$(32) + "BISHOP" + Chr$(32);
1482 Locate 27 - Y * 3, X * 8 + 1, 0
1483 Print String$(3, Chr$(32)); String$(2, Chr$(176)); String$(3, Chr$(32));: Return
1490 If I * A(X, Y) < 0 Then GoTo 1520
1500 Locate 25 - Y * 3, X * 8 + 1, 0
1501 Print Chr$(219); Chr$(219); Chr$(178); Chr$(219); Chr$(219); Chr$(178); Chr$(219); Chr$(219);
1510 Locate 26 - Y * 3, X * 8 + 1, 0
1511 Print Chr$(219); Chr$(219) + "ROOK" + Chr$(219); Chr$(219);
1512 Locate 27 - Y * 3, X * 8 + 1, 0
1513 Print String$(2, Chr$(219)); String$(4, Chr$(178)); String$(2, Chr$(219));: Return
1520 Locate 25 - Y * 3, X * 8 + 1, 0
1521 Print Chr$(219); Chr$(219); Chr$(176); Chr$(219); Chr$(219); Chr$(176); Chr$(219); Chr$(219);
1530 Locate 26 - Y * 3, X * 8 + 1, 0
1531 Print Chr$(219); Chr$(219) + "ROOK" + Chr$(219); Chr$(219);
1532 Locate 27 - Y * 3, X * 8 + 1, 0
1533 Print String$(2, Chr$(219)); String$(4, Chr$(176)); String$(2, Chr$(219));: Return
1540 If I * A(X, Y) < 0 Then GoTo 1570
1550 Locate 25 - Y * 3, X * 8 + 1, 0
1551 Print Chr$(32); Chr$(32); Chr$(178); Chr$(32); Chr$(32); Chr$(178); Chr$(32); Chr$(32);
1560 Locate 26 - Y * 3, X * 8 + 1, 0
1561 Print Chr$(32); Chr$(32) + "ROOK" + Chr$(32); Chr$(32);
1562 Locate 27 - Y * 3, X * 8 + 1, 0
1563 Print String$(2, Chr$(32)); String$(4, Chr$(178)); String$(2, Chr$(32));: Return
1570 Locate 25 - Y * 3, X * 8 + 1, 0
1571 Print Chr$(32); Chr$(32); Chr$(176); Chr$(32); Chr$(32); Chr$(176); Chr$(32); Chr$(32);
1580 Locate 26 - Y * 3, X * 8 + 1, 0
1581 Print Chr$(32); Chr$(32) + "ROOK" + Chr$(32); Chr$(32);
1582 Locate 27 - Y * 3, X * 8 + 1, 0
1583 Print String$(2, Chr$(32)); String$(4, Chr$(176)); String$(2, Chr$(32));: Return
1590 Locate 25, 31, 1: Print String$(10, " ");
1600 X$ = InKey$: If X$ = "N" Then N$ = X$
1610 If X$ >= "A" And X$ <= "H" Then X = Val(Chr$(Asc(X$) - 16)): GoTo 1730
1620 If X$ = "N" Then GoSub 2030
1630 If X$ = "K" And A(5, 1) = 99 And A(8, 1) = 7 Then A(5, 1) = 1: A(8, 1) = 1: A(7, 1) = 99: A(6, 1) = 7: GoTo 1800
1640 If X$ = "Q" And A(5, 1) = 99 And A(1, 1) = 7 Then A(5, 1) = 1: A(1, 1) = 1: A(3, 1) = 99: A(4, 1) = 7: GoTo 1800
1650 If X$ = "K" And A(4, 1) = 99 And A(1, 1) = 7 Then A(4, 1) = 1: A(1, 1) = 1: A(2, 1) = 99: A(3, 1) = 7: GoTo 1800
1660 If X$ = "Q" And A(4, 1) = 99 And A(8, 1) = 7 Then A(4, 1) = 1: A(8, 1) = 1: A(6, 1) = 99: A(5, 1) = 7: GoTo 1800
1670 If X$ = "X" Then GoSub 1830: Locate 25, 1, 0: Print "EXCHANGING         ";: GoSub 2480: If CL$ = "Y" Then Locate 25, 50, 0: Print "START "; Time$;: GoTo 100: Else: GoTo 100
1680 If X$ = "S" Then GoTo 1820
1690 If X$ = "M" Then GoSub 1840
1700 If X$ = "I" Then GoSub 2220: Cls: GoSub 900: Locate 25, 1, 1: Print "MOVE " + Chr$(7); B$;
1710 If X$ = "L" Then GoSub 2040
1720 GoTo 1600
1730 Locate 25, 21, 1: Print X$;: Locate 25, 31, 1: Print "            ";
1740 Y = Val(InKey$): If Y = 0 Then GoTo 1740
1750 Locate 25, 22, 1: Print Y;: Locate 25, 25, 1: Print "-";
1760 If A(X, Y) < 2 Or A(X, Y) > 99 Then Locate 25, 31, 1: Print "ENTRY ERROR ";: GoTo 1590
1770 A$ = InKey$: If A$ < "A" Or A$ > "H" Then GoTo 1770 Else A = Val(Chr$(Asc(A$) - 16))
1780 Locate 25, 27, 1: Print A$;
1790 B = Val(InKey$): If B = 0 Then GoTo 1790 Else Locate 25, 28, 1: Print B;
1800 If X$ = "K" Or X$ = "Q" Then Locate 25, 20, 1: Print "CSTL. "; X$; "-SIDE";: GoSub 1830 Else GoSub 1830
1810 If CL$ = "Y" Then Locate 25, 50, 0: Print "START "; Time$;
1820 Return
1830 Locate 25, 1, 1: Print String$(79, " ");: Return
1840 GoSub 1830: Locate 25, 1, 1: Print "MODIFYING          ";
1850 GoSub 2010: If M$ < "A" Or M$ > "H" Then GoTo 1850
1860 X = Val(Chr$(Asc(M$) - 16)): Locate 25, 21, 1: Print M$;
1870 M$ = InKey$: If M$ < "1" Or M$ > "8" Then GoTo 1870
1880 Y = Val(M$): Locate 25, 23, 1: Print M$; " = ";
1890 M$ = InKey$: If M$ = "C" Or M$ = "P" Or M$ = "E" Then S1$ = M$: Locate 25, 27, 1: Print M$;: Else GoTo 1890
1900 M$ = InKey$: If M$ = "S" Or M$ = "P" Or M$ = "N" Or M$ = "B" Or M$ = "R" Or M$ = "Q" Or M$ = "K" Then V$ = M$: Locate 25, 29, 1: Print M$; Else GoTo 1900
1910 If V$ = "P" Then V1 = 2
1920 If V$ = "N" Then V1 = 4
1930 If V$ = "B" Then V1 = 5
1940 If V$ = "R" Then V1 = 7
1950 If V$ = "Q" Then V1 = 9
1960 If V$ = "K" Then V1 = 99
1970 If V$ = "S" Then V1 = 1
1980 If S1$ = "C" And V1 <> 1 Then V1 = -V1
1990 A(X, Y) = V1: If S1$ = "E" Then A(X, Y) = 1
2000 GoSub 910: GoTo 1840
2010 M$ = InKey$: If M$ = "N" Then GoSub 2030: GoTo 2010: Else If M$ = "Z" Then GoSub 1830: Locate 25, 20, 1: Print "         ";: GoSub 900: Else Return
2020 If CL$ = "Y" Then Locate 25, 51, 0: Print "START "; Time$;: GoTo 100 Else GoTo 100
2030 For J = 1 To 8: For K = 1 To 8: K$ = Str$(K)
        2031 Locate 27 - K * 3, J * 8 + 1, 0
2032 Print Chr$(J + 64); Right$(K$, 1);: Next: Next: Return
2040 GoSub 1830: Locate 25, 20, 1: Print "LEVEL="; B8!;: Print "CHANGE LEVELS?";
2050 C$ = InKey$: If C$ = "N" Then GoTo 2090 Else If C$ = "Y" Then Locate 25, 27, 1: Print "       ";: GoSub 1830: Else GoTo 2050
2060 L1$ = InKey$: If L1$ = "" Then GoTo 2060 Else If L1$ >= "0" And L1$ <= "9" Then Locate 25, 27, 1: Print L1$;: Else GoTo 2060
2070 L2$ = InKey$: If L2$ = "" Then GoTo 2070 Else If L2$ < "0" Or L2$ > "9" Then L2$ = L1$: L1$ = "0"
2080 B8! = Val(L1$) * 10 + Val(L2$): B7! = B8! / 2: Locate 25, 27, 0: Print L1$; L2$;
2090 GoSub 1830: Locate 25, 20, 0: Print "              ";: Locate 25, 1, 1: Print "MOVE "; B$;: Return
2100 Rem *** PROMOTION ROUTINE ***
2110 Locate 2, 1, 1: Print "P, N, B, R, Q ";
2120 Z$ = InKey$: If Z$ = "P" Then A(A, B) = 2: GoTo 2180
2130 If Z$ = "N" Then A(A, B) = 4: GoTo 2180
2140 If Z$ = "B" Then A(A, B) = 5: GoTo 2180
2150 If Z$ = "R" Then A(A, B) = 7: GoTo 2180
2160 If Z$ = "Q" Then A(A, B) = 9: GoTo 2180
2170 GoTo 2120
2180 Return
2190 If CL$ = "Y" Then Locate 25, 61, 1: Print "STOP "; Time$;
2200 Locate 25, 1, 1: Print "HIT (P) TO PLAY OR HIT (B) FOR BASIC";
2210 A$ = InKey$: If A$ = "" Then GoTo 2210 Else If A$ = "B" Then Cls: End Else If A$ = "P" Then Run Else GoTo 2210
2220 Cls
2221 Print "1. USE LIST TO INSURE LOADED RIGHT, THE LAST LINE IS 65529 "
2230 Print "2. ALSE NOTE MEMORY SIZE AS A DOUBLE CHECK "
2240 Print "3. SPECIAL COMMANDS DURING PLAYER'S MOVE ARE:"
2250 Print "   TYPE 'N' - TO NUMBER THE BOARD "
2260 Print "        'K' - TO CASTLE KING SIDE "
2270 Print "        'Q' - TO CASTLE QUEEN SIDE "
2280 Print "        'X' - TO EXCHANGE PIECES AND LET COMPUTER MOVE"
2290 Print "        'S' - TO LET THE COMPUTER PLAY BY ITSELF "
2300 Print "        'M' - TO MODIFY THE BOARD, ENTER THE SQUARE FOLLOWED BY"
2310 Print "                 C, P, OR E  FOR COMPUTER, PLAYER, OR EMPTY"
2320 Print "                 AND S,P,N,B,R,Q,K  FOR SQUARE,PAWN, ETC..."
2330 Print "        'Z' - TO ESCAPE MODIFY AND LET COMPUTER MOVE"
2340 Print "        'I' - TO GET INSTRUCTIONS AGAIN"
2350 Print "        'L' - TO LOOK AT OR CHANGE LEVEL OF PLAY"
2360 Rem ********************************************************************
2370 Input "HIT ENTER TO CONTINUE"; EN$: Print
2380 Print "4. TO PROMOTE TO P,N,B,R,Q ENTER THE LETTER WHEN PROMOTED"
2390 Print "5. TO CAPTURE 'EN PASSANT' SPECIFY THE 'FROM' - 'TO' SQUARES"
2400 Print "6. LEVELS OF PLAY ARE FROM 01 TO 24"
2410 Print "7. COMPUTER ASSUMES MATE IF KING IS LEFT IN CHECK SO BE SURE TO "
2411 Print "    WATCH FOR CHECK MESSAGE"
2420 Print "8. IF A MOVE IS ILLEGAL OR AN ENTRY ERROR IS MADE SIMPLY TYPE IN"
2421 Print "    A NEW MOVE.  A MOVE MAY BE STARTED OVER BY FORCING AN ERROR. (E.G. '9')."
2430 Print "9. IF <BREAK> IS HIT DURING THE GAME, TYPE 'GOSUB 900:CONT' TO"
2435 Print "    DRAW BOARD AND CONTINUE"
2440 Print "10. YOU HAVE A CHOICE OF BLACK OR WHITE, THE COMPUTER WILL ALWAYS"
2441 Print "     BE AT THE TOP OF THE SCREEN"
2450 Print: Print: Input "HIT ENTER TO CONTINUE GAME"; EN$
2460 Return
2480 I = -I: GoSub 2490: GoSub 900: Return
2490 L = 0: For J = 1 To 8: For K = 1 To 8: L = L + 1: If A(J, K) <> 1 Then C(L) = -A(J, K): Else C(L) = A(J, K)
2500 Next: Next
2510 L = 65: For J = 1 To 8: For K = 1 To 8: L = L - 1: A(J, K) = C(L): Next: Next
2520 Return
65529 End

