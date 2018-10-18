#/!bin/bash

echo 'COPY scripts to ~/knex-gen/scripts'
mkdir -p ~/knex-gen/scripts
cp -r ./scripts ~/knex-gen;
chmod 711 ~/knex-gen/scripts/monoScript.sh
chmod 711 ~/knex-gen/scripts/db-setup.sh
chmod 711 ~/knex-gen/scripts/write-router.sh
chmod 711 ~/knex-gen/scripts/write-model.sh
chmod 711 ~/knex-gen/scripts/write-controller.sh
chmod 711 ~/knex-gen/scripts/test-install.sh
read -p 'Enter path to desired app directory: ' app
mkdir -p $app;
cd $app;
echo 'Running knex-gen with ~/knex-gen/monoScript.sh'
~/knex-gen/scripts/monoScript.sh