function varargout=patchNormPlot(varargin)

% function [hp]=patchNormPlot(F,V,a,pathType)
%
% Simple function to plot surface normal vectors with magnitude a for the
% patch data specified by the faces F and vertices V. The option third
% input patchType sets the type of surface normal to use, i.e. the face
% normal if patchType='f' or the vertex normal if patchType='v'; 
%
% Quiver patch options can be altered using the output handle "hp".
%
% Kevin Mattheus Moerman
% kevinmoerman@hotmail.com
% 29/06/2013
%
% Change log: 
% 2014/06/02 added vertex normal code
% ------------------------------------------------------------------------
%%

switch nargin
    case 2
        F=varargin{1};
        V=varargin{2};
        a=[];
        patchType='f'; 
    case 3
        F=varargin{1};
        V=varargin{2};
        a=varargin{3};
        patchType='f'; 
    case 4
        F=varargin{1};
        V=varargin{2};
        a=varargin{3};
        patchType=varargin{4};         
    otherwise
        error('Wrong numer of input arguments!');
end

%Check if a is empty, if so replace  length by mean edge length of surface
if isempty(a)
    [A]=patchEdgeLengths(F,V);
    a=mean(A)*ones(1,2)/2;
elseif numel(a)==1
    a=a*ones(1,2);
end

%Get face normals
switch patchType
    case 'f'       
        [N,Vn]=patchNormal(F,V);     
        
        %Check is varying length input is provided
        if size(a,1)==size(V,1)
            [a]=vertexToFaceMeasure(F,a);
            N=N.*a(:,ones(1,3)); %Scale normals
            a=[min(a) max(a)];
        elseif size(a,1)==size(F,1)
            N=N.*a(:,ones(1,3)); %Scale normals
            a=[min(a) max(a)];
        end
    case 'v'
        [~,~,N]=patchNormal(F,V);
        Vn=V;
        
        %Check is varying length input is provided
        if size(a,1)==size(V,1)
            N=N.*a(:,ones(1,3)); %Scale normals
            a=[min(a) max(a)];
        elseif size(a,1)==size(F,1)
            [a]=faceToVertexMeasure(F,V,a);
            N=N.*a(:,ones(1,3)); %Scale normals
            a=[min(a) max(a)];
        end
    otherwise
        error('Wrong patchType specified!');
end



%Derive quiver patch data
[Fni,Vni,~]=quiver3Dpatch(Vn(:,1),Vn(:,2),Vn(:,3),N(:,1),N(:,2),N(:,3),[],a);

%Patch plotting the face normals
hp=patch('Faces',Fni,'Vertices',Vni);

%Set defaults
set(hp,'EdgeColor','none','FaceColor','k');

if nargout>0
    varargout{1}=hp;
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
