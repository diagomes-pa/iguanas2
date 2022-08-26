function [sig_q, integer_codeword, levels]= digproc_quantizer(sig,b)

max_sig = max(sig);
min_sig = min(sig);
Vpp = max_sig - min_sig;

L = 2^b;
Delta = Vpp/L;

above_max = find(sig > max_sig-(Delta/2));
below_min = find(sig < min_sig+(Delta/2));
sig(above_max) = max_sig-(Delta/2);
sig(below_min) = min_sig+(Delta/2);

sig_up = sig + abs(min_sig+(Delta/2));
integer_codeword = round(sig_up/Delta);
sig_q = integer_codeword*Delta - abs(min_sig+(Delta/2));

levels = min_sig+(Delta/2):Delta:max_sig-(Delta/2);

endfunction