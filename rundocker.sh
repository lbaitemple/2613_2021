sudo apt  install docker-compose -y
sudo usermod -aG docker $USER
cd wireless && docker-compose build
