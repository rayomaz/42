% Load the .obj file
[obj.v, obj.f] = read_obj('../../Model/ball.obj');

% Create a new figure
figure_handle = figure;

% Plot the object with most faces in a default color
patch('Vertices', obj.v, 'Faces', obj.f, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none');

% Highlight a specific face with a different color
highlighted_face_index = 10; % Example face index, change as needed
patch('Vertices', obj.v, 'Faces', obj.f(highlighted_face_index, :), 'FaceColor', [1.0 0.4 0.4], 'EdgeColor', 'none');

% Set view angle and axis properties
view(3);
axis equal;
camlight; 
lighting gouraud;

% Add some labels for clarity
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
rotate3d on;

% Get the centroid of the highlighted face for the arrow
highlighted_face_vertices = obj.v(obj.f(highlighted_face_index, :), :);
centroid = mean(highlighted_face_vertices, 1);

% Define arrow direction and length
arrow_direction = [0 0.1 0.1]; % Change as needed
arrow_start = centroid;
arrow_end = arrow_start + arrow_direction;

% Draw the arrow
annotation('textarrow', 'X', arrow_start(1), 'Y', arrow_start(2), 'Z', arrow_start(3), ...
           'String', '$\bar{a}_i$', 'Interpreter', 'latex', ...
           'FontSize', 12, 'Color', 'red', ...
           'XEnd', arrow_end(1), 'YEnd', arrow_end(2), 'ZEnd', arrow_end(3));

% Save the figure
saveas(figure_handle, 'ball_object.png');
