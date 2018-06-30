function [ym2] = H_CuttintHis_sub(y1,dt,cutfn)

[l ny]=size(y1);if (ny<l);y1=y1';[l ny]=size(y1); end
[~, ~, w, ~, f1] = HWF(y1,dt);
[~, pos] = min(abs(w-cutfn(2)));
[~, ind] = min(abs(w-cutfn(1)));
f10 = zeros(ind-1,l);
f20 = f1(ind:pos,:); f00 = zeros(ny/2- pos,l); f21 = f1(ny/2 + 1,:);
f22 = [f10; f20; f00];  f23 = flipud(conj(f22(2:end,:)));
f2 = [f22; f21; f23].*(1/dt);
y2 = ifft(f2);
[~, ym2, ~, F2, ~] = HWF(y2,dt);
[l ny]=size(ym2);if (ny<l);ym2=ym2';[l ny]=size(ym2); end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 