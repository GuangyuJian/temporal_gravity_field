classdef study_basin<handle
    % class_definition of the class 'mybasin'
    % the class memory the infomation of our study basin
    %**************************************************************************
    % construct project:
    %                   1. mybasin(resolution);
    %                    for global study with certain resolution
    %                   2. mybasin(resolution,box);
    %                    for regional study (square box) with certain resolution
    %
    % In:
    %       resolution: [1x1]           ,unit: degree
    %                   option{0.125; 0.25; 0.5; 1}
    %
    %       box:        [1x4]or[4x1]    ,unit: degree;
    %                   [minimum of longitude,maximum of longitude,
    %                   minimum of ceta,maximum of ceta]
    %----------------------------------------------------------------------------

    % Authors: Karl Jian (K.J)
    % address: Guangdong University of Technology(GDUT)
    % email: gyjian@mail2.gdut.edu.cn
    % date: 2023-12-23
    % Encode: UTF-8
    %**************************************************************************


    properties
        %=================
        name char
        %=================
        Resolution          %resolution of sphere function
        fir                 %longitude vector of cacilate point
        ceta                %latitude vector of cacilate point
        %=================
        boundary_fir        %longitude of boundary
        boundary_ceta       %latitude  of boundary
        %=================
        mask                %a mask corresponding to the study basin
        % defult: a nan-matrix
        cos_weight_grid     %a weight for the study basin
        area_size
    end
    %%
    methods
        function self=study_basin(Resolution,box)
            %             default
            self.boundary_fir=[nan];
            self.boundary_ceta=[nan];
            
            if nargin==1
                self.set_Reso(Resolution);
            elseif nargin==2
                self.set_Reso(Resolution,box);
            end

            disp('------------------------------------------------');
            disp(datetime);
            disp("mybasin:a object is done");
            disp(['resolution is ' num2str(Resolution) ' (unit:degree)']);
            disp('------------------------------------------------');

        end

        %%
        %setting your study basin by giving the boundary
        get_mask(self,bf1,bc1,bf2,bc2);
        plot_region(self)%show the study basin
        %=======================================
        self=set_fir_ceta(self,fir,ceta);
        self=set_single(self,fir,ceta);
       
       
        self=set_Reso_full(self,Resolution); % setting the same resolution along latitude and longitude direction
        % this function for a loop grid,which mean ,the first element of 
        % vector same as the last one of vector both 
        % in longitude  and latitude vector.

        self=set_Reso(self,Resolution,box);% setting the same resolution along latitude and longitude direction
        self=set_Reso2(self,Resolution,box);% setting the various resolution along latitude and longitude direction
        self=set_box(self,Resolution);%i forget what this function for, just ignore it
        %======================================


    end
end


