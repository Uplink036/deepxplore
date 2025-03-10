sudo apt update 
sudo apt upgrade -y 
sudo apt install bc
make python27
make pip27
make req

sudo apt install python3-pip -y
pip install -r noteboke_req.txt
python3 -m pip install ipykernel -U --user --force-reinstall
