function I_deblur = wiener_deblur(I,B,k)
 
if ( isa(I,'uint8') || isa(B,'uint8') )
  error('deblur: Image and blur data should be of type double.');
end

I = edgetaper(I,B);
Fi = fft2(I);
% modify the code below ------------------------------------------------

% this section is just dummy code - delete it

% F_deblur = Fi;
% I_deblur = real( ifft2(F_deblur) );

% Here you will need to:

% 1. zero pad B and compute its FFT
B = padarray(B, round((size(I) - size(B))/2), 0, "both");
[HEIGHT, WIDTH] = size(I);
B = B(1:HEIGHT, 1:WIDTH); % Trim off any rounding errors
Fb = fft2(B);

% Compute inverse filter
Finv = (Fi./Fb).*((abs(Fb).^2./(abs(Fb).^2 + k)));
% Convert inverse to real image
Inv = real(ifftshift(ifft2(Finv)));
% Apply inverse filter
I_deblur = Inv .* I;

% you may need to deal with values near zero in the FFT of B etc
% to avoid division by zero's etc.

% modify the code above ------------------------------------------------

return

