hdfs dfs -mkdir -p /hive_data/claim/
hdfs dfs -mkdir -p /hive_data/cost_savings/
hdfs dfs -mkdir -p /hive_data/finance/tax_2009/
hdfs dfs -mkdir -p /hive_data/finance/tax_2010/
hdfs dfs -mkdir -p /hive_data/finance/tax_2015/
hdfs dfs -mkdir -p /hive_data/hortoniabank/eu_countries/
hdfs dfs -mkdir -p /hive_data/hortoniabank/us_customers/
hdfs dfs -mkdir -p /hive_data/hortoniabank/ww_customers/

hdfs dfs -put data/claims_provider_summary_data.csv /hive_data/claim/
hdfs dfs -put data/claim-savings.csv                /hive_data/cost_savings/
hdfs dfs -put data/tax_2009.csv                     /hive_data/finance/tax_2009/
hdfs dfs -put data/tax_2010.csv                     /hive_data/finance/tax_2010/
hdfs dfs -put data/tax_2015.csv                     /hive_data/finance/tax_2015/
hdfs dfs -put data/eu_countries.csv                 /hive_data/hortoniabank/eu_countries/
hdfs dfs -put data/us_customers_data.csv            /hive_data/hortoniabank/us_customers/
hdfs dfs -put data/ww_customers_data.csv            /hive_data/hortoniabank/ww_customers/

hdfs dfs -chown -R hive:hive /hive_data/
