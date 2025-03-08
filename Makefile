python27:
	sudo apt install python2.7 -y 

pip27:
	wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
	sudo python2.7 get-pip.py

req:
	pip2.7 install -r requirements.txt
	sudo apt-get install libglib2.0-0 libsm6 libxext6 libxrender-dev -y
	


.PHONY: time_test
time_test:
	./time_test