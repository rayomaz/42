function [v, f] = read_obj(filename)
    % Initialize arrays to store vertices and faces
    v = [];
    f = [];

    % Open the file
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    
    % Read the file line by line
    while ~feof(fid)
        tline = fgetl(fid);
        
        % Parse the line
        tline = strtrim(tline);
        if length(tline) >= 2
            switch tline(1:2)
                case 'v ' % Vertex definition
                    v = [v; sscanf(tline(2:end), '%f %f %f')'];
                case 'f ' % Face definition
                    % Split the line into individual elements
                    elements = strsplit(tline(2:end));
                    face = [];
                    for i = 1:numel(elements)
                        % Vertex index is before the first '/', so we take the first part
                        vertexIndex = sscanf(elements{i}, '%d');
                        face = [face, vertexIndex];
                    end
                    f = [f; face];
            end
        end
    end
    
    % Close the file
    fclose(fid);
end
