
/****************************************************************************
*
*                          PUBLIC DOMAIN NOTICE                         
*         Lister Hill National Center for Biomedical Communications
*                      National Library of Medicine
*                      National Institues of Health
*           United States Department of Health and Human Services
*                                                                         
*  This software is a United States Government Work under the terms of the
*  United States Copyright Act. It was written as part of the authors'
*  official duties as United States Government employees and contractors
*  and thus cannot be copyrighted. This software is freely available
*  to the public for use. The National Library of Medicine and the
*  United States Government have not placed any restriction on its
*  use or reproduction.
*                                                                        
*  Although all reasonable efforts have been taken to ensure the accuracy 
*  and reliability of the software and data, the National Library of Medicine
*  and the United States Government do not and cannot warrant the performance
*  or results that may be obtained by using this software or data.
*  The National Library of Medicine and the U.S. Government disclaim all
*  warranties, expressed or implied, including warranties of performance,
*  merchantability or fitness for any particular purpose.
*                                                                         
*  For full details, please see the MetaMap Terms & Conditions, available at
*  https://metamap.nlm.nih.gov/MMTnCs.shtml.
*
***************************************************************************/

% File:     text_object_io.pl
% Module:   Text Object I/O
% Author:   Lan
% Purpose:  To I/O provide support for text objects


:- module(text_object_io,[
    to_io_global/2,
    translate_newlines_to_backslash/2,
    write_warning/4
    ]).

% Now needed for some reason for 0'\ in translate_newlines_to_backslash/2
% :- prolog_flag(character_escapes,_,off).

:- dynamic to_io_global/2.

translate_newlines_to_backslash([],[]).
translate_newlines_to_backslash([10|Rest],[0'\\|TranslatedRest]) :-
    !,
    translate_newlines_to_backslash(Rest,TranslatedRest).
translate_newlines_to_backslash([First|Rest],[First|TranslatedRest]) :-
    translate_newlines_to_backslash(Rest,TranslatedRest).

write_warning(Text0,Type,Ref,_Message) :-
    (to_io_global(warnings_stream,Stream) ->
        true
    ;   Stream=user_output
    ),
    translate_newlines_to_backslash(Text0,Text),
    format(Stream,'~s|~a||~a~n',[Text,Type,Ref]).


