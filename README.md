# Motion-Blur-vs-Exposure-Time
The script calculates the maximum allowable exposure time for a camera to avoid motion blur that exceeds a specified threshold. This is crucial in scenarios requiring high precision, such as optical target tracking.

## Why We Bother

Motion blur is a critical factor in achieving high precision in optical target tracking systems. Ideally, motion blur should not exceed 10% of the pixel size to ensure that the image remains sharp and the target can be accurately detected and tracked.

When motion blur exceeds the acceptable threshold, it can cause the target to spread across multiple pixels, reducing the clarity of the image. This degradation makes it challenging to accurately identify and track the target, potentially leading to errors in measurement and analysis.

Larger targets may tolerate slightly more blur compared to smaller ones. However, the tolerance depends on the specific algorithm used for detection and tracking. For algorithms that rely on high-resolution detail, even minor blur can impact their effectiveness.

## Formulation

Motion blur occurs when a target or the camera moves while the camera's shutter is open. The moving target will spread across several pixels on the sensor, resulting in blur. The amount of motion blur depends on:
- **Exposure Time (`t_exp`)**: The time the camera's sensor is exposed to light.
- **Relative Velocity (`v_rel`)**: The speed of the target relative to the camera.
- **Distance to Target (`z`)**: The distance between the camera and the target.
- **Focal Length (`f`)**: The distance between the lens and the sensor, measured in millimeters.
- **Pixel Size (`px_size`)**: The physical size of each pixel on the sensor, measured in millimeters.

### Motion Blur Equation

The amount of motion blur in pixels can be expressed as:

Motion Blur = (v_rel × t_exp × f) / (z × px_size)

To find the exposure time, the equation is rearranged as follows:

t_exp = (blur_thresh × z × px_size) / (v_rel × f)

This formula allows you to calculate the maximum exposure time that will keep motion blur within the acceptable threshold.

## Inputs

The script requires the following inputs:

1. **Camera Parameters:**
   - **`res_h_px`**: Height of the camera sensor's resolution in pixels.
   - **`res_w_px`**: Width of the camera sensor's resolution in pixels.
   - **`focal_len_mm`**: Focal length of the camera lens in millimeters.
   - **`sens_w_mm`**: Width of the camera sensor in millimeters.
   - **`sens_h_mm`**: Height of the camera sensor in millimeters.

   *Note: Some values are automatically computed from the resolution and sensor size. However, if you have the camera calibration matrix values (`f_x_px`, `f_y_px`, `c_x_px`, `c_y_px`), you may directly input those to the respective variables.*

2. **Target and Camera Motion Parameters:**
   - **`dist_to_tgt_m`**: Perpendicular distance from the camera to the target in meters.
   - **`tgt_w_m`**: Width of the target in meters.
   - **`tgt_h_m`**: Height of the target in meters.
   - **`tgt_vel_h_m_s`**: Speed of the target relative to the camera in the horizontal direction in meters per second (m/s).
   - **`tgt_vel_v_m_s`**: Speed of the target relative to the camera in the vertical direction in meters per second (m/s).

3. **Motion Blur Parameters:**
   - **`tgt_disp_m`**: Displacement of the target in the real world (in meters).
   - **`blur_thresh_px`**: The maximum allowable motion blur, typically expressed in terms of pixel displacement (in pixels).

These inputs are used by the script to calculate the maximum exposure time (`exp_time_h_s`, `exp_time_v_s`) that ensures motion blur does not exceed the specified threshold.
