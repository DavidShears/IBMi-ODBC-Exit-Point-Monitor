     H DEBUG DATEDIT(*DMY)
     H DATFMT(*EUR)
     H DFTACTGRP(*NO) ACTGRP(*CALLER)
      ************************************************************************
      *                      MNI SERVICES
      *    ======================================================
      *
      *   Description :   ODBC connection auditing
      *   Author      :   David Shears
      *   Create Date :   20/03/2018
      *   Notes       :   Built based on online code -
      *                   http://www.rpgiv.info/mambo/index.php?
      *                   option=com_content&task=view&id=448&Itemid=9
      ************************************************************************
      * FILES USED BY PROGRAM.
      **********************************************************************
     FODBCAUDIT IF A E           K DISK
      **********************************************************************
      *  ENTRY PARMS.
      **********************************************************************
     D  ENTRYPARMS     PR                  ExtPgm('ODBCAUD')
     D  REQUEST_STATUS...
     D                                1
     D  REQUEST_STRING...
     D                             2048

     D  ENTRYPARMS     PI
     D  REQUEST_STATUS...
     D                                1
     D  REQUEST_STRING...
     D                             2048
      **********************************************************************
      *  FIELD DEFINITIONS.
      **********************************************************************
     D  USER_PROFILE   S             10    INZ(*BLANKS)
     D  SERVER_ID      S             10    INZ(*BLANKS)
     D  FORMAT_NAME    S              8    INZ(*BLANKS)
     D  FUNCTION       S              4    INZ(*BLANKS)
     D  CODETYPE       S              4    INZ(*BLANKS)
     D  FILE_CHANGE    S              6    INZ(*BLANKS)
     D  ReqLen         S              4S 0
     D  CODE0000       C                   CONST(X'00000000')
     D  CODE1800       C                   CONST(X'00001800')
     D  CODE1801       C                   CONST(X'00001801')
     D  CODE1802       C                   CONST(X'00001802')
     D  CODE1803       C                   CONST(X'00001803')
     D  CODE1804       C                   CONST(X'00001804')
     D  CODE1805       C                   CONST(X'00001805')
     D  CODE1806       C                   CONST(X'00001806')
     D  CODE1807       C                   CONST(X'00001807')
     D  CODE1808       C                   CONST(X'00001808')
     D  CODE1809       C                   CONST(X'00001809')
     D  CODE180A       C                   CONST(X'0000180A')
     D  CODE180B       C                   CONST(X'0000180B')
     D  CODE180C       C                   CONST(X'0000180C')
     D  CODE180D       C                   CONST(X'0000180D')
     D  CODE180E       C                   CONST(X'0000180E')
     D  CODE180F       C                   CONST(X'0000180F')
     D  CODE1810       C                   CONST(X'00001810')
     D  CODE1811       C                   CONST(X'00001811')
     D  CODE1812       C                   CONST(X'00001812')
     D  CODE1815       C                   CONST(X'00001815')
      **********************************************************************
      *  DATA STRUCTURE FOR REQUEST STRING
      **********************************************************************
     D                 DS                  INZ
     D REQUEST                 1   2048
     D  USER                   1     10
     D  SRVID                 11     20
     D  FORMAT                21     28
     D  FUNC                  29     32
     D  SQLLEN               235    238B 0
     D  SQL512                96    608
     D  SQLCODE              239   2048
      // ******************************************************************
      // *  START FREE FORM CALCS.
      // ******************************************************************

      /free
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
      /end-free
