MOUNT_DIRECTORY=$HOME/docker/workspace_mounts/mtc
BASE_IMAGE=turlucode/ros-noetic:nvidia-dotfiles

docker run -it --gpus all --privileged --net=host --ipc=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
	-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
	-v $MOUNT_DIRECTORY:/root/catkin_ws \
	-v $HOME/.ssh:/root/.ssh \
	$BASE_IMAGE
