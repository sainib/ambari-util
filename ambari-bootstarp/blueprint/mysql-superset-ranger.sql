
CREATE USER 'superset'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE superset DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'%' WITH GRANT OPTION; 

commit;

CREATE USER 'superset'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'superset'@'birens2' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'superset'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'superset'@'localhost' IDENTIFIED BY '9oNio)ex1ndL';

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'birens2' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'superset'@'localhost' WITH GRANT OPTION;

CREATE USER 'root'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;



CREATE USER 'rangeradmin'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE rangeradmin DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'rangeradmin'@'%' WITH GRANT OPTION; 

commit;

CREATE USER 'rangeradmin'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangeradmin'@'birens2' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangeradmin'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangeradmin'@'localhost' IDENTIFIED BY '9oNio)ex1ndL';

GRANT ALL PRIVILEGES ON *.* TO 'rangeradmin'@'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangeradmin'@'birens2' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangeradmin'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangeradmin'@'localhost' WITH GRANT OPTION;

CREATE USER 'root'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;


CREATE USER 'rangerdba'@'%' IDENTIFIED BY '9oNio)ex1ndL';

CREATE DATABASE rangerdba DEFAULT CHARACTER SET utf8;

GRANT ALL PRIVILEGES ON *.* TO 'rangerdba'@'%' WITH GRANT OPTION; 

commit;

CREATE USER 'rangerdba'@'127.0.0.1' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangerdba'@'birens2' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangerdba'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL';

CREATE USER 'rangerdba'@'localhost' IDENTIFIED BY '9oNio)ex1ndL';

GRANT ALL PRIVILEGES ON *.* TO 'rangerdba'@'%' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangerdba'@'birens2' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangerdba'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'rangerdba'@'localhost' WITH GRANT OPTION;

CREATE USER 'root'@'birens2.field.hortonworks.com' IDENTIFIED BY '9oNio)ex1ndL'; 

GRANT ALL PRIVILEGES ON *.* TO 'root'@'birens2.field.hortonworks.com' WITH GRANT OPTION;

commit;

FLUSH PRIVILEGES;
