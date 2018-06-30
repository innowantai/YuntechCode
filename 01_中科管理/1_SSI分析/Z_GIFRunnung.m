function F = Z_GIFRunnung(filename,handlesname)


info = imfinfo(filename);%第一次?取，用于?取?性值
W = info.Width;
H = info.Height;
W = W(1);
H = H(1);
len = length(info);
% figure('NumberTitle', 'off', 'ToolBar', 'none', 'Menu', 'none');
% pos = get(handlesname, 'position');
% set(handlesname, 'position', [pos(1) pos(2) W H]);
% set(handlesname, 'position', [0 0 1 1]);
% hold on;
for i = 1 : len
    str=sprintf('photo%d.jpg',i);
    [Ii, map] = imread(filename, 'frames', i);   
    imwrite(Ii,str,'jpg');
    F(:, i) = im2frame(flipud(Ii), map);  
end

% axes(handlesname);