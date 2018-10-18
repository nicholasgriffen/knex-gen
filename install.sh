read -p 'Enter path to desired install directory: ' path
echo 'copying scripts to '$path'/knex-gen'
cp ./scripts $path/knex-gen;
sudo chmod 711 $path/knex-gen/monoScript.sh
sudo chmod 711 $path/knex-gen/db-setup.sh
sudo chmod 711 $path/knex-gen/write-router.sh
sudo chmod 711 $path/knex-gen/write-model.sh
sudo chmod 711 $path/knex-gen/write-controller.sh
sudo chmod 711 $path/knex-gen/test-install.sh
echo 'Run knex-gen with '$path'/knex-gen/monoScript.sh'