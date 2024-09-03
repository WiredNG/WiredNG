package Spec;

import WiredParam::*;
import WiredTypes::*;

interface SpecUpdate;
    method Action correct(SpecId kill_id, Bool kill_all);
    method Action incorrect(SpecTag mask);
endinterface

function SpecTag correctSpecTag(SpecTag req_mask, SpecTag old_mask);
    return old_mask & ~req_mask;
endfunction

function Bool incorrectSpecTag(SpecId kill_id, Bool kill_all, SpecTag old_mask, Bool old_valid);
    Bool new_valid = old_valid;
    if(old_mask[kill_id] || kill_all) new_valid = 0;
    return new_valid;
endfunction

endpackage : Spec