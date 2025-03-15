docker run -d --cap-add=NET_ADMIN --privileged --net host -e JUPYTER_LAB_PORT=8889 -it -v /home/rocky/work:/home/fabric/work --name fabric_bleeding_edge fabric_rocky9_fablib_env:bleeding_edge
