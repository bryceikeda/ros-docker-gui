docker run -it --gpus all --privileged --net=host --ipc=host \
	-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
	-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
	-v $HOME/ros/robot_programming_ws:/root/catkin_ws \
	-v $HOME/.ssh:/root/.ssh \
	turlucode/ros-noetic:nvidia-dotfiles
