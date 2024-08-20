package PriorityEncodeOH;

function Bit#(n) priorityEncodeOHR (Bit#(n) in);
  Bit#(n) encoded = 0;
  for (Integer i = valueOf(n) - 1; i >= 0; i = i - 1) begin
    Bool test = unpack(in[i]);
    if (test) begin
      encoded = (1 << i);
    end
  end
  return encoded;
endfunction

function Bit#(n) priorityEncodeOHL (Bit#(n) in);
  Bit#(n) encoded = 0;
  for (Integer i = 0; i < valueOf(n); i = i + 1) begin
    Bool test = unpack(in[i]);
    if (test) begin
      encoded = (1 << i);
    end
  end
  return encoded;
endfunction

endpackage : PriorityEncodeOH
