name             'tango'
maintainer       'INAF OATe'
maintainer_email 'matteo@oa-teramo.inaf.it'
license          'All rights reserved'
description      'Installs/Configures Tango controls framework'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'mysql2_chef_gem', '~> 1.0.2'
depends 'mysql', '~> 6.1.2'
depends 'database', '~> 4.0.9'
depends "python"

