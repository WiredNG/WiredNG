package WiredDecode;

import WiredTypes::*;
import WiredParam::*;
import LoongArchInst::*;

(* noinline *)
function LA_Inst predecode(Bit#(32) inst);
    LA_Inst ret = tagged Inst_invalid unpack(inst);
    UInt#(32) uinst = unpack(inst);
    if(uinst >= op2R_START && uinst < op2R_END) ret = tagged Inst_2r unpack(inst);
    return ret;
endfunction

endpackage : WiredDecode