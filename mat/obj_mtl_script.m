%% Generate obj files from Shape Params
% Rayan Mazouz, Marco Quadrelli
% Loading custom objects

clc; clear; close all;

%% Shape Data
load("ShapeData3.mat")

data = ShapeParamSphere;
exportObj(data, '../Model/custom.obj');
exportMtl(data, '../Model/custom.mtl');


%% Functions

function exportObj(data, objFilename)
    % Extract vertices and faces
    vertices = data.VerticesSC;
    faces = data.FacesSC;

    % Replace zero elements with 1e-17 in vertices
    vertices(vertices == 0) = 1e-17;

    % Calculate the number of vertices and faces
    Nv = size(vertices, 1);
    if iscell(faces)
        Npoly = numel(faces); % Number of polygons
    else
        Npoly = size(faces, 1); % Number of polygons
    end
    % Number of vertex normals is same as vertices
    Nvn = Nv; 
    
    % Create and write to the .obj file
    fid = fopen(objFilename, 'w');
    if fid == -1
        error('Cannot open file for writing: %s', objFilename);
    end

    % Write the header information to .obj file
    fprintf(fid, '# Nv = %d  Nvt = 0  Nvn = %d  Npoly = %d\n', Nv, Nvn, Npoly);
    fprintf(fid, '# Exported from ShapeData\n');
    fprintf(fid, 'mtllib Ball.mtl\n');
    fprintf(fid, 'o sphere1\n');
    fprintf(fid, '# %d vertices, %d faces\n', Nv, Npoly);

    % Write vertices to the .obj file
    fprintf(fid, '# Vertices\n');
    for i = 1:size(vertices, 1)
        fprintf(fid, 'v %.7e %.7e %.7e\n', vertices(i, :));
    end

    % Write faces to the .obj file
    fprintf(fid, '# Faces\n');
    if iscell(faces)
        % Handle cell array of faces
        for i = 1:numel(faces)
            face = faces{i};
            % Ensure face indices are within valid range
            if all(face <= Nv) && all(face > 0)
                fprintf(fid, 'f');
                for j = 1:numel(face)
                    fprintf(fid, ' %d', face(j));
                end
                fprintf(fid, '\n');
            else
                warning('Invalid face indices at face %d, skipping', i);
            end
        end
    else
        % Handle double array of faces
        for i = 1:size(faces, 1)
            face = faces(i, :);
            % Ensure face indices are within valid range
            if all(face <= Nv) && all(face > 0)
                fprintf(fid, 'f %d %d %d %d\n', face);
            else
                warning('Invalid face indices at face %d, skipping', i);
            end
        end
    end

    % Close the .obj file
    fclose(fid);
    disp(['File saved as ', objFilename]);
end

    

% function exportObj(data, filename)
% 
%     % Extract vertices and faces
%     vertices = data.VerticesSC;
%     faces = data.FacesSC;
% 
%     % Calculate the number of vertices and faces
%     Nv = size(vertices, 1);
%     Npoly = size(faces, 1);
% 
%     % Replace zero elements with 1e-17
%     vertices(vertices == 0) = 1e-17;
% 
%     % Number of vertex normals is same as vertices 
%     Nvn = Nv;
% 
%     % Open the file for writing
%     fid = fopen(filename, 'w');
%     if fid == -1
%         error('Cannot open file for writing: %s', filename);
%     end
% 
%     % Write the header information
%     fprintf(fid, '# Nv = %d  Nvt = 0  Nvn = %d  Npoly = %d\n', Nv, Nvn, Npoly);
%     fprintf(fid, '# Exported from ShapeData\n');
%     fprintf(fid, 'mtllib custom.mtl\n');
%     fprintf(fid, 'o sphere1\n');
%     fprintf(fid, '# %d vertices, %d faces\n', Nv, Npoly);
% 
%     % Write vertices to the .obj file
%     fprintf(fid, '# Vertices\n');
%     for i = 1:size(vertices, 1)
%         fprintf(fid, 'v %.7e %.7e %.7e\n', vertices(i, :));
%     end
% 
%     % Write faces to the .obj file
%     fprintf(fid, '# Faces\n');
%     for i = 1:size(faces, 1)
%         fprintf(fid, 'f %d %d %d %d\n', faces(i, :));
%     end
% 
%     % Close the file
%     fclose(fid);
%     disp(['File saved as ', filename]);
% end

function exportMtl(data, mtlFilename)
    % Extract material properties from the data structure
    reflectivity = data.reflectivity_SC;
    specular = data.specular_SC;
    thermalEmissivity = data.thermalEmissivity_SC;
    
    % Calculate the average values for the material properties
    Kd = mean(reflectivity); % Diffuse reflectivity
    Ka = mean(reflectivity); % Ambient reflectivity
    Ks = mean(specular); % Specular reflectivity
    Ke = mean(thermalEmissivity); % Emissive coefficient

    % Create and write to the .mtl file
    fid = fopen(mtlFilename, 'w');
    if fid == -1
        error('Cannot open file for writing: %s', mtlFilename);
    end

    % Write material properties to the .mtl file
    fprintf(fid, '# Exported from ShapeData\n');
    fprintf(fid, 'newmtl default\n');
    fprintf(fid, 'Ns 0.0\n');
    fprintf(fid, 'd 1.0\n');
    fprintf(fid, 'illum 2\n');

    % Using average reflectivity for RGB components
    fprintf(fid, 'Kd %f %f %f\n', Kd, Kd, Kd); 
    fprintf(fid, 'Ka %f %f %f\n', Ka, Ka, Ka);
    fprintf(fid, 'Ks %f %f %f\n', Ks, Ks, Ks); 
    fprintf(fid, 'Ke %f %f %f\n', Ke, Ke, Ke); 

    % Close the .mtl file
    fclose(fid);
    disp(['File saved as ', mtlFilename]);
end

