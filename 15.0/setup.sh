#!/bin/bash
# get addons path
addons_path=$(ls -d /opt/odoo/extra-addons/* | paste -d, -s)
# can't use / because directory name contains, using #
sed -ie "s#__addons__path__#${addons_path}#g" /opt/odoo/etc/odoo.conf
source /opt/.env
sed -ie "s#__db_host__#${db_host}#g" /opt/odoo/etc/odoo.conf
#admin password
sed -ie "s#__admin_passwd__#${admin_passwd}#g" /opt/odoo/etc/odoo.conf
#db password
sed -ie "s#__db_password__#${db_password}#g" /opt/odoo/etc/odoo.conf
#db port
sed -ie "s#__db_port__#${db_port}#g" /opt/odoo/etc/odoo.conf
#db user
sed -ie "s#__db_user__#${db_user}#g" /opt/odoo/etc/odoo.conf
#db filter
sed -ie "s#__dbfilter__#${dbfilter}#g" /opt/odoo/etc/odoo.conf
