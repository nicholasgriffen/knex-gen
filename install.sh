#/!bin/bash

echo 'COPY scripts to ~/knex-gen/scripts'
sudo mkdir -p ~/knex-gen/scripts
sudo cp -r ./scripts ~/knex-gen;
sudo chmod 711 ~/knex-gen/scripts/monoScript.sh
sudo chmod 711 ~/knex-gen/scripts/db-setup.sh
sudo chmod 711 ~/knex-gen/scripts/write-router.sh
sudo chmod 711 ~/knex-gen/scripts/write-model.sh
sudo chmod 711 ~/knex-gen/scripts/write-controller.sh
sudo chmod 711 ~/knex-gen/scripts/test-install.sh
read -p 'Enter path to desired app directory: ' app
mkdir -p $app;
cd $app;
echo 'Running knex-gen with ~/knex-gen/monoScript.sh'
sudo ~/knex-gen/scripts/monoScript.sh