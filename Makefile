# If the first argument is ...
ifneq (,$(findstring tools_,$(firstword $(MAKECMDGOALS))))
	# use the rest as arguments
	RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	# ...and turn them into do-nothing targets
	#$(eval $(RUN_ARGS):;@:)
endif


.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-42s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
## MELODIC

nvidia_ros_melodic: ## [NVIDIA] Build ROS  Melodic Container
	docker build -t turlucode/ros-melodic:nvidia -f nvidia/melodic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:nvidia\033[0m\n"

nvidia_ros_melodic_cuda10: nvidia_ros_melodic ## [NVIDIA] Build ROS  Melodic Container | (CUDA 10     - no cuDNN)
	docker build -t turlucode/ros-melodic:cuda10 -f nvidia/melodic/cuda10/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda10\033[0m\n"

nvidia_ros_melodic_cuda10-1: nvidia_ros_melodic ## [NVIDIA] Build ROS  Melodic Container | (CUDA 10.1   - no cuDNN)
	docker build -t turlucode/ros-melodic:cuda10.1 -f nvidia/melodic/cuda10.1/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda10.1\033[0m\n"

nvidia_ros_melodic_cuda10_cudnn7: nvidia_ros_melodic_cuda10 ## [NVIDIA] Build ROS  Melodic Container | (CUDA 10     - cuDNN 7)
	docker build -t turlucode/ros-melodic:cuda10-cudnn7 -f nvidia/melodic/cuda10/cudnn7/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda10-cudnn7\033[0m\n"

nvidia_ros_melodic_cuda10-1_cudnn7: nvidia_ros_melodic_cuda10-1 ## [NVIDIA] Build ROS  Melodic Container | (CUDA 10.1   - cuDNN 7)
	docker build -t turlucode/ros-melodic:cuda10.1-cudnn7 -f nvidia/melodic/cuda10.1/cudnn7/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda10.1-cudnn7\033[0m\n"
	
nvidia_ros_melodic_cuda11-4-2: nvidia_ros_melodic ## [NVIDIA] Build ROS  Melodic Container | (CUDA 11.4.2 - no cuDNN)
	docker build -t turlucode/ros-melodic:cuda11.4.2 -f nvidia/melodic/cuda11.4.2/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda11.4.2\033[0m\n"
	
nvidia_ros_melodic_cuda11-4-2_cudnn8: nvidia_ros_melodic_cuda11-4-2 ## [NVIDIA] Build ROS  Melodic Container | (CUDA 11.4.2 - cuDNN 8)
	docker build -t turlucode/ros-melodic:cuda11.4.2-cudnn8 -f nvidia/melodic/cuda11.4.2/cudnn8/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cuda11.4.2-cudnn8\033[0m\n"

## NOETIC

nvidia_ros_noetic: ## [NVIDIA] Build ROS  Noetic  Container
	docker build -t turlucode/ros-noetic:nvidia -f nvidia/noetic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:nvidia\033[0m\n"

nvidia_ros_noetic_cuda11-4-2: nvidia_ros_noetic ## [NVIDIA] Build ROS  Noetic  Container | (CUDA 11.4.2 - no cuDNN)
	docker build -t turlucode/ros-noetic:cuda11.4.2 -f nvidia/noetic/cuda11.4.2/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cuda11.4.2\033[0m\n"
	
nvidia_ros_noetic_cuda11-4-2_cudnn8: nvidia_ros_noetic_cuda11-4-2 ## [NVIDIA] Build ROS  Noetic  Container | (CUDA 11.4.2 - cuDNN 8)
	docker build -t turlucode/ros-noetic:cuda11.4.2-cudnn8 -f nvidia/noetic/cuda11.4.2/cudnn8/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cuda11.4.2-cudnn8\033[0m\n"

## BOUNCY

nvidia_ros_bouncy: ## [NVIDIA] Build ROS2 Bouncy  Container
	docker build -t turlucode/ros-bouncy:latest -f nvidia/bouncy/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-bouncy:latest\033[0m\n"

## Helper TASKS
nvidia_run_help: ## [NVIDIA] Prints help and hints on how to run an [NVIDIA]-based image
	 @printf "\n- Make sure the nvidia-docker-plugin (Test it with: docker run --rm --runtime=nvidia nvidia/cuda:9.0-base nvidia-smi)\n  - Command example:\ndocker run --rm -it --runtime=nvidia --privileged --net=host --ipc=host \\ \n-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \\ \n-v $HOME/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority \\ \n-v <PATH_TO_YOUR_CATKIN_WS>:/root/catkin_ws \\ \n-e ROS_IP=<HOST_IP or HOSTNAME> \\ \nturlucode/ros-indigo:nvidia\n"


# CPU
## MELODIC

cpu_ros_melodic: ## [CPU]    Build ROS  Melodic Container
	docker build -t turlucode/ros-melodic:cpu -f cpu/melodic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-melodic:cpu\033[0m\n"

## NOETIC

cpu_ros_noetic: ## [CPU]    Build ROS  Noetic  Container
	docker build -t turlucode/ros-noetic:cpu -f cpu/noetic/base/Dockerfile .
	@printf "\n\033[92mDocker Image: turlucode/ros-noetic:cpu\033[0m\n"

## Helper TASKS
cpu_run_help: ## [CPU]    Prints help and hints on how to run an [CPU]-based image
	 @printf "\nCommand example:\ndocker run --rm -it --runtime=nvidia --privileged --net=host --ipc=host \\ \n--device=/dev/dri:/dev/dri \\ \n-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \\ \n-v $HOME/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority \\ \n-v <PATH_TO_YOUR_CATKIN_WS>:/root/catkin_ws \\ \n-e ROS_IP=<HOST_IP or HOSTNAME> \\ \nturlucode/ros-indigo:cpu\n"

# TOOLS

tools_vscode: ## [Tools]  Create a new image that contains Visual Studio Code. Use it as "make tools_vscode <existing_docker_image>".
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-vscode tools/vscode
	@printf "\033[92mDocker Image: $(RUN_ARGS)-vscode\033[0m\n"

tools_canutils: ## [Tools]  Create a new image that contains Canutils. Use it as "make tools_canutils <existing_docker_image>".
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-canutils tools/canutils
	@printf "\033[92mDocker Image: $(RUN_ARGS)-canutils\033[0m\n"

tools_cannelloni: ## [Tools]  Create a new image that contains Cannelloni. Use it as "make tools_cannelloni <existing_docker_image>".
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-cannelloni tools/cannelloni
	@printf "\033[92mDocker Image: $(RUN_ARGS)-cannelloni\033[0m\n"

tools_cmake: ## [Tools]  Create a new image that contains CMake. Use it as "make tools_cmake <existing_docker_image>".
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-cmake tools/cmake
	@printf "\033[92mDocker Image: $(RUN_ARGS)-cmake\033[0m\n"

tools_dotfiles: ## [Tools]  Create a new image that contains personal dotfiles. Use it as "make tools_dotfiles <existing_docker_image>".
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-dotfiles tools/dotfiles
	@printf "\033[92mDocker Image: $(RUN_ARGS)-dotfiles\033[0m\n"

# ROS

ros_fetch_mtc: ## [ROS]    TODO: Create a new image with the moveit_task_constructor. Use it as "make ros_fetch_mtc <existing_docker_image>"
	docker build --build-arg="ARG_FROM=$(RUN_ARGS)" -t $(RUN_ARGS)-fetch-mtc ros_modules/fetch-mtc
	@printf "\033[92mDocker Image: $(RUN_ARGS)-fetch-mtc\033[0m\n"


# RUN
run_root_noetic_with_dotfiles: ## [RUN]    Run the image noetic with dotfiles. Use it as "make run_root_noetic_with_dotfiles"
	docker run -it --gpus all --privileged --net=host --ipc=host \
        -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$$DISPLAY \
        -v /home/bikeda/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority \
	-v /home/bikeda/docker/workspace_mounts/mtc:/root/catkin_ws \
        -v /home/bikeda/.ssh:/root/.ssh \
        turlucode/ros-noetic:nvidia-dotfiles

run_local_noetic_with_dotfiles: ## [RUN]    Run the image noetic with dotfiles. Use it as "make run_local_noetic_with_dotfiles"
	docker run -it --gpus all --privileged --net=host --ipc=host \
        -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$$DISPLAY \
        -v /home/bikeda/.Xauthority:/home/$$(id -un)/.Xauthority \
	-e XAUTHORITY=/home/$$(id -un)/.Xauthority \
	-v /home/bikeda/docker/workspace_mounts/mtc:/home/$$(id -un)/catkin_ws \
        -v /home/bikeda/.ssh:/root/.ssh \
        -e DOCKER_USER_NAME=$$(id -un) \
	-e DOCKER_USER_ID=$$(id -u) \
	-e DOCKER_USER_GROUP_NAME=$$(id -gn) \
	-e DOCKER_USER_GROUP_ID=$$(id -g) \
	turlucode/ros-noetic:nvidia-dotfiles


# START

start_noetic_with_dotfiles: ## [START]     Start the image noetic with dotfiles. Use it as "make start_noetic_with_dotfiles"
	docker 
 


