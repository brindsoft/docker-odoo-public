apt update && upgrade
apt install vim docker.io docker-compose -y
apt install postgresql postgresql-contrib postgresql-client -y
mkdir -p /opt/.local/share/Odoo/filestore80/ /opt/.local/share/Odoo/filestore90 /opt/.local/share/Odoo/filestore100 /opt/.local/share/Odoo/filestore110 /opt/.local/share/Odoo/filestore120 /opt/.local/share/Odoo/filestore130