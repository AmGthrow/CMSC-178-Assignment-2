function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);

% modify the code below ------------------------------------------------

% Zero pad B and compute its FFT
Bsize = size(B);
B = padarray(B, fix((size(I) - Bsize)/2), 0, "pre");  % round down first half
B = padarray(B, round((size(I) - Bsize)/2), 0, "post");  % round up second half
Fb = fft2(B);

% Compute inverse filter
Finv = (Fi./Fb).*((abs(Fb).^2./(abs(Fb).^2 + k)));
% Convert inverse to real image
Inv = real(ifftshift(ifft2(Finv)));
% Apply inverse filter
I_deblur = Inv .* I;

% modify the code above ------------------------------------------------

return

