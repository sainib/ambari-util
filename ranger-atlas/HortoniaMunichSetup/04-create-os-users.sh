groupadd us_employee
groupadd eu_employee
groupadd analyst
groupadd hr
useradd -g analyst joe_analyst
useradd -g hr kate_hr
useradd -g hr sasha_eu_hr
useradd -g hr ivanna_eu_hr
usermod -a -G us_employee joe_analyst
usermod -a -G us_employee kate_hr
usermod -a -G eu_employee sasha_eu_hr
usermod -a -G eu_employee ivanna_eu_hr

groupadd finance
groupadd business_dev
groupadd contractor
groupadd csr
groupadd etluser
useradd -g finance john_finance
useradd -g business_dev mark_bizdev
useradd -g contractor jermy_contractor
useradd -g csr diane_csr
useradd -g etluser log_monitor
