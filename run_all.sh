#!/bin/bash
# Rebuilds the database from scratch and captures every output
cd "$(dirname "$0")"; mkdir -p outputs
mysql -uroot -t     < 01_ddl.sql                  > outputs/01_ddl.out 2>&1
mysql -uroot -t     < 02_dml.sql                  > outputs/02_dml.out 2>&1
mysql -uroot -t -vv --force < 03_constraint_tests.sql > outputs/03_constraint_tests.out 2>&1
mysql -uroot -t     < 04_single_row_functions.sql > outputs/04_single_row_functions.out 2>&1
mysql -uroot -t     < 05_operators_group_functions.sql > outputs/05_operators_group_functions.out 2>&1
mysql -uroot -t     < 06_joins_subqueries_views.sql    > outputs/06_joins_subqueries_views.out 2>&1
mysql -uroot -t     < 07_procedures_functions_cursors_triggers.sql > outputs/07_procedural.out 2>&1
mysql -uroot -t -vv --force < 08_section5_demo.sql > outputs/08_section5_demo.out 2>&1
