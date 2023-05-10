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

% 2. compute and apply the inverse filter
I_deblur = zeros([HEIGHT WIDTH]);
Finv = (Fi./Fb).*((abs(Fb).^2./(abs(Fb).^2 + k)));
% 3. convert back to a real image
Inv = real(ifftshift(ifft2(Finv)));
% 4. handle any spatial delay caused by zero padding of B
for y=1:HEIGHT
    for x=1:WIDTH
        I_deblur(y,x) = Inv(y,x) * I(y,x);
    end
end
%
% you may need to deal with values near zero in the FFT of B etc
% to avoid division by zero's etc.

% modify the code above ------------------------------------------------

return

