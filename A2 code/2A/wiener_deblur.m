function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);

% modify the code below ------------------------------------------------

% Zero pad B
Bsize = size(B);
B = padarray(B, fix((size(I) - Bsize)/2), 0, "pre");  % round down first half
B = padarray(B, round((size(I) - Bsize)/2), 0, "post");  % round up second half
% Convert B to frequency image
Fb = fft2(B);

% Compute and apply inverse filter
Fb2 = abs(Fb).^2;
F_deblur = (Fi ./ Fb) .* ((Fb2 ./ (Fb2 + k)));

% Convert deblur to real image
I_deblur = ifftshift(real(ifft2(F_deblur)));

% modify the code above ------------------------------------------------

return

