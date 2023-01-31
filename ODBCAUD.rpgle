        Ctl-Opt DEBUG DATEDIT(*DMY);
        Ctl-Opt DATFMT(*EUR);
        Ctl-Opt DFTACTGRP(*NO) ACTGRP(*CALLER);
        //*********************************************************************
        //                      MNI SERVICES
        //    ======================================================
      
        //   Description :   ODBC connection auditing
        //   Author      :   David Shears
        //   Create Date :   20/03/2018
        //   Notes       :   Built based on online code -
        //                   http://www.rpgiv.info/mambo/index.php?
        //                   option=com_content&task=view&id=448&Itemid=9
        //********************************************************************
        // FILES USED BY PROGRAM.
        //********************************************************************
        Dcl-F ODBCAUDIT Usage(*Input) Keyed;
        //********************************************************************
        //  ENTRY PARMS.
        //********************************************************************
        Dcl-PR ENTRYPARMS  ExtPgm('ODBCAUD');
          REQUEST_STATUS Char(1);
          REQUEST_STRING Char(2048);
        End-PR;

        Dcl-PI ENTRYPARMS;
          REQUEST_STATUS Char(1);
          REQUEST_STRING Char(2048);
        End-PI;
        //********************************************************************
        //  FIELD DEFINITIONS.
        //********************************************************************
        Dcl-S USER_PROFILE Char(10)   INZ(*BLANKS);
        Dcl-S SERVER_ID    Char(10)   INZ(*BLANKS);
        Dcl-S FORMAT_NAME  Char(8)    INZ(*BLANKS);
        Dcl-S FUNCTION     Char(4)    INZ(*BLANKS);
        Dcl-S CODETYPE     Char(4)    INZ(*BLANKS);
        Dcl-S FILE_CHANGE  Char(6)    INZ(*BLANKS);
        Dcl-S ReqLen       Zoned(4:0);
        Dcl-C CODE0000   CONST(X'00000000');
        Dcl-C CODE1800   CONST(X'00001800');
        Dcl-C CODE1801   CONST(X'00001801');
        Dcl-C CODE1802   CONST(X'00001802');
        Dcl-C CODE1803   CONST(X'00001803');
        Dcl-C CODE1804   CONST(X'00001804');
        Dcl-C CODE1805   CONST(X'00001805');
        Dcl-C CODE1806   CONST(X'00001806');
        Dcl-C CODE1807   CONST(X'00001807');
        Dcl-C CODE1808   CONST(X'00001808');
        Dcl-C CODE1809   CONST(X'00001809');
        Dcl-C CODE180A   CONST(X'0000180A');
        Dcl-C CODE180B   CONST(X'0000180B');
        Dcl-C CODE180C   CONST(X'0000180C');
        Dcl-C CODE180D   CONST(X'0000180D');
        Dcl-C CODE180E   CONST(X'0000180E');
        Dcl-C CODE180F   CONST(X'0000180F');
        Dcl-C CODE1810   CONST(X'00001810');
        Dcl-C CODE1811   CONST(X'00001811');
        Dcl-C CODE1812   CONST(X'00001812');
        Dcl-C CODE1815   CONST(X'00001815');
        //********************************************************************
        //  DATA STRUCTURE FOR REQUEST STRING
        //********************************************************************
        Dcl-DS *N  INZ;
          REQUEST        Char(2048) Pos(1);
          USER           Char(10)   Pos(1);
          SRVID          Char(10)   Pos(11);
          FORMAT         Char(8)    Pos(21);
          FUNC           Char(4)    Pos(29);
          SQLLEN         Bindec(4)  Pos(235);
          SQL512         Char(513)  Pos(96);
          SQLCODE        Char(1810) Pos(239);
        End-DS;

        // ******************************************************************
        // * Write request to file
        // ******************************************************************
          Request_Status = '1';
          Request = Request_String;
          OUser = USER;
          OForm = Format;
          Select;
          When Func = CODE0000;
              OFunc = '0000';
          When Func = CODE1800;
              OFunc = '1800';
          When Func = CODE1801;
              OFunc = '1801';
          When Func = CODE1802;
              OFunc = '1802';
          When Func = CODE1803;
              OFunc = '1803';
          When Func = CODE1804;
              OFunc = '1804';
          When Func = CODE1805;
              OFunc = '1805';
          When Func = CODE1806;
              OFunc = '1806';
          When Func = CODE1807;
              OFunc = '1807';
          When Func = CODE1808;
              OFunc = '1808';
          When Func = CODE1809;
              OFunc = '1809';
          When Func = CODE180A;
              OFunc = '180A';
          When Func = CODE180B;
              OFunc = '180B';
          When Func = CODE180C;
              OFunc = '180C';
          When Func = CODE180D;
              OFunc = '180D';
          When Func = CODE180E;
              OFunc = '180E';
          When Func = CODE180F;
              OFunc = '180F';
          When Func = CODE1801;
              OFunc = '1801';
          When Func = CODE1810;
              OFunc = '1810';
          When Func = CODE1811;
              OFunc = '1811';
          When Func = CODE1812;
              OFunc = '1812';
          When Func = CODE1815;
              OFunc = '1815';
          Other;
              OFunc = '????';
          EndSl;
          If Format = 'ZDAQ0100';
          Oreq = SQL512;
          Else;
          OReq = %subst(SQLCODE:1:SQLLEN);
          EndIf;
          ODate = %DATE();
          OTime = %TIME();
          If OReq <> ' ';
             Write ODBCAUDR;
          EndIf;
             Clear ODBCAUDR;
          *INLR = *ON;
          Return;
