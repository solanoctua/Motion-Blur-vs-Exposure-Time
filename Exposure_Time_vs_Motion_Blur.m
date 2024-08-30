%% Explanation
% The script calculates the maximum allowable exposure time for a camera to avoid motion blur
% that exceeds a specified threshold. This is crucial in scenarios requiring high precision,
% such as optical target tracking.

%% Formulation
% Motion blur occurs when a target or the camera moves while the camera's shutter is open.
% The moving target will spread across several pixels on the sensor, resulting in blur.
% The amount of motion blur depends on:
% - Exposure Time (t_exp): The time the camera's sensor is exposed to light.
% - Relative Velocity (v_rel): The speed of the target relative to the camera.
% - Distance to Target (z): The distance between the camera and the target.
% - Focal Length (f): The distance between the lens and the sensor, measured in millimeters.
% - Pixel Size (px_size): The physical size of each pixel on the sensor, measured in millimeters.

% The amount of motion blur in pixels can be expressed as:
% Motion Blur = (v_rel × t_exp × f) / (z × px_size)

% To find the exposure time, the equation is rearranged as follows:
% t_exp = (blur_thresh × z × px_size) / (v_rel × f)
% This formula allows you to calculate the maximum exposure time that will keep motion blur
% within the acceptable threshold.

%% Clear previous data
clear;
clc;

format long G

%% CAMERA INTRINSIC PARAMETERS
% Inputs
res_h_px = 960;    % Image height in pixels
res_w_px = 1280;   % Image width in pixels
focal_len_mm = 4; % Focal length of the lens in millimeters
sens_w_mm = 5.7;   % Sensor width in millimeters
sens_h_mm = 4.28;   % Sensor height in millimeters

% Calculations
px_size_mm = sens_w_mm / res_w_px; % Pixel size in millimeters
c_x_px = res_w_px / 2;             % Principal point X-coordinate in pixels
c_y_px = res_h_px / 2;             % Principal point Y-coordinate in pixels
f_x_px = focal_len_mm * res_w_px / sens_w_mm;  % Focal length in X direction (pixels)
f_y_px = focal_len_mm * res_h_px / sens_h_mm;  % Focal length in Y direction (pixels)

% Field of View (FoV) Calculations
fov_h_deg = 2 * rad2deg(atan(sens_w_mm / (2 * focal_len_mm))); % Horizontal FoV in degrees
fov_v_deg = 2 * rad2deg(atan(sens_h_mm / (2 * focal_len_mm))); % Vertical FoV in degrees

%% TARGET AND CAMERA MOTION PARAMETERS
% Inputs
dist_to_tgt_m = 50;      % Perpendicular distance to target in meters
tgt_w_m = 0.5;           % Target width in meters
tgt_h_m = 1.8;           % Target height in meters
tgt_vel_h_m_s = 35;      % Horizontal target speed in meters per second
tgt_vel_v_m_s = 1;       % Vertical target speed in meters per second

% Calculations
fov_w_at_dist_m = 2 * tand(fov_h_deg / 2) * dist_to_tgt_m; % FoV width at target distance in meters
fov_h_at_dist_m = 2 * tand(fov_v_deg / 2) * dist_to_tgt_m; % FoV height at target distance in meters
px_per_m_h = res_w_px / fov_w_at_dist_m;   % Pixels per meter horizontally at target distance
px_per_m_v = res_h_px / fov_h_at_dist_m;   % Pixels per meter vertically at target distance

tgt_px_w_at_dist = f_x_px * tgt_w_m / dist_to_tgt_m;   % Target width in pixels at given distance
tgt_px_h_at_dist = f_y_px * tgt_h_m / dist_to_tgt_m;   % Target height in pixels at given distance

%% MOTION BLUR PARAMETERS
% Inputs
tgt_disp_m = 1;        % Target displacement in the world in meters
blur_thresh_px = 1;    % Allowed motion blur threshold in pixels

% Calculations
tgt_disp_px_h = f_x_px * tgt_disp_m / dist_to_tgt_m; % Displacement in pixels horizontally
tgt_disp_px_v = f_y_px * tgt_disp_m / dist_to_tgt_m; % Displacement in pixels vertically

travel_dist_px_h_m = blur_thresh_px * dist_to_tgt_m / f_x_px; % Target travel distance causing pixel change horizontally
travel_dist_px_v_m = blur_thresh_px * dist_to_tgt_m / f_y_px; % Target travel distance causing pixel change vertically

exp_time_h_s = travel_dist_px_h_m / tgt_vel_h_m_s; % Needed exposure time for horizontal motion blur threshold
exp_time_v_s = travel_dist_px_v_m / tgt_vel_v_m_s; % Needed exposure time for vertical motion blur threshold

%% RESULTS OUTPUT
fprintf("Target size (W, H): (%.2f, %.2f) meters\n", tgt_w_m, tgt_h_m);
fprintf("Distance to target: %.2f meters\n", dist_to_tgt_m);
fprintf("Allowed motion blur: %.2f pixels\n", blur_thresh_px);
fprintf("Motion blur as %% of target height: %.2f%% \n", (blur_thresh_px / tgt_px_h_at_dist) * 100);
fprintf("Motion blur as %% of target width: %.2f%% \n", (blur_thresh_px / tgt_px_w_at_dist) * 100);
fprintf("Target pixel size (W, H) at distance %.2f meters: (%.2f, %.2f) pixels\n\n", dist_to_tgt_m, tgt_px_w_at_dist, tgt_px_h_at_dist);

fprintf("Horizontal target speed: %.2f m/s\n", tgt_vel_h_m_s);
fprintf("Exposure time for %.2f pixel blur at %.2f meters and %.2f m/s: %f s\n", blur_thresh_px, dist_to_tgt_m, tgt_vel_h_m_s, exp_time_h_s);
fprintf("Exposure time for %.2f pixel blur at %.2f meters and %.2f m/s: %f ms\n\n", blur_thresh_px, dist_to_tgt_m, tgt_vel_h_m_s, exp_time_h_s * 1000);

fprintf("Vertical target speed: %.2f m/s\n", tgt_vel_v_m_s);
fprintf("Exposure time for %.2f pixel blur at %.2f meters and %.2f m/s: %f s\n", blur_thresh_px, dist_to_tgt_m, tgt_vel_v_m_s, exp_time_v_s);
fprintf("Exposure time for %.2f pixel blur at %.2f meters and %.2f m/s: %f ms\n", blur_thresh_px, dist_to_tgt_m, tgt_vel_v_m_s, exp_time_v_s * 1000);
