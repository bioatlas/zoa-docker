#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    create extension if not exists "uuid-ossp";
	alter table geometry_columns owner to oztrack;
	alter table spatial_ref_sys owner to oztrack;
	alter view geography_columns owner to oztrack;
EOSQL

