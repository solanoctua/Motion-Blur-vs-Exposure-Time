# Motion-Blur-vs-Exposure-Time
The script calculates the maximum allowable exposure time for a camera to avoid motion blur that exceeds a specified threshold. This is crucial in scenarios requiring high precision, such as optical target tracking.

## Key Concepts

- **Motion Blur**: The streaking of moving objects in an image occurs when the object moves during the camera's exposure time.
- **Exposure Time (`t_exp`)**: The amount of time the camera's sensor is exposed to light. A shorter exposure time can reduce motion blur.
- **Relative Velocity (`v_rel`)**: The velocity of the target relative to the camera.
- **Focal Length (`focal_len`)**: The distance between the lens and the image sensor when the subject is in focus, measured in millimeters.
- **Pixel Size (`px_size`)**: The physical size of each pixel on the camera's sensor.
- **Motion Blur Threshold (`blur_thresh`)**: The maximum acceptable amount of motion blur, typically expressed in terms of pixel displacement.

## Formulation

The script calculates the maximum allowable exposure time (`t_exp`) based on the given motion blur threshold (`blur_thresh`). The relationship is derived from the basic motion blur equation:

Motion Blur = (v_rel × t_exp × focal_len) / (z × px_size)

Where:

- `v_rel` is the relative velocity of the target.
- `t_exp` is the exposure time.
- `focal_len` is the focal length.
- `z` is the distance to the target.
- `px_size` is the pixel size.

To find the exposure time, the equation is rearranged as follows:

t_exp = (blur_thresh × z × px_size) / (v_rel × focal_len)

This formula allows you to calculate the maximum exposure time that will keep motion blur within the acceptable threshold.

