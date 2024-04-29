include "map_builder.lua"
include "trajectory_builder.lua"

options = {
map_builder = MAP_BUILDER,
trajectory_builder = TRAJECTORY_BUILDER,
map_frame = "map",
tracking_frame = "imu_link",
published_frame = "odom",
odom_frame = "odom", 
provide_odom_frame = false,
publish_frame_projected_to_2d = false,
use_odometry = true,
use_nav_sat = false,
use_landmarks = false,
num_laser_scans = 0,
num_multi_echo_laser_scans = 0,
num_subdivisions_per_laser_scan = 1,
num_point_clouds = 1,
lookup_transform_timeout_sec = 0.2,
submap_publish_period_sec = 0.3,
pose_publish_period_sec = 5e-3,
trajectory_publish_period_sec = 30e-3,
rangefinder_sampling_ratio = 1.,
odometry_sampling_ratio = 1.,
fixed_frame_pose_sampling_ratio = 1.,
imu_sampling_ratio = 1.,
landmarks_sampling_ratio = 1.,
}

TRAJECTORY_BUILDER_3D.num_accumulated_range_data = 160 --한번 lidar 값을 갖을 때 포인트 클라우드를 누적할 갯수 160개의 점이 누적이 됨 

MAP_BUILDER.use_trajectory_builder_3d = true --3d mapping 하려면 필수 
MAP_BUILDER.num_background_threads = 7 --백그라운드에서 연살할 코어수 사양이 좋을 수록 높이면 좋음
POSE_GRAPH.optimization_problem.huber_scale = 5e2
POSE_GRAPH.optimize_every_n_nodes = 320 -- 높을수록 느리게 맵을 매칭함 
POSE_GRAPH.constraint_builder.sampling_ratio = 0.03 --
POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 10
POSE_GRAPH.constraint_builder.min_score = 0.62
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.66 --높일수록 기존의 localization을 유지하려는 경향이 있음 낮을수록 잘못된 localization을 반영하는 경우가 있음 

return options

--global_sampling_ratio -> scam 값과 map의 매칭을 통해 localization 주기를 높음 값이 낮을수록 더 자주 매칭하려함 
--adaptive voxel filter -> 스캔한 점의 해상도를 결정 

