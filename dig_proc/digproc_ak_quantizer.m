function [x_hat,integer_codeword,indices]= digproc_ak_quantizer(x,delta,b)
%function [x_hat,integer_codeword]=ak_quantizer(x,delta,b)
integer_codeword = x / delta; %quantizer levels
integer_codeword=round(integer_codeword); %nearest integer
indices=find(integer_codeword > 2^(b-1) - 1);
integer_codeword(indices) = 2^(b-1) - 1; %impose maximum 
indices=find(integer_codeword < -2^(b-1));
integer_codeword(indices) = -2^(b-1); %impose minimum
x_hat = integer_codeword * delta;  %quantized output
endfunction