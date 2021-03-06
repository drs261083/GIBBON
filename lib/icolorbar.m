function [varargout]=icolorbar(varargin)


hf=gcf;
if isempty(hf.Children) %No axis objects so use figure handle
    h=hf;
else %Graphics objects so use current axis
    h=gca;
end

c=h.Colormap; 
switch nargin
    case 0 
        cLim=caxis;
    case 1
        cLim=varargin{1};
end
h.Colormap=c;

caxis([cLim(1)-0.5 cLim(2)+0.5]);
hc=colorbar; 
hc.Ticks=cLim(1):1:cLim(2);%linspace(cLim(1)-0.5,cLim(2)+0.5,numel(cLim)+3)
h.Colormap=resampleColormap(h.Colormap,numel(hc.Ticks));

if nargout==1
    varargout{1}=h;
end
 
%% 
% _*GIBBON footer text*_ 
% 
% License: <https://github.com/gibbonCode/GIBBON/blob/master/LICENSE>
% 
% GIBBON: The Geometry and Image-based Bioengineering add-On. A toolbox for
% image segmentation, image-based modeling, meshing, and finite element
% analysis.
% 
% Copyright (C) 2018  Kevin Mattheus Moerman
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
