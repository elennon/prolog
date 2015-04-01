read_single_char(Char) :-
    get_single_char(Code), put_code(Code), nl, char_code(Char, Code).
