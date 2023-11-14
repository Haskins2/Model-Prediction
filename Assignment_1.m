%Red Bull Data plotted.
close all
clear 

% Read data from file
% First column is time in secs
% Second column is velocity
% Third column is theoretical terminal velocity at that time
jumpdata = csvread('RedBullJumpData.csv');
t_redbull = jumpdata(:,1);
v_redbull = jumpdata(:,2);
terminal_velocity = jumpdata(:,3); % You need to use this in the last question
N_timestamps = length(t_redbull);

%Calculate freefall velocity vector here
g = 9.81;
%v_freefall = rand(size(t_redbull)) * 20 + 100;
v_freefall = g*(t_redbull) ;


% Part 1
% We are giving you this answer for free
figure(1);
h_part1 = plot(t_redbull, v_redbull, 'r-x', 'LineWidth', 2.0);
shg;
hold on;
xlabel('Time [s]', 'fontsize', 24);
ylabel('Velocity [m/s]', 'fontsize', 24);

% Part 2
% This plot does not have the right linewidth. You fix it.
h_part2 = plot(t_redbull, v_freefall, 'b--', 'LineWidth', 2.0); 
shg;
% This is how to put on a grid 
grid on;
% This is how to fix an axis to a desired size
axis([0 180 0 400]);
% Set the fontsize and label the graph here!!
 
% Calculate when he hits the atmosphere
% Part  3
% Need some stuff here ... or read it off from the graph

%when v_freefall  & v_redbull have a deviance > 5% then find t.
% for loop going through first.. say 50 seconds, finding difference,
% comparing to 5% then returning time once true.    ABSOLUTE DIFFERENCE

hit_instant = 0;

for i=1 : 38
    difference = abs(v_redbull(i) - v_freefall(i));
    error = difference/v_freefall(i);
    if error > 0.05 
        hit_instant=t_redbull(i);
        break
    end
end


 % This is wrong
fprintf('Mr. B hits the earth''s atmoshpere at %f secs after he jumps\n',...
       hit_instant);

% Part 4
% Now starting from the velocity and time = 56 secs 
% .. let's update and calculate v
g = 9.81;
v_numerical_1 = v_redbull;
drag_constant = 3/60;
start = find(t_redbull == 56);
% Starting from this time instant, calculate the velocity required
 % This is wrong .. for you to fix

N = length(t_redbull);
for k = (start+1): N
    v_delta = (g-drag_constant*v_numerical_1(k-1))*(t_redbull(k)-t_redbull(k-1));
    v_numerical_1(k) = v_numerical_1(k-1) + v_delta;
end


% Plot using the dashed green line with (+) markers
h_part4 = plot(t_redbull, v_numerical_1, 'g+--','linewidth',2.0);shg

% Part 5 
% Calculate the percentage error as required

t_64 = find(t_redbull == 64);
t_100 = find(t_redbull == 100);
t_170 = find(t_redbull == 170);

%disp((v_numerical_1(t_64)-v_redbull(t_64))/v_redbull(t_64)); ROUND DOWN
%TO 0.0?

per_error = [(abs((v_numerical_1(t_64)-v_redbull(t_64))/v_redbull(t_64)))*100, abs(((v_numerical_1(t_170)-v_redbull(t_170))/v_redbull(t_170)))*100 ];
fprintf('The percentage error at 64 and 170 secs is %1.1f and\n', per_error(1));
fprintf('%3.1f  respectively \n', per_error(2));

% Part 6 
% You'll need to repeat your euler loop here again but this time
% update the drag constant at every timestamp and change the update
% calculation to allow for the new v^2(t) term
% A hint here that now you have to calculate the velocity using the new
% differental equation
% constant .. put it in v_numerical_2
v_numerical_2 = v_redbull;

E = find(t_redbull == 100);

for k = (start): E
    drag_constant = (g)/(terminal_velocity(k))^2;
    v_delta = ((g) - (drag_constant)*(v_numerical_2(k-1))^2)*(t_redbull(k)-t_redbull(k-1));  
    v_numerical_2(k) = v_numerical_2(k-1) + v_delta;
end



% This is the handle plot for part 6. You have to plot the right stuff not
% this stuff.
% Note that the plot linewidth and colour are wrong. Fix it.
h_part6 = plot(t_redbull(16:E), v_numerical_2(16:E), 'black+--', 'linewidth', 2.0);
shg

est_error = (abs(v_redbull(t_100) - v_numerical_2(t_100))) * 100/v_redbull(t_100);
fprintf('The error at t = 100 secs using my estimated drag information is %f\n', est_error);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT EDIT BELOW THIS LINE THIS IS TO MAKE SURE YOU HAVE USED THE
% VARIABLES THAT WE ASKED FOR
% Check for existence of variables
if (~exist('v_freefall', 'var'))
  error('The variable v_freefall does not exist.')
end;
if (~exist('hit_instant', 'var'))
  error('The variable hit_instant does not exist.')
end;
if (~exist('per_error', 'var'))
  error('The variable per_error does not exist.')
end;
if (exist('per_error', 'var'))
  l = size(per_error);
  if ( sum(l - [1 2]) ~= 0)
    error('per_error is not a 2 element vector. Please make it so.')
  end;
end;
if (~exist('v_numerical_1', 'var'))
  error('The variable v_numerical_1 does not exist.')
end;  
if (~exist('est_error', 'var'))
  error('The variable est_error does not exist.')
end;  
if (~exist('h_part1', 'var'))
  error('The plot handle h_part11 is missing. Please create it as instructed.')
end;
if (~exist('h_part2', 'var'))
  error('The plot handle h_part11 is missing. Please create it as instructed.')
end;
if (~exist('h_part4', 'var'))
  error('The plot handle h_part11 is missing. Please create it as instructed.')
end;
if (~exist('h_part6', 'var'))
  error('The plot handle h_part11 is missing. Please create it as instructed.')
end;


