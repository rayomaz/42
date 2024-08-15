% Load the .obj file
[obj.v, obj.f] = read_obj('Model/ball.obj');

% Create a new figure
figure_handle = figure;

% Plot the object
patch('Vertices', obj.v, 'Faces', obj.f, 'FaceColor', [0.8 0.8 1.0], 'EdgeColor', 'none');

% Set view angle and axis properties
view(3);
axis equal;
camlight; 
lighting gouraud;

% Add some labels for clarity
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Space Ball');
grid on;
rotate3d on;

saveas(figure_handle, 'ball_object.png');

        
