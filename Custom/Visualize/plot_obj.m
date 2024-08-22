clc; clear; close;

% Load the .obj file
[obj.v, obj.f] = read_obj('../../Model/ball.obj');

% Create a new figure
figure_handle = figure;

% Plot the object with most faces in a default color and black edges
patch('Vertices', obj.v, 'Faces', obj.f, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'k');

% Highlight a specific face with the previous shaded color (e.g., light cyan)
highlighted_face_index = 10; % Example face index, change as needed
patch('Vertices', obj.v, 'Faces', obj.f(highlighted_face_index, :), 'FaceColor', [0.4 0.8 0.7], 'EdgeColor', 'k');

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

% Define the arrow start and end points in data coordinates
arrow_start = mean(obj.v(obj.f(highlighted_face_index, :), :)); % Start at the centroid of the highlighted face
arrow_end = arrow_start + [0.4, 0.4, 0.4]; % Define the end point with larger arrow

% Plot the arrow using quiver3 for better visibility
hold on;
quiver3(arrow_start(1), arrow_start(2), arrow_start(3), ...
        arrow_end(1) - arrow_start(1), arrow_end(2) - arrow_start(2), arrow_end(3) - arrow_start(3), ...
        'r', 'LineWidth', 3, 'MaxHeadSize', 2); % Larger arrow with thicker line and bigger head

% Add LaTeX text label with larger font size
text(arrow_end(1), arrow_end(2), arrow_end(3), '$\bar{a}_i$', 'FontSize', 18, 'Color', 'r', 'Interpreter', 'latex');

% Save the figure
saveas(figure_handle, 'ball_object_with_shaded_area_latex.png');
